// Phase 7 repository tests, run against an in-memory database:
// - buildQueue prioritizes Due, then Weak, then New, capped at the size
// - buildQueue never lists the same word twice even if it qualifies for
//   more than one tier
// - recordAnswer updates the word's counters/status/nextReviewAt, logs a
//   ReviewHistory row, and tallies the session's correct/wrong counts
// - watchQueueCounts reflects the same Due/Weak/New classification

import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/tables/review_history_table.dart';
import 'package:vocab_library/database/tables/review_sessions_table.dart';
import 'package:vocab_library/database/tables/words_table.dart';
import 'package:vocab_library/repositories/review_repository.dart';

void main() {
  late AppDatabase db;
  late ReviewRepository reviewRepo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    reviewRepo = ReviewRepository(db);
  });

  tearDown(() => db.close());

  test(
    'buildQueue lists Due words before Weak before New, capped at size',
    () async {
      final now = DateTime.now();

      final dueId = await db
          .into(db.words)
          .insert(
            WordsCompanion.insert(
              word: 'due-word',
              nextReviewAt: Value(now.subtract(const Duration(minutes: 1))),
              status: const Value(WordStatus.reviewing),
            ),
          );
      final weakId = await db
          .into(db.words)
          .insert(
            WordsCompanion.insert(
              word: 'weak-word',
              status: const Value(WordStatus.reviewing),
              reviewCount: const Value(4),
              wrongCount: const Value(3),
            ),
          );
      final newId = await db
          .into(db.words)
          .insert(WordsCompanion.insert(word: 'new-word'));

      final queue = await reviewRepo.buildQueue(10);

      expect(queue.map((w) => w.id), [dueId, weakId, newId]);
    },
  );

  test('buildQueue caps at size and never duplicates a word', () async {
    // A word that is both due AND weak must only appear once, and the cap
    // must be respected across combined tiers.
    final now = DateTime.now();
    await db
        .into(db.words)
        .insert(
          WordsCompanion.insert(
            word: 'due-and-weak',
            nextReviewAt: Value(now.subtract(const Duration(minutes: 1))),
            reviewCount: const Value(5),
            wrongCount: const Value(4),
          ),
        );
    for (var i = 0; i < 5; i++) {
      await db.into(db.words).insert(WordsCompanion.insert(word: 'new-$i'));
    }

    final queue = await reviewRepo.buildQueue(3);

    expect(queue, hasLength(3));
    expect(queue.map((w) => w.word).toSet().length, 3);
  });

  test(
    'recordAnswer updates the word, logs history, and tallies the session',
    () async {
      final wordId = await db
          .into(db.words)
          .insert(WordsCompanion.insert(word: 'efficient'));
      final sessionId = await reviewRepo.startSession(
        totalWords: 1,
        sourceType: ReviewSourceType.mixed,
      );

      await reviewRepo.recordAnswer(
        wordId: wordId,
        sessionId: sessionId,
        questionType: ReviewQuestionType.wordToMeaning,
        rating: ReviewRating.good,
      );

      final word = await (db.select(
        db.words,
      )..where((w) => w.id.equals(wordId))).getSingle();
      expect(word.stepIndex, 1);
      expect(word.status, WordStatus.reviewing);
      expect(word.reviewCount, 1);
      expect(word.correctCount, 1);
      expect(word.wrongCount, 0);
      expect(word.lastReviewedAt, isNotNull);
      expect(word.nextReviewAt, isNotNull);

      final history = await (db.select(
        db.reviewHistory,
      )..where((h) => h.wordId.equals(wordId))).get();
      expect(history, hasLength(1));
      expect(history.single.rating, ReviewRating.good);
      expect(history.single.isCorrect, isTrue);
      expect(history.single.previousStepIndex, 0);
      expect(history.single.newStepIndex, 1);

      final session = await (db.select(
        db.reviewSessions,
      )..where((s) => s.id.equals(sessionId))).getSingle();
      expect(session.correctCount, 1);
      expect(session.wrongCount, 0);
    },
  );

  test('recordAnswer with Forgot counts as wrong', () async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'ambiguous'));
    final sessionId = await reviewRepo.startSession(
      totalWords: 1,
      sourceType: ReviewSourceType.mixed,
    );

    await reviewRepo.recordAnswer(
      wordId: wordId,
      sessionId: sessionId,
      questionType: ReviewQuestionType.wordToMeaning,
      rating: ReviewRating.forgot,
    );

    final word = await (db.select(
      db.words,
    )..where((w) => w.id.equals(wordId))).getSingle();
    expect(word.wrongCount, 1);
    expect(word.correctCount, 0);

    final session = await (db.select(
      db.reviewSessions,
    )..where((s) => s.id.equals(sessionId))).getSingle();
    expect(session.wrongCount, 1);
  });

  test('finishSession sets finishedAt and durationSeconds', () async {
    final sessionId = await reviewRepo.startSession(
      totalWords: 0,
      sourceType: ReviewSourceType.mixed,
    );

    await reviewRepo.finishSession(
      sessionId,
      duration: const Duration(seconds: 90),
    );

    final session = await (db.select(
      db.reviewSessions,
    )..where((s) => s.id.equals(sessionId))).getSingle();
    expect(session.finishedAt, isNotNull);
    expect(session.durationSeconds, 90);
  });

  test('watchQueueCounts reflects Due/Weak/New classification', () async {
    final now = DateTime.now();
    await db
        .into(db.words)
        .insert(
          WordsCompanion.insert(
            word: 'due',
            nextReviewAt: Value(now.subtract(const Duration(minutes: 1))),
            status: const Value(WordStatus.reviewing),
          ),
        );
    await db
        .into(db.words)
        .insert(
          WordsCompanion.insert(
            word: 'weak',
            reviewCount: const Value(4),
            wrongCount: const Value(3),
            status: const Value(WordStatus.reviewing),
          ),
        );
    await db.into(db.words).insert(WordsCompanion.insert(word: 'new'));

    final counts = await reviewRepo.watchQueueCounts().first;
    expect(counts.due, 1);
    expect(counts.weak, 1);
    expect(counts.newWords, 1);
  });
}
