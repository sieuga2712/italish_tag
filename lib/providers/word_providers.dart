import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../repositories/word_repository.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return WordRepository(ref.watch(databaseProvider));
}, name: 'wordRepositoryProvider');

/// Reactive list of Inbox words (see [WordRepository.watchInboxWords]).
/// Using a `StreamProvider` means every page watching this rebuilds
/// automatically the moment a word is added, tagged, or edited — no manual
/// refresh calls anywhere.
final inboxWordsProvider = StreamProvider<List<Word>>((ref) {
  return ref.watch(wordRepositoryProvider).watchInboxWords();
}, name: 'inboxWordsProvider');
