import 'package:flutter/material.dart';

/// Editable list of short strings, shown as removable chips with an "add"
/// row below — used for Examples/Synonyms/Antonyms on the Word Detail
/// screen. A controlled component: [items] always comes from the parent
/// (which persists to the database on every change via [onChanged]); the
/// only local state here is the text in the "add new item" box.
class StringListEditor extends StatefulWidget {
  const StringListEditor({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.hintText = 'Add...',
  });

  final String label;
  final List<String> items;
  final ValueChanged<List<String>> onChanged;
  final String hintText;

  @override
  State<StringListEditor> createState() => _StringListEditorState();
}

class _StringListEditorState extends State<StringListEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onChanged([...widget.items, value]);
    _controller.clear();
  }

  void _removeAt(int index) {
    final updated = [...widget.items]..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.labelLarge),
        if (widget.items.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < widget.items.length; i++)
                Chip(
                  label: Text(widget.items[i]),
                  onDeleted: () => _removeAt(i),
                ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: widget.hintText),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add',
              onPressed: _add,
            ),
          ],
        ),
      ],
    );
  }
}
