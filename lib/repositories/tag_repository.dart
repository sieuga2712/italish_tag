import 'package:drift/drift.dart';

import '../database/app_database.dart';

/// Thrown by [TagRepository.createTag]/[renameTag] when a tag with that
/// name already exists (case-insensitively — "it" is a duplicate of "IT").
class DuplicateTagException implements Exception {
  DuplicateTagException(this.name);

  final String name;

  @override
  String toString() => 'DuplicateTagException: "$name" already exists';
}

/// A tag paired with how many words currently have it, for the Tags screen
/// ("IT   124 words").
class TagWithCount {
  TagWithCount({required this.tag, required this.wordCount});

  final Tag tag;
  final int wordCount;
}

/// All database access for [Tag] rows and the Word<->Tag relationship goes
/// through here.
class TagRepository {
  TagRepository(this._db);

  final AppDatabase _db;

  Future<void> _ensureNameIsUnique(String name, {int? excludingTagId}) async {
    var query = _db.select(_db.tags)
      ..where((t) => t.name.lower().equals(name.toLowerCase()));
    if (excludingTagId != null) {
      query = query..where((t) => t.id.equals(excludingTagId).not());
    }
    final existing = await query.getSingleOrNull();
    if (existing != null) {
      throw DuplicateTagException(name);
    }
  }

  Future<int> createTag(String name, {String? color}) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Tag name must not be empty');
    }
    await _ensureNameIsUnique(trimmed);
    return _db
        .into(_db.tags)
        .insert(TagsCompanion.insert(name: trimmed, color: Value(color)));
  }

  Future<void> renameTag(int tagId, String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Tag name must not be empty');
    }
    await _ensureNameIsUnique(trimmed, excludingTagId: tagId);
    await (_db.update(_db.tags)..where((t) => t.id.equals(tagId))).write(
      TagsCompanion(name: Value(trimmed)),
    );
  }

  /// Deleting a tag cascades to its `WordTags` rows (see the FK definition
  /// on that table) — the words themselves are untouched, only the link to
  /// this tag disappears.
  Future<void> deleteTag(int tagId) {
    return (_db.delete(_db.tags)..where((t) => t.id.equals(tagId))).go();
  }

  /// Every tag with its word count, alphabetical, for the Tags screen.
  Stream<List<TagWithCount>> watchTagsWithCounts() {
    final wordCount = _db.wordTags.wordId.count();
    final query =
        _db.select(_db.tags).join([
            leftOuterJoin(
              _db.wordTags,
              _db.wordTags.tagId.equalsExp(_db.tags.id),
            ),
          ])
          ..addColumns([wordCount])
          ..groupBy([_db.tags.id])
          ..orderBy([OrderingTerm.asc(_db.tags.name)]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => TagWithCount(
              tag: row.readTable(_db.tags),
              wordCount: row.read(wordCount) ?? 0,
            ),
          )
          .toList(),
    );
  }

  /// Every tag, alphabetical, with no count — for pickers (e.g. the "assign
  /// a tag to this word" sheet) where the count isn't shown.
  Stream<List<Tag>> watchAllTags() {
    return (_db.select(
      _db.tags,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  /// Tags currently assigned to one word, for the enrichment sheet.
  Stream<List<Tag>> watchTagsForWord(int wordId) {
    final query = _db.select(_db.tags).join([
      innerJoin(_db.wordTags, _db.wordTags.tagId.equalsExp(_db.tags.id)),
    ])..where(_db.wordTags.wordId.equals(wordId));

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(_db.tags)).toList(),
    );
  }

  /// Words currently carrying one tag, for the "tap a tag to see its
  /// words" screen. Alphabetical only — this view is meant as a quick
  /// glance at one tag's words, not a full sortable list (that's what the
  /// Words tab's own tag-independent list is for).
  Stream<List<Word>> watchWordsForTag(int tagId) {
    final query = _db.select(_db.words).join([
      innerJoin(
        _db.wordTags,
        _db.wordTags.wordId.equalsExp(_db.words.id) &
            _db.wordTags.tagId.equals(tagId),
      ),
    ])..orderBy([OrderingTerm.asc(_db.words.word)]);

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(_db.words)).toList(),
    );
  }

  /// No-op if the word already has this tag (the composite primary key
  /// would otherwise throw a constraint violation on a duplicate insert).
  Future<void> addTagToWord(int wordId, int tagId) async {
    await _db
        .into(_db.wordTags)
        .insert(
          WordTagsCompanion.insert(wordId: wordId, tagId: tagId),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> removeTagFromWord(int wordId, int tagId) {
    return (_db.delete(
      _db.wordTags,
    )..where((wt) => wt.wordId.equals(wordId) & wt.tagId.equals(tagId))).go();
  }
}
