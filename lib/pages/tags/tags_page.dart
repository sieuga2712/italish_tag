import 'package:flutter/material.dart';

/// Tags tab.
///
/// Phase 1 only renders a placeholder. Later phases will add:
/// - List of tags with word counts
/// - Create / edit / delete tag
/// - Tap a tag to see its words
class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tags')),
      body: const Center(child: Text('Tag list — coming in a later phase')),
    );
  }
}
