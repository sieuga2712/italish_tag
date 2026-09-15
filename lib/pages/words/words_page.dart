import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/word_providers.dart';
import '../../repositories/word_repository.dart';
import '../../widgets/complete_word_sheet.dart';

String _filterLabel(WordListFilter filter) => switch (filter) {
  WordListFilter.all => 'All',
  WordListFilter.inbox => 'Inbox',
  WordListFilter.newWord => 'New',
  WordListFilter.learning => 'Learning',
  WordListFilter.reviewing => 'Reviewing',
  WordListFilter.mastered => 'Mastered',
};

String _sortLabel(WordSortOption sort) => switch (sort) {
  WordSortOption.alphabeticalAsc => 'A-Z',
  WordSortOption.alphabeticalDesc => 'Z-A',
  WordSortOption.newest => 'Newest',
  WordSortOption.oldest => 'Oldest',
  WordSortOption.mostReviewed => 'Most reviewed',
  WordSortOption.leastReviewed => 'Least reviewed',
  WordSortOption.nextReviewSoonest => 'Next review',
};

String _emptyStateMessage(WordListFilter filter, String search) {
  if (search.trim().isNotEmpty) {
    return 'Không tìm thấy từ nào phù hợp với "$search".';
  }
  return switch (filter) {
    WordListFilter.inbox => 'Inbox trống.\nBấm nút + để thêm từ mới.',
    WordListFilter.all => 'Chưa có từ nào.\nBấm nút + để thêm từ mới.',
    _ => 'Không có từ nào ở trạng thái này.',
  };
}

/// Words tab — the full word list, with search, status filter chips
/// (including the Phase 3 Inbox as one filter among several) and sorting.
class WordsPage extends ConsumerStatefulWidget {
  const WordsPage({super.key});

  @override
  ConsumerState<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends ConsumerState<WordsPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(wordSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(wordListFilterProvider);
    final sort = ref.watch(wordListSortProvider);
    final search = ref.watch(wordSearchQueryProvider);
    final words = ref.watch(
      wordsListProvider((filter: filter, sort: sort, search: search)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Words'),
        actions: [
          PopupMenuButton<WordSortOption>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            initialValue: sort,
            onSelected: (value) =>
                ref.read(wordListSortProvider.notifier).state = value,
            itemBuilder: (context) => WordSortOption.values
                .map(
                  (option) => PopupMenuItem(
                    value: option,
                    child: Text(_sortLabel(option)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) =>
                  ref.read(wordSearchQueryProvider.notifier).state = value,
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: WordListFilter.values.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final option = WordListFilter.values[index];
                return ChoiceChip(
                  label: Text(_filterLabel(option)),
                  selected: filter == option,
                  onSelected: (_) =>
                      ref.read(wordListFilterProvider.notifier).state = option,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: words.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
              data: (words) {
                if (words.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _emptyStateMessage(filter, search),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: words.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final word = words[index];
                    return _WordListTile(word: word);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WordListTile extends ConsumerWidget {
  const _WordListTile({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasMeaning = (word.meaning ?? '').isNotEmpty;

    return ListTile(
      title: Text(word.word),
      subtitle: Text(
        hasMeaning ? word.meaning! : 'Chưa có nghĩa — bấm để bổ sung',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              word.favorite ? Icons.star : Icons.star_border,
              color: word.favorite ? Colors.amber : null,
            ),
            tooltip: word.favorite ? 'Unfavorite' : 'Favorite',
            onPressed: () => ref
                .read(wordRepositoryProvider)
                .toggleFavorite(word.id, !word.favorite),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => CompleteWordSheet(word: word),
        );
      },
    );
  }
}
