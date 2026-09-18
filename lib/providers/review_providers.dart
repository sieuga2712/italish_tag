import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../repositories/review_repository.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(ref.watch(databaseProvider));
}, name: 'reviewRepositoryProvider');

/// Live Due/Weak/New counts for the Review tab's "TODAY" summary.
final reviewQueueCountsProvider = StreamProvider<ReviewQueueCounts>((ref) {
  return ref.watch(reviewRepositoryProvider).watchQueueCounts();
}, name: 'reviewQueueCountsProvider');

/// Live weak-word list for the Weak Words screen (Phase 8).
final weakWordsProvider = StreamProvider<List<Word>>((ref) {
  return ref.watch(reviewRepositoryProvider).watchWeakWords();
}, name: 'weakWordsProvider');

/// All-time accuracy for the Weak Words screen's summary line.
final reviewStatsProvider = StreamProvider<ReviewStats>((ref) {
  return ref.watch(reviewRepositoryProvider).watchOverallStats();
}, name: 'reviewStatsProvider');

/// One word's review history, for the Word Detail screen's History section.
final wordHistoryProvider = StreamProvider.family<List<ReviewHistoryEntry>, int>((
  ref,
  wordId,
) {
  return ref.watch(reviewRepositoryProvider).watchHistoryForWord(wordId);
}, name: 'wordHistoryProvider');
