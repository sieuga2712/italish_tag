import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/tables/review_sessions_table.dart';
import '../../providers/review_providers.dart';
import 'review_session_args.dart';

const _sessionSizeOptions = [5, 10, 20, 30];

/// Review tab: today's Due/Weak/New summary, a session-size picker, and
/// "Start Review" — which builds the queue, opens a `ReviewSession` row,
/// then pushes the full-screen review flow.
class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key});

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  int _selectedSize = 10;
  bool _isStarting = false;

  Future<void> _startReview() async {
    setState(() => _isStarting = true);

    final repository = ref.read(reviewRepositoryProvider);
    final queue = await repository.buildQueue(_selectedSize);

    if (queue.isEmpty) {
      if (!mounted) return;
      setState(() => _isStarting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có từ nào cần ôn lúc này.')),
      );
      return;
    }

    final sessionId = await repository.startSession(
      totalWords: queue.length,
      sourceType: ReviewSourceType.mixed,
    );

    if (!mounted) return;
    setState(() => _isStarting = false);
    context.push(
      '/review-session',
      extra: ReviewSessionArgs(sessionId: sessionId, queue: queue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final counts = ref.watch(reviewQueueCountsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: counts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
        data: (counts) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TODAY',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 12),
                        _CountRow(label: 'Due', value: counts.due),
                        _CountRow(label: 'Weak', value: counts.weak),
                        _CountRow(label: 'New', value: counts.newWords),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Số từ mỗi lượt ôn',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _sessionSizeOptions
                      .map(
                        (size) => ChoiceChip(
                          label: Text('$size'),
                          selected: _selectedSize == size,
                          onSelected: (_) =>
                              setState(() => _selectedSize = size),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _isStarting ? null : _startReview,
                  child: _isStarting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Start Review'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CountRow extends StatelessWidget {
  const _CountRow({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text('$value')],
      ),
    );
  }
}
