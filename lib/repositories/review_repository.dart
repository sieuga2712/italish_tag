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

  /// Weak words, worst wrong-rate first (ties broken by raw wrong count) —
  /// shared by [buildQueue]'s weak tier, [watchWeakWords], and
  /// [getWeakWords] so the ranking rule lives in exactly one place.
  static List<Word> _sortedWeak(List<Word> words) {
    final weak = words.where(_isWeak).toList();
    weak.sort((a, b) {
      final rateA = a.wrongCount / a.reviewCount;
      final rateB = b.wrongCount / b.reviewCount;
      final byRate = rateB.compareTo(rateA);
      return byRate != 0 ? byRate : b.wrongCount.compareTo(a.wrongCount);
    });
    return weak;
  }

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

    final weak = _sortedWeak(allWords);

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

  /// Live list for the Weak Words screen — same ranking as [buildQueue]'s
  /// weak tier, but every qualifying word rather than just a count.
  Stream<List<Word>> watchWeakWords() {
    return _db.select(_db.words).watch().map(_sortedWeak);
  }

  /// One-shot version of [watchWeakWords], for building a "Review Weak
  /// Words" queue — a review session is a fixed snapshot, same reasoning
  /// as [buildQueue].
  Future<List<Word>> getWeakWords() async {
    return _sortedWeak(await _db.select(_db.words).get());
  }

  /// One word's full review history, most recent first — for the Word
  /// Detail screen's History section.
  Stream<List<ReviewHistoryEntry>> watchHistoryForWord(int wordId) {
    return (_db.select(_db.reviewHistory)
          ..where((h) => h.wordId.equals(wordId))
          ..orderBy([(h) => OrderingTerm.desc(h.reviewedAt)]))
        .watch();
  }

  /// All-time accuracy across every review ever recorded, computed from
  /// `ReviewHistory` (the source of truth) rather than summed `Word`
  /// counters, since history is exactly what "all-time" means.
  Stream<ReviewStats> watchOverallStats() {
    return _db.select(_db.reviewHistory).watch().map((rows) {
      return ReviewStats(
        totalReviews: rows.length,
        totalCorrect: rows.where((r) => r.isCorrect).length,
      );
    });
  }
}

/// All-time review accuracy, for the Weak Words screen's summary line.
class ReviewStats {
  ReviewStats({required this.totalReviews, required this.totalCorrect});

  final int totalReviews;
  final int totalCorrect;

  /// 0 when there have been no reviews yet, rather than NaN.
  double get accuracy => totalReviews == 0 ? 0 : totalCorrect / totalReviews;
}
