import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_provider.dart';
import '../repositories/review_repository.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(ref.watch(databaseProvider));
}, name: 'reviewRepositoryProvider');

/// Live Due/Weak/New counts for the Review tab's "TODAY" summary.
final reviewQueueCountsProvider = StreamProvider<ReviewQueueCounts>((ref) {
  return ref.watch(reviewRepositoryProvider).watchQueueCounts();
}, name: 'reviewQueueCountsProvider');
