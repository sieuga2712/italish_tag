import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/tag_providers.dart';
import 'tag_picker_sheet.dart';

/// Shows a word's current tags as removable chips, plus an "Add tag" chip
/// that opens [TagPickerSheet]. Used on the Word Detail screen (Phase 6).
class WordTagsSection extends ConsumerWidget {
  const WordTagsSection({super.key, required this.wordId});

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
