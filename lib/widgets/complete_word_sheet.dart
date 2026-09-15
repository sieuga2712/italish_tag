import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../providers/word_providers.dart';

/// Modal bottom sheet to fill in the fields Quick Add skipped.
///
/// Kept intentionally small for Phase 3: Meaning, Vietnamese translation,
/// Italian translation, one Example, Notes. Tags aren't here yet because
/// the Tag system doesn't exist until Phase 5; multi-example/synonym/
/// antonym editing belongs to the full Word Detail screen (Phase 6).
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
