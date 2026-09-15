// Phase 2 smoke tests for the database schema. These run against an
// in-memory SQLite database (no file touched on disk) and prove:
// - a Word can be inserted with its Vietnamese + Italian translations
// - the Word <-> Tag many-to-many relationship works both directions
// - a ReviewSession/ReviewHistory round trip works
// - deleting a Word cascades to its WordTags links and ReviewHistory rows

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/tables/review_history_table.dart';
import 'package:vocab_library/database/tables/review_sessions_table.dart';
import 'package:vocab_library/database/tables/words_table.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('insert word with vi/it translations and attach two tags', () async {
    final tagItId = await db
        .into(db.tags)
        .insert(TagsCompanion.insert(name: 'IT'));
    final tagB1Id = await db
        .into(db.tags)
        .insert(TagsCompanion.insert(name: 'B1'));

    final wordId = await db
        .into(db.words)
        .insert(
          WordsCompanion.insert(
            word: 'efficient',
            meaning: const Value('làm việc tốt, không lãng phí'),
            translation: const Value('hiệu quả'),
            italianTranslation: const Value('efficiente'),
          ),
        );

    await db
        .into(db.wordTags)
        .insert(WordTagsCompanion.insert(wordId: wordId, tagId: tagItId));
    await db
        .into(db.wordTags)
        .insert(WordTagsCompanion.insert(wordId: wordId, tagId: tagB1Id));

    final storedWord = await (db.select(
      db.words,
    )..where((w) => w.id.equals(wordId))).getSingle();

    expect(storedWord.word, 'efficient');
    expect(storedWord.translation, 'hiệu quả');
    expect(storedWord.italianTranslation, 'efficiente');
    // Never set explicitly above -> proves the column-level DEFAULT works.
    expect(storedWord.status, WordStatus.newWord);
    expect(storedWord.stepIndex, 0);

    final tagsForWord =
        await (db.select(db.wordTags).join([
              innerJoin(db.tags, db.tags.id.equalsExp(db.wordTags.tagId)),
            ])..where(db.wordTags.wordId.equals(wordId)))
            .map((row) => row.readTable(db.tags))
            .get();

    expect(tagsForWord.map((t) => t.name), containsAll(['IT', 'B1']));

    final wordsForItTag =
        await (db.select(db.wordTags).join([
              innerJoin(db.words, db.words.id.equalsExp(db.wordTags.wordId)),
            ])..where(db.wordTags.tagId.equals(tagItId)))
            .map((row) => row.readTable(db.words))
            .get();

    expect(wordsForItTag.map((w) => w.word), ['efficient']);
  });

  test('review session + review history round trip', () async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'consequently'));

    final sessionId = await db
        .into(db.reviewSessions)
        .insert(
          ReviewSessionsCompanion.insert(sourceType: ReviewSourceType.due),
        );

    await db
        .into(db.reviewHistory)
        .insert(
          ReviewHistoryCompanion.insert(
            wordId: wordId,
            reviewSessionId: sessionId,
            questionType: ReviewQuestionType.wordToMeaning,
            isCorrect: true,
            rating: ReviewRating.good,
          ),
        );

    final history = await (db.select(
      db.reviewHistory,
    )..where((h) => h.wordId.equals(wordId))).get();

    expect(history, hasLength(1));
    expect(history.single.rating, ReviewRating.good);
    expect(history.single.questionType, ReviewQuestionType.wordToMeaning);
  });

  test(
    'deleting a word cascades to its tag links and review history',
    () async {
      final tagId = await db
          .into(db.tags)
          .insert(TagsCompanion.insert(name: 'IT'));
      final wordId = await db
          .into(db.words)
          .insert(WordsCompanion.insert(word: 'deprecated'));
      await db
          .into(db.wordTags)
          .insert(WordTagsCompanion.insert(wordId: wordId, tagId: tagId));
      final sessionId = await db
          .into(db.reviewSessions)
          .insert(
            ReviewSessionsCompanion.insert(
              sourceType: ReviewSourceType.newWords,
            ),
          );
      await db
          .into(db.reviewHistory)
          .insert(
            ReviewHistoryCompanion.insert(
              wordId: wordId,
              reviewSessionId: sessionId,
              questionType: ReviewQuestionType.wordToMeaning,
              isCorrect: false,
              rating: ReviewRating.forgot,
            ),
          );

      await (db.delete(db.words)..where((w) => w.id.equals(wordId))).go();

      final remainingLinks = await db.select(db.wordTags).get();
      final remainingHistory = await db.select(db.reviewHistory).get();
      // The tag itself must survive - only the link to the deleted word goes.
      final remainingTags = await db.select(db.tags).get();

      expect(remainingLinks, isEmpty);
      expect(remainingHistory, isEmpty);
      expect(remainingTags, hasLength(1));
    },
  );
}
