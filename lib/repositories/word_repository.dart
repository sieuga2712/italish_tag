import 'dart:convert';

import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/tables/words_table.dart';

/// Thrown by [WordRepository.quickAdd] when a word already exists
/// (case-insensitively — "Efficient" is a duplicate of "efficient").
class DuplicateWordException implements Exception {
  DuplicateWordException(this.word);

  final String word;

  @override
  String toString() => 'DuplicateWordException: "$word" already exists';
}

/// How the Word List (Phase 4) narrows down which words to show.
///
/// [inbox] reuses the same "zero tags" concept from Phase 3's Inbox — it
/// isn't a stored value, so it stays a filter here rather than becoming a
/// fifth [WordStatus].
enum WordListFilter { all, inbox, newWord, learning, reviewing, mastered }

/// The 7 sort options from the design doc (A-Z, Z-A, Newest, Oldest, Most
/// reviewed, Least reviewed, Next review).
enum WordSortOption {
  alphabeticalAsc,
  alphabeticalDesc,
  newest,
  oldest,
  mostReviewed,
  leastReviewed,
  nextReviewSoonest,
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

  /// The Word List (Phase 4): every word, optionally narrowed by [filter]
  /// and [searchQuery], in the order given by [sort].
  ///
  /// [WordListFilter.inbox] is the only filter that needs a join (it looks
  /// at the `WordTags` table); every other filter only ever looks at
  /// columns on `Words` itself, so it queries that table directly instead
  /// of joining — no join means no risk of a word with multiple tags
  /// producing duplicate rows, so there is nothing to de-duplicate.
  Stream<List<Word>> watchWords({
    required WordListFilter filter,
    required WordSortOption sort,
    String searchQuery = '',
  }) {
    if (filter == WordListFilter.inbox) {
      final query = _db.select(_db.words).join([
        leftOuterJoin(
          _db.wordTags,
          _db.wordTags.wordId.equalsExp(_db.words.id),
        ),
      ])..where(_db.wordTags.tagId.isNull());

      final search = _searchCondition(searchQuery);
      if (search != null) query.where(search);
      query.orderBy(_orderingTerms(sort));

      return query.watch().map(
        (rows) => rows.map((row) => row.readTable(_db.words)).toList(),
      );
    }

    final query = _db.select(_db.words);

    final statusFilter = _statusFor(filter);
    if (statusFilter != null) {
      query.where((w) => w.status.equalsValue(statusFilter));
    }

    final search = _searchCondition(searchQuery);
    if (search != null) query.where((_) => search);

    // Plain (non-joined) selects take a list of `(table) => OrderingTerm`
    // generators rather than raw terms; the terms below don't need the
    // callback's table argument since they already reference `_db.words`.
    query.orderBy(
      _orderingTerms(sort)
          .map(
            (term) =>
                (_) => term,
          )
          .toList(),
    );

    return query.watch();
  }

  WordStatus? _statusFor(WordListFilter filter) => switch (filter) {
    WordListFilter.newWord => WordStatus.newWord,
    WordListFilter.learning => WordStatus.learning,
    WordListFilter.reviewing => WordStatus.reviewing,
    WordListFilter.mastered => WordStatus.mastered,
    WordListFilter.all || WordListFilter.inbox => null,
  };

  /// Matches [Words.word]/meaning/translation/italianTranslation/notes, and
  /// `examplesJson` (a plain substring match on the JSON text — good enough
  /// to find a word by something inside one of its examples without
  /// actually parsing the list).
  Expression<bool>? _searchCondition(String searchQuery) {
    final trimmed = searchQuery.trim().toLowerCase();
    if (trimmed.isEmpty) return null;

    final pattern = '%$trimmed%';
    return _db.words.word.lower().like(pattern) |
        _db.words.meaning.lower().like(pattern) |
        _db.words.translation.lower().like(pattern) |
        _db.words.italianTranslation.lower().like(pattern) |
        _db.words.notes.lower().like(pattern) |
        _db.words.examplesJson.lower().like(pattern);
  }

  List<OrderingTerm> _orderingTerms(WordSortOption sort) {
    return switch (sort) {
      WordSortOption.alphabeticalAsc => [OrderingTerm.asc(_db.words.word)],
      WordSortOption.alphabeticalDesc => [OrderingTerm.desc(_db.words.word)],
      WordSortOption.newest => [OrderingTerm.desc(_db.words.createdAt)],
      WordSortOption.oldest => [OrderingTerm.asc(_db.words.createdAt)],
      WordSortOption.mostReviewed => [OrderingTerm.desc(_db.words.reviewCount)],
      WordSortOption.leastReviewed => [OrderingTerm.asc(_db.words.reviewCount)],
      WordSortOption.nextReviewSoonest => [
        OrderingTerm.asc(_db.words.nextReviewAt, nulls: NullsOrder.last),
      ],
    };
  }

  Future<void> toggleFavorite(int wordId, bool favorite) {
    return (_db.update(_db.words)..where((w) => w.id.equals(wordId))).write(
      WordsCompanion(favorite: Value(favorite)),
    );
  }

  /// One word by id, live — for the Word Detail screen (Phase 6).
  Stream<Word> watchWord(int wordId) {
    return (_db.select(
      _db.words,
    )..where((w) => w.id.equals(wordId))).watchSingle();
  }

  /// The free-text fields on the Word Detail screen's "Save" button. This
  /// always writes a full snapshot — a `null` argument clears that field
  /// (writes SQL NULL), it does not mean "leave unchanged". List-shaped
  /// fields (examples/synonyms/antonyms) and tags are saved immediately by
  /// their own methods instead, since they're edited as add/remove actions
  /// rather than free text.
  Future<void> updateDetails(
    int wordId, {
    required String? pronunciation,
    required String? partOfSpeech,
    required String? meaning,
    required String? translation,
    required String? italianTranslation,
    required String? notes,
  }) {
    return (_db.update(_db.words)..where((w) => w.id.equals(wordId))).write(
      WordsCompanion(
        pronunciation: Value(pronunciation),
        partOfSpeech: Value(partOfSpeech),
        meaning: Value(meaning),
        translation: Value(translation),
        italianTranslation: Value(italianTranslation),
        notes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateExamples(int wordId, List<String> examples) {
    return _updateStringList(wordId, examplesJson: examples);
  }

  Future<void> updateSynonyms(int wordId, List<String> synonyms) {
    return _updateStringList(wordId, synonymsJson: synonyms);
  }

  Future<void> updateAntonyms(int wordId, List<String> antonyms) {
    return _updateStringList(wordId, antonymsJson: antonyms);
  }

  Future<void> _updateStringList(
    int wordId, {
    List<String>? examplesJson,
    List<String>? synonymsJson,
    List<String>? antonymsJson,
  }) {
    String? encode(List<String>? list) =>
        list == null ? null : (list.isEmpty ? null : jsonEncode(list));

    return (_db.update(_db.words)..where((w) => w.id.equals(wordId))).write(
      WordsCompanion(
        examplesJson: examplesJson == null
            ? const Value.absent()
            : Value(encode(examplesJson)),
        synonymsJson: synonymsJson == null
            ? const Value.absent()
            : Value(encode(synonymsJson)),
        antonymsJson: antonymsJson == null
            ? const Value.absent()
            : Value(encode(antonymsJson)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
