import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/tables/review_sessions_table.dart';
import '../../providers/review_providers.dart';
import 'review_session_args.dart';

/// Weak Words screen (Phase 8): every word whose wrong-rate is 30%+ over
/// at least 3 reviews, worst first, with an overall accuracy summary and a
/// button to start a review session made up of only these words.
///
/// Nested under the Review tab (not a top-level route like the review
/// session itself) since this is a browsing screen — keeping the bottom
/// nav visible fits it better than a focused, one-task full-screen flow.
class WeakWordsPage extends ConsumerStatefulWidget {
  const WeakWordsPage({super.key});

  @override
  ConsumerState<WeakWordsPage> createState() => _WeakWordsPageState();
}

class _WeakWordsPageState extends ConsumerState<WeakWordsPage> {
  bool _isStarting = false;

  Future<void> _reviewWeakWords() async {
    setState(() => _isStarting = true);

    final repository = ref.read(reviewRepositoryProvider);
    final weakWords = await repository.getWeakWords();

    if (weakWords.isEmpty) {
      if (!mounted) return;
      setState(() => _isStarting = false);
      return;
    }

    final sessionId = await repository.startSession(
      totalWords: weakWords.length,
      sourceType: ReviewSourceType.weak,
    );

    if (!mounted) return;
    setState(() => _isStarting = false);
    context.push(
      '/review-session',
      extra: ReviewSessionArgs(sessionId: sessionId, queue: weakWords),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weakWords = ref.watch(weakWordsProvider);
    final stats = ref.watch(reviewStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weak Words')),
      body: Column(
        children: [
          stats.when(
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
            data: (stats) {
              if (stats.totalReviews == 0) return const SizedBox.shrink();
              final accuracyPercent = (stats.accuracy * 100).round();
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${stats.totalCorrect}/${stats.totalReviews} correct overall · $accuracyPercent% accuracy',
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: weakWords.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Lỗi: $error')),
              data: (words) {
                if (words.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Chưa có từ nào yếu.\nÔn tập nhiều hơn để thấy dữ liệu ở đây.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: words.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final word = words[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(word.word),
                      subtitle: Text(
                        '${word.wrongCount} wrong / ${word.reviewCount} reviews',
                      ),
                      onTap: () =>
                          context.push('/words/${word.id}', extra: word),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: (_isStarting || (weakWords.value?.isEmpty ?? true))
                  ? null
                  : _reviewWeakWords,
              child: _isStarting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Review Weak Words'),
            ),
          ),
        ],
      ),
    );
  }
}
