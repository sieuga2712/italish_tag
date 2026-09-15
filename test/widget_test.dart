// Smoke test for the app shell: it boots, shows the Home tab by default,
// and the bottom navigation can switch to the other 4 tabs.
//
// Uses an in-memory database (overriding `databaseProvider`) because the
// Words tab has needed a real database since Phase 3 — without this
// override the app would try to open a database file via `path_provider`,
// which has no platform implementation in a plain widget test and hangs.

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocab_library/app/app.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  testWidgets('App boots on Home tab and bottom nav switches tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const VocabApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Home dashboard — coming in a later phase'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(NavigationDestination, 'Words'));
    await tester.pumpAndSettle();
    expect(
      find.text('Chưa có từ nào.\nBấm nút + để thêm từ mới.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(NavigationDestination, 'Tags'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Chưa có tag nào'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Review'));
    await tester.pumpAndSettle();
    expect(find.text('TODAY'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Start Review'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Settings — coming in a later phase'), findsOneWidget);

    // Flush drift's stream-cancellation timer (see quick_add_flow_test.dart
    // for the full explanation) before the test ends.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
