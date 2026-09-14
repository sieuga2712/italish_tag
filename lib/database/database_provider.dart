import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Single shared [AppDatabase] instance for the whole app.
///
/// `Provider` is not auto-dispose by default, which is what we want here:
/// the database connection must survive for the entire app lifetime, not
/// just while some widget that reads it happens to be mounted.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}, name: 'databaseProvider');
