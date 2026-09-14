import 'package:drift/drift.dart';

import 'review_sessions_table.dart';
import 'words_table.dart';

/// Kind of question the user was asked. Kept separate from [ReviewRating]
/// because multiple-choice/fill-blank results are graded automatically
/// (isCorrect), while flashcard-style modes also collect a subjective
/// [ReviewRating] from the user.
enum ReviewQuestionType {
  wordToMeaning,
  meaningToWord,
  multipleChoice,
  fillBlank,
  sentenceContext,
  listening,
}

/// The 4-point rating shown after every question (😵😐🙂😎). For
/// auto-graded question types this is derived from correctness
/// (correct → good, wrong → forgot) rather than picked by the user.
enum ReviewRating { forgot, hard, good, easy }

/// One row per attempt at one word. This is the source of truth for
/// statistics; [Words] only keeps a denormalized cache
/// (reviewCount/correctCount/wrongCount) for fast list queries.
@DataClassName('ReviewHistoryEntry')
@TableIndex(name: 'review_history_word_id', columns: {#wordId})
@TableIndex(name: 'review_history_reviewed_at', columns: {#reviewedAt})
class ReviewHistory extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get wordId =>
      integer().references(Words, #id, onDelete: KeyAction.cascade)();

  /// Every review — even a single "Review this word" from the Word Detail
  /// screen — happens inside a session (a 1-word session in that case),
  /// so this is intentionally non-nullable.
  IntColumn get reviewSessionId => integer()
      .references(ReviewSessions, #id, onDelete: KeyAction.cascade)();

  TextColumn get questionType => textEnum<ReviewQuestionType>()();

  BoolColumn get isCorrect => boolean()();

  TextColumn get rating => textEnum<ReviewRating>()();

  /// Audit trail of the scheduler's decision, cheap to keep and useful for
  /// debugging "why did nextReviewAt change like that".
  IntColumn get previousStepIndex => integer().nullable()();
  IntColumn get newStepIndex => integer().nullable()();

  DateTimeColumn get reviewedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
