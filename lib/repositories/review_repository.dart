import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/tables/review_history_table.dart';
import '../database/tables/review_sessions_table.dart';
import '../database/tables/words_table.dart';
import '../review/review_scheduler.dart';

/// How many words are Due / Weak / New right now, for the Review tab's
/// "TODAY" summary.
class ReviewQueueCounts {
  ReviewQueueCounts({
    required this.due,
    required this.weak,
    required this.newWords,
  });

  final int due;
  final int weak;
  final int newWords;
}

/// All database access for building and running review sessions.
///
/// Due/Weak/New are computed by fetching every word and classifying it in
/// Dart rather than as SQL conditions — a personal vocabulary is small
/// enough that this is simpler and just as fast as expressing "wrong rate
/// >= 30%" as a SQL comparison, and it keeps the classification rules
/// (shared between the queue builder and the summary counts) in one place
/// as plain, easily-tested Dart functions.
class ReviewRepository {
  ReviewRepository(this._db, {ReviewScheduler? scheduler})
    : _scheduler = scheduler ?? SimpleIntervalScheduler();

  final AppDatabase _db;
  final ReviewScheduler _scheduler;

  static const int weakMinReviews = 3;
  static const double weakWrongRateThreshold = 0.3;

  static bool _isDue(Word word, DateTime now) {
    final nextReviewAt = word.nextReviewAt;
    return nextReviewAt != null && !nextReviewAt.isAfter(now);
  }

  static bool _isWeak(Word word) {
    if (word.reviewCount < weakMinReviews) return false;
    return word.wrongCount / word.reviewCount >= weakWrongRateThreshold;
  }

  static bool _isNew(Word word) => word.status == WordStatus.newWord;

  Stream<ReviewQueueCounts> watchQueueCounts() {
    return _db.select(_db.words).watch().map((words) {
      final now = DateTime.now();
      return ReviewQueueCounts(
        due: words.where((w) => _isDue(w, now)).length,
        weak: words.where(_isWeak).length,
        newWords: words.where(_isNew).length,
      );
    });
  }

  /// A one-shot snapshot of words to review, in priority order (Due, then
  /// Weak, then New), de-duplicated and capped at [size]. Deliberately a
  /// `Future` rather than a `Stream`: a review session works through a
  /// fixed batch decided at the moment "Start Review" is tapped, it
  /// shouldn't reshuffle mid-session as data changes underneath it.
  Future<List<Word>> buildQueue(int size) async {
    final now = DateTime.now();
    final allWords = await _db.select(_db.words).get();

    final due = allWords.where((w) => _isDue(w, now)).toList()
      ..sort((a, b) => a.nextReviewAt!.compareTo(b.nextReviewAt!));

    final weak = allWords.where(_isWeak).toList()
      ..sort((a, b) {
        final rateA = a.wrongCount / a.reviewCount;
        final rateB = b.wrongCount / b.reviewCount;
        final byRate = rateB.compareTo(rateA);
        return byRate != 0 ? byRate : b.wrongCount.compareTo(a.wrongCount);
      });

    final newWords = allWords.where(_isNew).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final seenIds = <int>{};
    final queue = <Word>[];
    void addUpToSize(List<Word> words) {
      for (final word in words) {
        if (queue.length >= size) return;
        if (seenIds.add(word.id)) queue.add(word);
      }
    }

    addUpToSize(due);
    addUpToSize(weak);
    addUpToSize(newWords);
    return queue;
  }

  Future<int> startSession({
    required int totalWords,
    required ReviewSourceType sourceType,
  }) {
    return _db
        .into(_db.reviewSessions)
        .insert(
          ReviewSessionsCompanion.insert(
            sourceType: sourceType,
            totalWords: Value(totalWords),
          ),
        );
  }

  /// Applies the scheduler to one answer: updates the word's step/status/
  /// next-review-date and counters, logs a `ReviewHistory` row, and tallies
  /// the session's running correct/wrong counts — all in one transaction,
  /// so a crash mid-write can never leave the word and its history out of
  /// sync.
  ///
  /// A word is "correct" whenever the rating isn't Forgot — this is a
  /// self-graded flashcard, so the rating itself is the verdict.
  Future<void> recordAnswer({
    required int wordId,
    required int sessionId,
    required ReviewQuestionType questionType,
    required ReviewRating rating,
  }) async {
    final isCorrect = rating != ReviewRating.forgot;
    final now = DateTime.now();

    await _db.transaction(() async {
      final word = await (_db.select(
        _db.words,
      )..where((w) => w.id.equals(wordId))).getSingle();

      final result = _scheduler.schedule(
        currentStepIndex: word.stepIndex,
        rating: rating,
        now: now,
      );

      await (_db.update(_db.words)..where((w) => w.id.equals(wordId))).write(
        WordsCompanion(
          stepIndex: Value(result.newStepIndex),
          status: Value(result.newStatus),
          nextReviewAt: Value(result.nextReviewAt),
          lastReviewedAt: Value(now),
          reviewCount: Value(word.reviewCount + 1),
          correctCount: Value(
            isCorrect ? word.correctCount + 1 : word.correctCount,
          ),
          wrongCount: Value(isCorrect ? word.wrongCount : word.wrongCount + 1),
          updatedAt: Value(now),
        ),
      );

      await _db
          .into(_db.reviewHistory)
          .insert(
            ReviewHistoryCompanion.insert(
              wordId: wordId,
              reviewSessionId: sessionId,
              questionType: questionType,
              isCorrect: isCorrect,
              rating: rating,
              previousStepIndex: Value(word.stepIndex),
              newStepIndex: Value(result.newStepIndex),
            ),
          );

      final session = await (_db.select(
        _db.reviewSessions,
      )..where((s) => s.id.equals(sessionId))).getSingle();
      await (_db.update(
        _db.reviewSessions,
      )..where((s) => s.id.equals(sessionId))).write(
        ReviewSessionsCompanion(
          correctCount: Value(
            isCorrect ? session.correctCount + 1 : session.correctCount,
          ),
          wrongCount: Value(
            isCorrect ? session.wrongCount : session.wrongCount + 1,
          ),
        ),
      );
    });
  }

  Future<void> finishSession(int sessionId, {required Duration duration}) {
    return (_db.update(
      _db.reviewSessions,
    )..where((s) => s.id.equals(sessionId))).write(
      ReviewSessionsCompanion(
        finishedAt: Value(DateTime.now()),
        durationSeconds: Value(duration.inSeconds),
      ),
    );
  }
}
