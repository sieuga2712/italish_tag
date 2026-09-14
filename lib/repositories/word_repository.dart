import 'dart:convert';

import 'package:drift/drift.dart';

import '../database/app_database.dart';

/// Thrown by [WordRepository.quickAdd] when a word already exists
/// (case-insensitively — "Efficient" is a duplicate of "efficient").
class DuplicateWordException implements Exception {
  DuplicateWordException(this.word);

  final String word;

  @override
  String toString() => 'DuplicateWordException: "$word" already exists';
}

/// All database access for [Word] rows goes through here — pages/widgets
/// never talk to [AppDatabase] directly.
class WordRepository {
  WordRepository(this._db);

  final AppDatabase _db;

  /// Saves just the word itself, nothing else — the whole point of Quick
  /// Add is that no other field is required up front. The new row starts
  /// with no tags, which is exactly what makes it show up in the Inbox.
  Future<int> quickAdd(String word) async {
    final trimmed = word.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Word must not be empty');
    }

    final existing =
        await (_db.select(_db.words)
              ..where((w) => w.word.lower().equals(trimmed.toLowerCase())))
            .getSingleOrNull();
    if (existing != null) {
      throw DuplicateWordException(trimmed);
    }

    return _db.into(_db.words).insert(WordsCompanion.insert(word: trimmed));
  }

  /// Words with zero tags — i.e. "not yet categorized". Newest first, since
  /// those are the ones the user just added and is most likely to want to
  /// finish filling in.
  Stream<List<Word>> watchInboxWords() {
    final query = _db.select(_db.words).join([
      leftOuterJoin(
        _db.wordTags,
        _db.wordTags.wordId.equalsExp(_db.words.id),
      ),
    ])
      ..where(_db.wordTags.tagId.isNull())
      ..orderBy([OrderingTerm.desc(_db.words.createdAt)]);

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(_db.words)).toList(),
    );
  }

  /// Fills in the fields Quick Add intentionally skips. This always writes
  /// a full snapshot of the enrichment form — a `null` argument clears that
  /// field (writes SQL NULL), it does not mean "leave unchanged". That
  /// matches its only caller, `CompleteWordSheet`, which always submits the
  /// whole form rather than a partial patch.
  ///
  /// `example` is a single string for now (Phase 3 keeps the enrichment
  /// form minimal); it replaces `examplesJson` as a 1-item list. Full
  /// multi-example editing belongs to the Word Detail screen (Phase 6).
  Future<void> updateEnrichment(
    int wordId, {
    required String? meaning,
    required String? translation,
    required String? italianTranslation,
    required String? example,
    required String? notes,
  }) {
    return (_db.update(_db.words)..where((w) => w.id.equals(wordId))).write(
      WordsCompanion(
        meaning: Value(meaning),
        translation: Value(translation),
        italianTranslation: Value(italianTranslation),
        examplesJson: Value(example == null ? null : jsonEncode([example])),
        notes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
