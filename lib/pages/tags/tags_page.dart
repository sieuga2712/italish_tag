import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/tag_providers.dart';
import '../../repositories/tag_repository.dart';

/// Prompts for a tag name (create or rename) and returns it, or `null` if
/// the user cancelled. A small `StatefulWidget` so the `TextEditingController`
/// is disposed properly, unlike a one-off controller built inline.
class _TagNameDialog extends StatefulWidget {
  const _TagNameDialog({required this.title, this.initialName});

  final String title;
  final String? initialName;

  @override
  State<_TagNameDialog> createState() => _TagNameDialogState();
}

class _TagNameDialogState extends State<_TagNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => Navigator.of(context).pop(_controller.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Tag name'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Huỷ'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}

Future<String?> _promptForTagName(
  BuildContext context, {
  required String title,
  String? initialName,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) =>
        _TagNameDialog(title: title, initialName: initialName),
  );
}

/// Tags tab: every tag with its word count, create/rename/delete, and tap
/// a tag to see its words.
class TagsPage extends ConsumerWidget {
  const TagsPage({super.key});

  Future<void> _createTag(BuildContext context, WidgetRef ref) async {
    final name = await _promptForTagName(context, title: 'Create Tag');
    if (name == null) return;
    try {
      await ref.read(tagRepositoryProvider).createTag(name);
    } on DuplicateTagException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tag "${e.name}" đã tồn tại')));
    }
  }

  Future<void> _renameTag(
    BuildContext context,
    WidgetRef ref,
    TagWithCount item,
  ) async {
    final name = await _promptForTagName(
      context,
      title: 'Rename Tag',
      initialName: item.tag.name,
    );
    if (name == null) return;
    try {
      await ref.read(tagRepositoryProvider).renameTag(item.tag.id, name);
    } on DuplicateTagException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tag "${e.name}" đã tồn tại')));
    }
  }

  Future<void> _deleteTag(
    BuildContext context,
    WidgetRef ref,
    TagWithCount item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xoá tag "${item.tag.name}"?'),
        content: Text(
          '${item.wordCount} từ sẽ mất tag này (các từ không bị xoá).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Xoá'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(tagRepositoryProvider).deleteTag(item.tag.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsWithCountsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Tag',
            onPressed: () => _createTag(context, ref),
          ),
        ],
      ),
      body: tags.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
        data: (tags) {
          if (tags.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Chưa có tag nào.\nBấm + để tạo tag đầu tiên.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: tags.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = tags[index];
              return ListTile(
                title: Text(item.tag.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${item.wordCount} words'),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'rename') _renameTag(context, ref, item);
                        if (value == 'delete') _deleteTag(context, ref, item);
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'rename', child: Text('Rename')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ],
                ),
                onTap: () =>
                    context.push('/tags/${item.tag.id}', extra: item.tag.name),
              );
            },
          );
        },
      ),
    );
  }
}
