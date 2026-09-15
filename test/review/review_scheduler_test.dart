// Phase 7 tests for the pure scheduling logic — no database involved.

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab_library/database/tables/review_history_table.dart';
import 'package:vocab_library/database/tables/words_table.dart';
import 'package:vocab_library/review/review_scheduler.dart';

void main() {
  final scheduler = SimpleIntervalScheduler();
  final now = DateTime(2026, 1, 1, 12);

  test('Forgot always resets to step 0, status learning', () {
    final result = scheduler.schedule(
      currentStepIndex: 5,
      rating: ReviewRating.forgot,
      now: now,
    );
    expect(result.newStepIndex, 0);
    expect(result.newStatus, WordStatus.learning);
    expect(result.nextReviewAt, now.add(const Duration(minutes: 10)));
  });

  test('Hard repeats the same step', () {
    final result = scheduler.schedule(
      currentStepIndex: 2,
      rating: ReviewRating.hard,
      now: now,
    );
    expect(result.newStepIndex, 2);
    expect(result.nextReviewAt, now.add(const Duration(days: 3)));
  });

  test('Good advances by one step', () {
    final result = scheduler.schedule(
      currentStepIndex: 1,
      rating: ReviewRating.good,
      now: now,
    );
    expect(result.newStepIndex, 2);
    expect(result.nextReviewAt, now.add(const Duration(days: 3)));
  });

  test('Easy advances by two steps', () {
    final result = scheduler.schedule(
      currentStepIndex: 0,
      rating: ReviewRating.easy,
      now: now,
    );
    expect(result.newStepIndex, 2);
  });

  test('Step index clamps at the top of the ladder', () {
    final result = scheduler.schedule(
      currentStepIndex: SimpleIntervalScheduler.ladder.length - 1,
      rating: ReviewRating.easy,
      now: now,
    );
    expect(result.newStepIndex, SimpleIntervalScheduler.ladder.length - 1);
  });

  test('Step index never goes negative', () {
    final result = scheduler.schedule(
      currentStepIndex: 0,
      rating: ReviewRating.hard,
      now: now,
    );
    expect(result.newStepIndex, 0);
  });

  group('status derivation', () {
    test('step 0 is learning', () {
      final result = scheduler.schedule(
        currentStepIndex: 0,
        rating: ReviewRating.hard,
        now: now,
      );
      expect(result.newStepIndex, 0);
      expect(result.newStatus, WordStatus.learning);
    });

    test('steps 1-3 are reviewing', () {
      final result = scheduler.schedule(
        currentStepIndex: 1,
        rating: ReviewRating.good,
        now: now,
      );
      expect(result.newStepIndex, 2);
      expect(result.newStatus, WordStatus.reviewing);
    });

    test('step 4+ with Good/Easy is mastered', () {
      final good = scheduler.schedule(
        currentStepIndex: 3,
        rating: ReviewRating.good,
        now: now,
      );
      expect(good.newStepIndex, 4);
      expect(good.newStatus, WordStatus.mastered);

      final easy = scheduler.schedule(
        currentStepIndex: 3,
        rating: ReviewRating.easy,
        now: now,
      );
      expect(easy.newStepIndex, 5);
      expect(easy.newStatus, WordStatus.mastered);
    });

    test('step 4+ with Hard stays reviewing, not mastered', () {
      final result = scheduler.schedule(
        currentStepIndex: 4,
        rating: ReviewRating.hard,
        now: now,
      );
      expect(result.newStepIndex, 4);
      expect(result.newStatus, WordStatus.reviewing);
    });
  });
}
