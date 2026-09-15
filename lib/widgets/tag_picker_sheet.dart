import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/tag_providers.dart';
import '../repositories/tag_repository.dart';

/// Modal bottom sheet to assign/unassign tags on one word: a checklist of
/// every existing tag (toggled immediately on tap, no separate confirm
/// step) plus a small field to create a brand new tag and assign it in one
/// go.
class TagPickerSheet extends ConsumerStatefulWidget {
  const TagPickerSheet({super.key, required this.wordId});

  final int wordId;

  @override
  ConsumerState<TagPickerSheet> createState() => _TagPickerSheetState();
}

class _TagPickerSheetState extends ConsumerState<TagPickerSheet> {
  final _newTagController = TextEditingController();

  @override
  void dispose() {
    _newTagController.dispose();
    super.dispose();
  }

  Future<void> _createAndAssign() async {
    final name = _newTagController.text.trim();
    if (name.isEmpty) return;

    try {
      final tagId = await ref.read(tagRepositoryProvider).createTag(name);
      await ref.read(tagRepositoryProvider).addTagToWord(widget.wordId, tagId);
      _newTagController.clear();
    } on DuplicateTagException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tag "${e.name}" đã tồn tại')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final allTags = ref.watch(allTagsProvider);
    final assignedTagIds =
        ref
            .watch(tagsForWordProvider(widget.wordId))
            .value
            ?.map((tag) => tag.id)
            .toSet() ??
        <int>{};

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Tags', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newTagController,
                  decoration: const InputDecoration(hintText: 'New tag name'),
                  onSubmitted: (_) => _createAndAssign(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Create and assign',
                onPressed: _createAndAssign,
              ),
            ],
          ),
          const SizedBox(height: 12),
          allTags.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text('Lỗi: $error'),
            data: (tags) {
              if (tags.isEmpty) {
                return const Text('Chưa có tag nào — tạo tag mới ở trên.');
              }
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) {
                  final selected = assignedTagIds.contains(tag.id);
                  return FilterChip(
                    label: Text(tag.name),
                    selected: selected,
                    onSelected: (value) {
                      final repo = ref.read(tagRepositoryProvider);
                      if (value) {
                        repo.addTagToWord(widget.wordId, tag.id);
                      } else {
                        repo.removeTagFromWord(widget.wordId, tag.id);
                      }
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
