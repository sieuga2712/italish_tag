import 'package:flutter_riverpod/flutter_riverpod.dart';
// `StateProvider` moved here in Riverpod 3 (it's still fully supported —
// just kept out of the main import to nudge new code towards
// `NotifierProvider`). It's the simplest fit for the 3 small, independent
// pieces of UI state below.
import 'package:flutter_riverpod/legacy.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../repositories/word_repository.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return WordRepository(ref.watch(databaseProvider));
}, name: 'wordRepositoryProvider');

/// The current state of the Word List screen's controls. A plain record
/// gets structural `==`/`hashCode` for free, which is exactly what
/// `StreamProvider.family` needs to know when to re-run the query.
typedef WordListQuery = ({
  WordListFilter filter,
  WordSortOption sort,
  String search,
});

/// What filter chip is currently selected on the Word List screen.
final wordListFilterProvider = StateProvider<WordListFilter>(
  (ref) => WordListFilter.all,
  name: 'wordListFilterProvider',
);

/// What sort option is currently selected on the Word List screen.
final wordListSortProvider = StateProvider<WordSortOption>(
  (ref) => WordSortOption.newest,
  name: 'wordListSortProvider',
);

/// The current text in the Word List's search field.
final wordSearchQueryProvider = StateProvider<String>(
  (ref) => '',
  name: 'wordSearchQueryProvider',
);

/// Reactive word list for the given [WordListQuery] (see
/// [WordRepository.watchWords]). Using a `StreamProvider.family` means the
/// list rebuilds automatically whenever the underlying data changes *or*
/// the user changes the filter/sort/search controls.
final wordsListProvider = StreamProvider.family<List<Word>, WordListQuery>((
  ref,
  query,
) {
  return ref
      .watch(wordRepositoryProvider)
      .watchWords(
        filter: query.filter,
        sort: query.sort,
        searchQuery: query.search,
      );
}, name: 'wordsListProvider');

/// One word by id, live — for the Word Detail screen (Phase 6).
final wordByIdProvider = StreamProvider.family<Word, int>((ref, wordId) {
  return ref.watch(wordRepositoryProvider).watchWord(wordId);
}, name: 'wordByIdProvider');
