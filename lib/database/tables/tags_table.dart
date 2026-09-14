import 'package:drift/drift.dart';

@DataClassName('Tag')
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Enforced unique case-sensitively; case-insensitive duplicate checks
  /// (e.g. "IT" vs "it") are done at the repository layer, same reasoning
  /// as `Words.word`.
  TextColumn get name => text().unique()();

  /// Optional hex color (e.g. "#3D5AFE") so the UI can color-code tag
  /// groups (level / topic / part-of-speech).
  TextColumn get color => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
