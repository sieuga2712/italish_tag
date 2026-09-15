// Phase 5 repository tests, run against an in-memory database:
// - createTag/renameTag reject case-insensitive duplicates
// - deleting a tag removes the WordTags link but keeps the word
// - watchTagsWithCounts reflects how many words carry each tag
// - addTagToWord is idempotent; watchWordsForTag only returns tagged words

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/repositories/tag_repository.dart';
import 'package:vocab_library/repositories/word_repository.dart';

void main() {
  late AppDatabase db;
  late TagRepository tagRepo;
  late WordRepository wordRepo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    tagRepo = TagRepository(db);
    wordRepo = WordRepository(db);
  });

  tearDown(() => db.close());

  test('createTag rejects a case-insensitive duplicate', () async {
    await tagRepo.createTag('IT');
    expect(
      () => tagRepo.createTag('it'),
      throwsA(isA<DuplicateTagException>()),
    );
  });

  test(
    'renameTag rejects duplicates but allows keeping its own name',
    () async {
      final itId = await tagRepo.createTag('IT');
      await tagRepo.createTag('B1');

      expect(
        () => tagRepo.renameTag(itId, 'b1'),
        throwsA(isA<DuplicateTagException>()),
      );

      // Excludes itself from the uniqueness check, so this must not throw.
      await tagRepo.renameTag(itId, 'IT');

      await tagRepo.renameTag(itId, 'Programming');
      final tags = await tagRepo.watchAllTags().first;
      expect(tags.map((t) => t.name), containsAll(['Programming', 'B1']));
    },
  );

  test('deleting a tag removes the link but keeps the word', () async {
    final tagId = await tagRepo.createTag('IT');
    final wordId = await wordRepo.quickAdd('efficient');
    await tagRepo.addTagToWord(wordId, tagId);

    await tagRepo.deleteTag(tagId);

    expect(await tagRepo.watchAllTags().first, isEmpty);
    final word = await (db.select(
      db.words,
    )..where((w) => w.id.equals(wordId))).getSingleOrNull();
    expect(word, isNotNull);
  });

  test('watchTagsWithCounts reflects how many words carry each tag', () async {
    final tagId = await tagRepo.createTag('IT');
    final word1 = await wordRepo.quickAdd('efficient');
    final word2 = await wordRepo.quickAdd('deprecated');

    expect((await tagRepo.watchTagsWithCounts().first).single.wordCount, 0);

    await tagRepo.addTagToWord(word1, tagId);
    await tagRepo.addTagToWord(word2, tagId);

    expect((await tagRepo.watchTagsWithCounts().first).single.wordCount, 2);
  });

  test('addTagToWord is idempotent', () async {
    final tagId = await tagRepo.createTag('IT');
    final wordId = await wordRepo.quickAdd('efficient');

    await tagRepo.addTagToWord(wordId, tagId);
    await tagRepo.addTagToWord(wordId, tagId);

    expect(await tagRepo.watchTagsForWord(wordId).first, hasLength(1));
  });

  test('watchWordsForTag returns only words carrying that tag', () async {
    final tagId = await tagRepo.createTag('IT');
    final taggedWordId = await wordRepo.quickAdd('efficient');
    await wordRepo.quickAdd('unrelated');
    await tagRepo.addTagToWord(taggedWordId, tagId);

    final words = await tagRepo.watchWordsForTag(tagId).first;
    expect(words.map((w) => w.word), ['efficient']);
  });
}
