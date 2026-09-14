import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/word_providers.dart';
import '../../widgets/complete_word_sheet.dart';

/// Words tab.
///
/// Phase 3 only shows the Inbox (words with no tags yet — see
/// `WordRepository.watchInboxWords`), since that is the only list that
/// exists so far. Phase 4 will turn this into the full word list with
/// search, status filter chips and sorting, of which Inbox will become one
/// view among several rather than the whole page.
class WordsPage extends ConsumerWidget {
  const WordsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inboxWords = ref.watch(inboxWordsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Words')),
      body: inboxWords.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
        data: (words) {
          if (words.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Inbox trống.\nBấm nút + để thêm từ mới.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: words.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final word = words[index];
              final hasMeaning = (word.meaning ?? '').isNotEmpty;
              return ListTile(
                title: Text(word.word),
                subtitle: Text(
                  hasMeaning ? word.meaning! : 'Chưa có nghĩa — bấm để bổ sung',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => CompleteWordSheet(word: word),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
