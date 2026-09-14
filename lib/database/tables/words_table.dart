import 'package:drift/drift.dart';

/// Learning status of a word.
///
/// This is never set directly by the UI — it is derived from `stepIndex`
/// and the most recent rating inside `ReviewScheduler` (Phase 7), then
/// written back here so list/filter queries stay fast.
///
/// Named `newWord` (not `new`) because `new` is a reserved word in Dart.
enum WordStatus { newWord, learning, reviewing, mastered }

@DataClassName('Word')
@TableIndex(name: 'words_next_review_at', columns: {#nextReviewAt})
@TableIndex(name: 'words_status', columns: {#status})
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// The English word or phrase.
  ///
  /// Enforced unique case-sensitively here. Case-insensitive duplicate
  /// checks (so "Efficient" is flagged against existing "efficient") are
  /// done at the repository layer with a `LOWER(word) = LOWER(?)` query,
  /// since Drift's table DSL has no first-class `COLLATE NOCASE` modifier.
  TextColumn get word => text().unique()();

  TextColumn get pronunciation => text().nullable()();
  TextColumn get partOfSpeech => text().nullable()();
  TextColumn get meaning => text().nullable()();

  /// Vietnamese translation.
  TextColumn get translation => text().nullable()();

  /// Italian translation.
  TextColumn get italianTranslation => text().nullable()();

  /// JSON-encoded `List<String>`. Encoded/decoded in the repository layer;
  /// a separate table isn't worth it since examples/synonyms/antonyms are
  /// always displayed as a whole, never queried individually.
  TextColumn get examplesJson => text().nullable()();
  TextColumn get synonymsJson => text().nullable()();
  TextColumn get antonymsJson => text().nullable()();

  TextColumn get notes => text().nullable()();

  BoolColumn get favorite => boolean().withDefault(const Constant(false))();

  TextColumn get status =>
      textEnum<WordStatus>().withDefault(const Constant('newWord'))();

  /// User's own subjective difficulty rating (1-5). Independent from the
  /// automatically-detected "weak word" concept, which is based on
  /// wrongCount/reviewCount instead.
  IntColumn get difficulty => integer().nullable()();

  /// Position on the fixed interval ladder used by `SimpleIntervalScheduler`
  /// (Phase 7). 0 = just reset/never reviewed.
  IntColumn get stepIndex => integer().withDefault(const Constant(0))();

  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get wrongCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastReviewedAt => dateTime().nullable()();

  /// Null until the word has been scheduled for the first time (i.e. still
  /// `newWord` and never reviewed).
  DateTimeColumn get nextReviewAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
