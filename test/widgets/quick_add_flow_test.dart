// Phase 3 widget tests, run against an in-memory database:
// - Quick Add creates a word that shows up in the Inbox
// - Quick Add rejects a case-insensitive duplicate
// - Tapping an Inbox word opens the enrichment sheet and saves the meaning

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';
import 'package:vocab_library/pages/words/words_page.dart';
import 'package:vocab_library/widgets/quick_add_sheet.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  // Drift's stream queries (backing `inboxWordsProvider`) schedule a
  // zero-duration cleanup Timer when their subscription is cancelled, which
  // only happens once `ProviderScope` unmounts. flutter_test asserts no
  // Timer is left pending right after each test body returns, so every
  // test must unmount the tree and pump once *before* returning, to flush
  // that cleanup timer itself rather than leaving it for the framework.
  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    // A plain `pump()` does not fire a zero-duration Timer in flutter_test's
    // fake clock; it needs the clock to actually advance past it.
    await tester.pump(const Duration(milliseconds: 1));
  }

  Widget buildApp() {
    return ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: const WordsPage(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const QuickAddSheet(),
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('quick add creates a word that shows up in the Inbox', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Inbox trống'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'consequently');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('consequently'), findsOneWidget);
    expect(find.textContaining('Chưa có nghĩa'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('quick add rejects a case-insensitive duplicate', (
    tester,
  ) async {
    await db.into(db.words).insert(WordsCompanion.insert(word: 'Efficient'));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'efficient');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.textContaining('đã có trong thư viện'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets(
    'tapping an inbox word opens the complete sheet and saves meaning',
    (tester) async {
      await db.into(db.words).insert(WordsCompanion.insert(word: 'ambiguous'));

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('ambiguous'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Meaning'),
        'không rõ ràng',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.text('không rõ ràng'), findsOneWidget);

      await disposeApp(tester);
    },
  );
}
