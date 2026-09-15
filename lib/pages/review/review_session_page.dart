import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/tables/review_history_table.dart';
import '../../providers/review_providers.dart';
import 'review_session_args.dart';

/// Full-screen review session (Phase 7 MVP): one Word -> Meaning flashcard
/// at a time, "Show Answer" then a 4-point rating, until the queue in
/// [args] is exhausted, then a completion summary.
///
/// A top-level route (see `router.dart`), like Word Detail — no bottom
/// nav, a focused single-question view, matching the design doc's "don't
/// show anything else while reviewing" goal.
class ReviewSessionPage extends ConsumerStatefulWidget {
  const ReviewSessionPage({super.key, required this.args});

  final ReviewSessionArgs args;

  @override
  ConsumerState<ReviewSessionPage> createState() => _ReviewSessionPageState();
}

class _ReviewSessionPageState extends ConsumerState<ReviewSessionPage> {
  late final DateTime _startedAt;
  int _currentIndex = 0;
  bool _showAnswer = false;
  int _correctCount = 0;
  int _wrongCount = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _startedAt = DateTime.now();
  }

  bool get _isComplete => _currentIndex >= widget.args.queue.length;

  Future<void> _submitRating(ReviewRating rating) async {
    setState(() => _isSubmitting = true);

    final word = widget.args.queue[_currentIndex];
    await ref
        .read(reviewRepositoryProvider)
        .recordAnswer(
          wordId: word.id,
          sessionId: widget.args.sessionId,
          questionType: ReviewQuestionType.wordToMeaning,
          rating: rating,
        );

    if (!mounted) return;

    final wasCorrect = rating != ReviewRating.forgot;
    setState(() {
      if (wasCorrect) {
        _correctCount++;
      } else {
        _wrongCount++;
      }
      _currentIndex++;
      _showAnswer = false;
      _isSubmitting = false;
    });

    if (_isComplete) {
      await ref
          .read(reviewRepositoryProvider)
          .finishSession(
            widget.args.sessionId,
            duration: DateTime.now().difference(_startedAt),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.args.queue.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Review')),
        body: const Center(child: Text('Không có từ nào để ôn.')),
      );
    }

    if (_isComplete) {
      return _ReviewCompleteView(
        total: widget.args.queue.length,
        correct: _correctCount,
        wrong: _wrongCount,
        duration: DateTime.now().difference(_startedAt),
      );
    }

    final word = widget.args.queue[_currentIndex];
    final hasMeaning = (word.meaning ?? '').isNotEmpty;
    final hasTranslation = (word.translation ?? '').isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentIndex + 1} / ${widget.args.queue.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word.word,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            if ((word.pronunciation ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '/${word.pronunciation}/',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            const SizedBox(height: 40),
            if (_showAnswer) ...[
              Text(
                hasMeaning ? word.meaning! : '(Chưa có nghĩa)',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              if (hasTranslation) ...[
                const SizedBox(height: 4),
                Text(word.translation!, textAlign: TextAlign.center),
              ],
              const SizedBox(height: 40),
              _RatingButtons(onRate: _isSubmitting ? null : _submitRating),
            ] else
              FilledButton(
                onPressed: () => setState(() => _showAnswer = true),
                child: const Text('Show Answer'),
              ),
          ],
        ),
      ),
    );
  }
}

class _RatingButtons extends StatelessWidget {
  const _RatingButtons({required this.onRate});

  final ValueChanged<ReviewRating>? onRate;

  @override
  Widget build(BuildContext context) {
    const options = [
      (ReviewRating.forgot, '😵', 'Quên'),
      (ReviewRating.hard, '😐', 'Khó'),
      (ReviewRating.good, '🙂', 'Nhớ'),
      (ReviewRating.easy, '😎', 'Rất dễ'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((option) {
        final (rating, emoji, label) = option;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton(
              onPressed: onRate == null ? null : () => onRate!(rating),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 4),
                  Text(label),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ReviewCompleteView extends StatelessWidget {
  const _ReviewCompleteView({
    required this.total,
    required this.correct,
    required this.wrong,
    required this.duration,
  });

  final int total;
  final int correct;
  final int wrong;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final accuracy = total == 0 ? 0 : (correct / total * 100).round();
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(title: const Text('Review Complete')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text(
                '$total words reviewed',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text('$correct correct · $wrong wrong'),
              Text('$accuracy% accuracy'),
              Text('${minutes}m ${seconds}s'),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
