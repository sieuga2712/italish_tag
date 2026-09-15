// Phase 4 widget tests, run against an in-memory database:
// - Search narrows the list by word text
// - Status filter chips narrow the list (Inbox included as one of them)
// - The favorite star toggles on tap
// - The sort menu changes list order

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';
import 'package:vocab_library/database/tables/words_table.dart';
import 'package:vocab_library/pages/words/words_page.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  // See quick_add_flow_test.dart for why this is necessary: drift's stream
  // queries schedule a cleanup Timer on unsubscribe that must be flushed
  // before the test body returns.
  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  }

  Widget buildApp() {
    return ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const MaterialApp(home: WordsPage()),
    );
  }

  testWidgets('search narrows the list by word text', (tester) async {
    await db.into(db.words).insert(WordsCompanion.insert(word: 'apple'));
    await db.into(db.words).insert(WordsCompanion.insert(word: 'banana'));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('apple'), findsOneWidget);
    expect(find.text('banana'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'app');
    await tester.pumpAndSettle();

    expect(find.text('apple'), findsOneWidget);
    expect(find.text('banana'), findsNothing);

    await disposeApp(tester);
  });

  testWidgets('status filter chips narrow the list', (tester) async {
    await db.into(db.words).insert(WordsCompanion.insert(word: 'newborn'));
    await db
        .into(db.words)
        .insert(
          WordsCompanion.insert(
            word: 'veteran',
            status: const Value(WordStatus.mastered),
          ),
        );

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('newborn'), findsOneWidget);
    expect(find.text('veteran'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Mastered'));
    await tester.pumpAndSettle();

    expect(find.text('veteran'), findsOneWidget);
    expect(find.text('newborn'), findsNothing);

    await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
    await tester.pumpAndSettle();

    expect(find.text('newborn'), findsOneWidget);
    expect(find.text('veteran'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('tapping the favorite star toggles it', (tester) async {
    await db.into(db.words).insert(WordsCompanion.insert(word: 'cherished'));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star_border), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNothing);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsNothing);

    await disposeApp(tester);
  });

  testWidgets('A-Z sort reorders the list alphabetically', (tester) async {
    // Inserted in this order so the default "Newest" sort would show
    // "banana" above "apple" - a real difference for the A-Z sort to fix.
    await db.into(db.words).insert(WordsCompanion.insert(word: 'banana'));
    await db.into(db.words).insert(WordsCompanion.insert(word: 'apple'));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    final bananaBefore = tester.getCenter(find.text('banana')).dy;
    final appleBefore = tester.getCenter(find.text('apple')).dy;
    expect(bananaBefore, lessThan(appleBefore));

    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    await tester.tap(find.text('A-Z'));
    await tester.pumpAndSettle();

    final appleAfter = tester.getCenter(find.text('apple')).dy;
    final bananaAfter = tester.getCenter(find.text('banana')).dy;
    expect(appleAfter, lessThan(bananaAfter));

    await disposeApp(tester);
  });
}
