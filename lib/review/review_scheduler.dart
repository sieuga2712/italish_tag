import '../database/tables/review_history_table.dart';
import '../database/tables/words_table.dart';

/// What a scheduler decides after one review: where the word lands on the
/// interval ladder, when to show it again, and what learning status that
/// implies.
class SchedulerResult {
  SchedulerResult({
    required this.newStepIndex,
    required this.nextReviewAt,
    required this.newStatus,
  });

  final int newStepIndex;
  final DateTime nextReviewAt;
  final WordStatus newStatus;
}

/// Decides the next review interval for a word, given its current position
/// and the user's self-rating. Kept as an interface (not just a function)
/// so a future, smarter algorithm (e.g. SM-2) can be swapped in without
/// touching `ReviewRepository` or any UI — see [SimpleIntervalScheduler].
abstract class ReviewScheduler {
  SchedulerResult schedule({
    required int currentStepIndex,
    required ReviewRating rating,
    required DateTime now,
  });
}

/// The MVP scheduler: a fixed ladder of intervals, no per-word ease factor.
///
/// ```
/// stepIndex:  0      1      2      3      4       5       6
/// interval:  10 min  1 day  3 days 7 days 14 days 30 days 60 days
/// ```
///
/// - 😵 Forgot -> back to step 0.
/// - 😐 Hard -> stays at the same step (repeat the same interval).
/// - 🙂 Good -> advances one step.
/// - 😎 Easy -> advances two steps.
///
/// Status is derived from the resulting step, not stored independently:
/// step 0 is `learning`, steps 1-3 are `reviewing`, step 4+ is `mastered`
/// — but only when the rating was Good/Easy; a Hard rating that happens to
/// land on step 4+ (because it was already there) reads as `reviewing`,
/// since "hard" and "mastered" shouldn't both describe the same word.
class SimpleIntervalScheduler implements ReviewScheduler {
  static const List<Duration> ladder = [
    Duration(minutes: 10),
    Duration(days: 1),
    Duration(days: 3),
    Duration(days: 7),
    Duration(days: 14),
    Duration(days: 30),
    Duration(days: 60),
  ];

  static const int masteredStepIndex = 4;

  @override
  SchedulerResult schedule({
    required int currentStepIndex,
    required ReviewRating rating,
    required DateTime now,
  }) {
    final rawStepIndex = switch (rating) {
      ReviewRating.forgot => 0,
      ReviewRating.hard => currentStepIndex,
      ReviewRating.good => currentStepIndex + 1,
      ReviewRating.easy => currentStepIndex + 2,
    };
    final newStepIndex = rawStepIndex.clamp(0, ladder.length - 1);

    final WordStatus newStatus;
    if (newStepIndex == 0) {
      newStatus = WordStatus.learning;
    } else if (newStepIndex >= masteredStepIndex &&
        (rating == ReviewRating.good || rating == ReviewRating.easy)) {
      newStatus = WordStatus.mastered;
    } else {
      newStatus = WordStatus.reviewing;
    }

    return SchedulerResult(
      newStepIndex: newStepIndex,
      nextReviewAt: now.add(ladder[newStepIndex]),
      newStatus: newStatus,
    );
  }
}
