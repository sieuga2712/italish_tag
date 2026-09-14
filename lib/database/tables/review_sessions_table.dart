import 'package:drift/drift.dart';

/// Where a review session's word queue came from — used to reconstruct
/// what the user was doing when looking at review history later.
enum ReviewSourceType { due, weak, newWords, tag, mixed }

@DataClassName('ReviewSession')
class ReviewSessions extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get startedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Null while the session is still in progress.
  DateTimeColumn get finishedAt => dateTime().nullable()();

  TextColumn get sourceType => textEnum<ReviewSourceType>()();

  /// JSON-encoded `List<int>` of tag ids, only set when
  /// `sourceType == ReviewSourceType.tag`.
  TextColumn get sourceTagIdsJson => text().nullable()();

  IntColumn get totalWords => integer().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get wrongCount => integer().withDefault(const Constant(0))();

  /// Filled in when the session finishes.
  IntColumn get durationSeconds => integer().nullable()();
}
