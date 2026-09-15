import '../../database/app_database.dart';

/// Everything the review session screen needs, built by [ReviewPage]
/// (queue fetched + session row created) before navigating — the session
/// screen itself never queries anything to get started, only to record
/// answers as the user goes.
class ReviewSessionArgs {
  ReviewSessionArgs({required this.sessionId, required this.queue});

  final int sessionId;
  final List<Word> queue;
}
