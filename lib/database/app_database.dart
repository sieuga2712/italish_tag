import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/review_history_table.dart';
import 'tables/review_sessions_table.dart';
import 'tables/tags_table.dart';
import 'tables/word_tags_table.dart';
import 'tables/words_table.dart';

part 'app_database.g.dart';

/// The app's single local SQLite database, covering the whole
/// Word/Tag/WordTag/ReviewSession/ReviewHistory schema from the design doc.
@DriftDatabase(tables: [Words, Tags, WordTags, ReviewSessions, ReviewHistory])
class AppDatabase extends _$AppDatabase {
  /// Normal app usage: opens (or creates) `vocab_library.sqlite` in the
  /// platform's app documents directory.
  AppDatabase() : super(_openConnection());

  /// For tests: pass an in-memory executor
  /// (`NativeDatabase.memory()`) instead of touching disk.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    // Schema version 1 is what Phase 2 ships. Any later phase that changes
    // a table (new column, new table, etc.) must bump schemaVersion and add
    // an `onUpgrade` step here rather than editing tables destructively —
    // this is a personal app with real on-device data, so upgrades must be
    // non-destructive from day one.
    beforeOpen: (details) async {
      // SQLite does not enforce foreign keys (so WordTags/ReviewHistory's
      // ON DELETE CASCADE) unless this pragma is set on every connection —
      // it is not a persistent database setting.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'vocab_library.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
