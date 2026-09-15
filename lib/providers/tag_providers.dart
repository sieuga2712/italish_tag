import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../repositories/tag_repository.dart';

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  return TagRepository(ref.watch(databaseProvider));
}, name: 'tagRepositoryProvider');

/// Every tag with its word count, for the Tags screen.
final tagsWithCountsProvider = StreamProvider<List<TagWithCount>>((ref) {
  return ref.watch(tagRepositoryProvider).watchTagsWithCounts();
}, name: 'tagsWithCountsProvider');

/// Every tag, no count — for the "assign a tag to this word" picker.
final allTagsProvider = StreamProvider<List<Tag>>((ref) {
  return ref.watch(tagRepositoryProvider).watchAllTags();
}, name: 'allTagsProvider');

/// Tags currently assigned to one word.
final tagsForWordProvider = StreamProvider.family<List<Tag>, int>((
  ref,
  wordId,
) {
  return ref.watch(tagRepositoryProvider).watchTagsForWord(wordId);
}, name: 'tagsForWordProvider');

/// Words currently carrying one tag, for the tag detail screen.
final wordsForTagProvider = StreamProvider.family<List<Word>, int>((
  ref,
  tagId,
) {
  return ref.watch(tagRepositoryProvider).watchWordsForTag(tagId);
}, name: 'wordsForTagProvider');
