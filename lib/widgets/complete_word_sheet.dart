import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../providers/tag_providers.dart';
import '../providers/word_providers.dart';
import 'tag_picker_sheet.dart';

/// Modal bottom sheet to fill in the fields Quick Add skipped, plus
/// managing this word's tags.
///
/// Kept intentionally small: Meaning, Vietnamese translation, Italian
/// translation, one Example, Notes, Tags. Multi-example/synonym/antonym
/// editing belongs to the full Word Detail screen (Phase 6).
class CompleteWordSheet extends ConsumerStatefulWidget {
  const CompleteWordSheet({super.key, required this.word});

  final Word word;

  @override
  ConsumerState<CompleteWordSheet> createState() => _CompleteWordSheetState();
}

class _CompleteWordSheetState extends ConsumerState<CompleteWordSheet> {
  late final TextEditingController _meaningController;
  late final TextEditingController _translationController;
  late final TextEditingController _italianController;
  late final TextEditingController _exampleController;
  late final TextEditingController _notesController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final word = widget.word;
    _meaningController = TextEditingController(text: word.meaning ?? '');
    _translationController = TextEditingController(
      text: word.translation ?? '',
    );
    _italianController = TextEditingController(
      text: word.italianTranslation ?? '',
    );
    _exampleController = TextEditingController(text: _firstExample(word));
    _notesController = TextEditingController(text: word.notes ?? '');
  }

  static String _firstExample(Word word) {
    final json = word.examplesJson;
    if (json == null || json.isEmpty) return '';
    final decoded = jsonDecode(json) as List<dynamic>;
    return decoded.isEmpty ? '' : decoded.first as String;
  }

  @override
  void dispose() {
    _meaningController.dispose();
    _translationController.dispose();
    _italianController.dispose();
    _exampleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _nullIfEmpty(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);

    await ref
        .read(wordRepositoryProvider)
        .updateEnrichment(
          widget.word.id,
          meaning: _nullIfEmpty(_meaningController.text),
          translation: _nullIfEmpty(_translationController.text),
          italianTranslation: _nullIfEmpty(_italianController.text),
          example: _nullIfEmpty(_exampleController.text),
          notes: _nullIfEmpty(_notesController.text),
        );

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.word.word,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _meaningController,
              decoration: const InputDecoration(labelText: 'Meaning'),
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
            const SizedBox(height: 12),
            TextField(
              controller: _exampleController,
              decoration: const InputDecoration(labelText: 'Example'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            _TagsSection(wordId: widget.word.id),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows this word's current tags as removable chips, plus an "Add tag"
/// chip that opens [TagPickerSheet]. A separate widget (rather than inline
/// in `_CompleteWordSheetState.build`) so watching `tagsForWordProvider`
/// only rebuilds this small section, not the whole form.
class _TagsSection extends ConsumerWidget {
  const _TagsSection({required this.wordId});

  final int wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsForWordProvider(wordId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tags', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...tags.value?.map(
                  (tag) => Chip(
                    label: Text(tag.name),
                    onDeleted: () => ref
                        .read(tagRepositoryProvider)
                        .removeTagFromWord(wordId, tag.id),
                  ),
                ) ??
                const [],
            ActionChip(
              avatar: const Icon(Icons.add, size: 18),
              label: const Text('Add tag'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => TagPickerSheet(wordId: wordId),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
