import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/tag_providers.dart';

/// Shown when tapping a tag on the Tags screen: every word carrying that
/// tag. Tapping a word opens the Word Detail screen, same as everywhere
/// else, so tags (and everything else) can be edited from here too.
class TagWordsPage extends ConsumerWidget {
  const TagWordsPage({super.key, required this.tagId, required this.tagName});

  final int tagId;
  final String tagName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final words = ref.watch(wordsForTagProvider(tagId));

    return Scaffold(
      appBar: AppBar(title: Text(tagName)),
      body: words.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
        data: (words) {
          if (words.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Chưa có từ nào trong tag này.'),
              ),
            );
          }

          return ListView.separated(
            itemCount: words.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final word = words[index];
              final hasMeaning = (word.meaning ?? '').isNotEmpty;
              return ListTile(
                title: Text(word.word),
                subtitle: Text(hasMeaning ? word.meaning! : 'Chưa có nghĩa'),
                onTap: () => context.push('/words/${word.id}', extra: word),
              );
            },
          );
        },
      ),
    );
  }
}
