import 'package:drift/drift.dart';

import 'tags_table.dart';
import 'words_table.dart';

/// Join table implementing the many-to-many relationship between
/// [Words] and [Tags]. Composite primary key means the same
/// (wordId, tagId) pair can never be inserted twice.
@TableIndex(name: 'word_tags_tag_id', columns: {#tagId})
class WordTags extends Table {
  IntColumn get wordId =>
      integer().references(Words, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {wordId, tagId};
}
