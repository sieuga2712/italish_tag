import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../database/tables/review_history_table.dart';
import '../../database/tables/review_sessions_table.dart';
import '../../database/tables/words_table.dart';
import '../../providers/review_providers.dart';
import '../../providers/word_providers.dart';
import '../../utils/date_utils.dart';
import '../../widgets/string_list_editor.dart';
import '../../widgets/word_tags_section.dart';
import '../review/review_session_args.dart';

/// Word Detail screen (Phase 6) — the single place to view and edit
/// everything about one word, replacing Phase 3's `CompleteWordSheet`.
///
/// A full-screen route (`/words/:wordId`, defined outside the bottom-nav
/// shell in `router.dart`) rather than a modal sheet, since it's reachable
/// from several different tabs (Words, Tags' word list, Inbox) and holds
/// enough content to deserve its own page with a back button.
class WordDetailPage extends ConsumerWidget {
  const WordDetailPage({super.key, required this.wordId, this.initialWord});

  final int wordId;

  /// Passed via `extra` by whichever list already had this row loaded, so
  /// the form can render immediately instead of waiting on a fresh query.
  /// Falls back to fetching it if navigated to directly (e.g. hot restart).
  final Word? initialWord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialWord != null) {
      return _WordDetailForm(wordId: wordId, initialWord: initialWord!);
    }

    final wordAsync = ref.watch(wordByIdProvider(wordId));
    return wordAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text('Lỗi: $error'))),
      data: (word) => _WordDetailForm(wordId: wordId, initialWord: word),
    );
  }
}

class _WordDetailForm extends ConsumerStatefulWidget {
  const _WordDetailForm({required this.wordId, required this.initialWord});

  final int wordId;
  final Word initialWord;

  @override
  ConsumerState<_WordDetailForm> createState() => _WordDetailFormState();
}

class _WordDetailFormState extends ConsumerState<_WordDetailForm> {
  late final TextEditingController _pronunciationController;
  late final TextEditingController _partOfSpeechController;
  late final TextEditingController _meaningController;
  late final TextEditingController _translationController;
  late final TextEditingController _italianController;
  late final TextEditingController _notesController;
  bool _isSaving = false;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    final word = widget.initialWord;
    _pronunciationController = TextEditingController(
      text: word.pronunciation ?? '',
    );
    _partOfSpeechController = TextEditingController(
      text: word.partOfSpeech ?? '',
    );
    _meaningController = TextEditingController(text: word.meaning ?? '');
    _translationController = TextEditingController(
      text: word.translation ?? '',
    );
    _italianController = TextEditingController(
      text: word.italianTranslation ?? '',
    );
    _notesController = TextEditingController(text: word.notes ?? '');

    for (final controller in [
      _pronunciationController,
      _partOfSpeechController,
      _meaningController,
      _translationController,
      _italianController,
      _notesController,
    ]) {
      controller.addListener(_markDirty);
    }
  }

  void _markDirty() {
    if (!_dirty) setState(() => _dirty = true);
  }

  @override
  void dispose() {
    _pronunciationController.dispose();
    _partOfSpeechController.dispose();
    _meaningController.dispose();
    _translationController.dispose();
    _italianController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _nullIfEmpty(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  List<String> _decodeList(String? json) {
    if (json == null || json.isEmpty) return const [];
    return (jsonDecode(json) as List<dynamic>).cast<String>();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);

    await ref
        .read(wordRepositoryProvider)
        .updateDetails(
          widget.wordId,
          pronunciation: _nullIfEmpty(_pronunciationController.text),
          partOfSpeech: _nullIfEmpty(_partOfSpeechController.text),
          meaning: _nullIfEmpty(_meaningController.text),
          translation: _nullIfEmpty(_translationController.text),
          italianTranslation: _nullIfEmpty(_italianController.text),
          notes: _nullIfEmpty(_notesController.text),
        );

    if (!mounted) return;
    setState(() {
      _isSaving = false;
      _dirty = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã lưu')));
  }

  @override
  Widget build(BuildContext context) {
    // Live data for the parts that can change from elsewhere (favorite,
    // learning stats) without disturbing the text controllers above, which
    // are only ever seeded once from `widget.initialWord`.
    final liveWord =
        ref.watch(wordByIdProvider(widget.wordId)).value ?? widget.initialWord;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialWord.word),
        actions: [
          IconButton(
            icon: Icon(
              liveWord.favorite ? Icons.star : Icons.star_border,
              color: liveWord.favorite ? Colors.amber : null,
            ),
            tooltip: liveWord.favorite ? 'Unfavorite' : 'Favorite',
            onPressed: () => ref
                .read(wordRepositoryProvider)
                .toggleFavorite(widget.wordId, !liveWord.favorite),
          ),
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            tooltip: 'Save',
            onPressed: (!_dirty || _isSaving) ? null : _save,
          ),
        ],
      ),
      body: ListView(
        key: const Key('wordDetailScrollView'),
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _pronunciationController,
            decoration: const InputDecoration(labelText: 'Pronunciation'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _partOfSpeechController,
            decoration: const InputDecoration(labelText: 'Part of speech'),
          ),
          const SizedBox(height: 16),
          WordTagsSection(wordId: widget.wordId),
          const SizedBox(height: 16),
          TextField(
            controller: _meaningController,
            decoration: const InputDecoration(labelText: 'Meaning'),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _translationController,
            decoration: const InputDecoration(
              labelText: 'Translation (Tiếng Việt)',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _italianController,
            decoration: const InputDecoration(
              labelText: 'Traduzione (Italiano)',
            ),
          ),
          const SizedBox(height: 16),
          StringListEditor(
            key: const Key('examplesEditor'),
            label: 'Examples',
            items: _decodeList(liveWord.examplesJson),
            hintText: 'Add an example sentence',
            onChanged: (items) => ref
                .read(wordRepositoryProvider)
                .updateExamples(widget.wordId, items),
          ),
          const SizedBox(height: 16),
          StringListEditor(
            key: const Key('synonymsEditor'),
            label: 'Synonyms',
            items: _decodeList(liveWord.synonymsJson),
            hintText: 'Add a synonym',
            onChanged: (items) => ref
                .read(wordRepositoryProvider)
                .updateSynonyms(widget.wordId, items),
          ),
          const SizedBox(height: 16),
          StringListEditor(
            key: const Key('antonymsEditor'),
            label: 'Antonyms',
            items: _decodeList(liveWord.antonymsJson),
            hintText: 'Add an antonym',
            onChanged: (items) => ref
                .read(wordRepositoryProvider)
                .updateAntonyms(widget.wordId, items),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notes'),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          _LearningSection(word: liveWord),
          const SizedBox(height: 16),
          _HistorySection(wordId: widget.wordId),
        ],
      ),
    );
  }
}

String _statusLabel(WordStatus status) => switch (status) {
  WordStatus.newWord => 'New',
  WordStatus.learning => 'Learning',
  WordStatus.reviewing => 'Reviewing',
  WordStatus.mastered => 'Mastered',
};

class _LearningSection extends ConsumerStatefulWidget {
  const _LearningSection({required this.word});

  final Word word;

  @override
  ConsumerState<_LearningSection> createState() => _LearningSectionState();
}

class _LearningSectionState extends ConsumerState<_LearningSection> {
  bool _isStarting = false;

  Future<void> _reviewThisWord() async {
    setState(() => _isStarting = true);

    final repository = ref.read(reviewRepositoryProvider);
    final sessionId = await repository.startSession(
      totalWords: 1,
      sourceType: ReviewSourceType.manual,
    );

    if (!mounted) return;
    setState(() => _isStarting = false);
    context.push(
      '/review-session',
      extra: ReviewSessionArgs(sessionId: sessionId, queue: [widget.word]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final word = widget.word;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Learning', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text('Status: ${_statusLabel(word.status)}'),
            Text('Reviews: ${word.reviewCount}'),
            Text('Correct: ${word.correctCount}'),
            Text('Wrong: ${word.wrongCount}'),
            Text(
              'Last reviewed: ${word.lastReviewedAt == null ? 'Chưa từng ôn' : formatDate(word.lastReviewedAt!)}',
            ),
            Text(
              'Next review: ${word.nextReviewAt == null ? 'Chưa lên lịch' : formatDate(word.nextReviewAt!)}',
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: _isStarting ? null : _reviewThisWord,
              child: _isStarting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Review this word'),
            ),
          ],
        ),
      ),
    );
  }
}

String _questionTypeLabel(ReviewQuestionType type) => switch (type) {
  ReviewQuestionType.wordToMeaning => 'Word → Meaning',
  ReviewQuestionType.meaningToWord => 'Meaning → Word',
  ReviewQuestionType.multipleChoice => 'Multiple Choice',
  ReviewQuestionType.fillBlank => 'Fill in the Blank',
  ReviewQuestionType.sentenceContext => 'Sentence Context',
  ReviewQuestionType.listening => 'Listening',
};

String _ratingLabel(ReviewRating rating) => switch (rating) {
  ReviewRating.forgot => 'Quên',
  ReviewRating.hard => 'Khó',
  ReviewRating.good => 'Nhớ',
  ReviewRating.easy => 'Rất dễ',
};

class _HistorySection extends ConsumerWidget {
  const _HistorySection({required this.wordId});

  final int wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(wordHistoryProvider(wordId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('History', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            history.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text('Lỗi: $error'),
              data: (entries) {
                if (entries.isEmpty) {
                  return const Text('Chưa có lịch sử ôn tập nào.');
                }
                return Column(
                  children: entries
                      .map((entry) => _HistoryRow(entry: entry))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.entry});

  final ReviewHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            entry.isCorrect ? Icons.check_circle : Icons.cancel,
            color: entry.isCorrect ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${formatDate(entry.reviewedAt)} · ${_questionTypeLabel(entry.questionType)} · ${_ratingLabel(entry.rating)}',
            ),
          ),
        ],
      ),
    );
  }
}
