// Smoke test for Phase 1: the app boots, shows the Home tab by default, and
// the bottom navigation can switch to the other 4 tabs.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocab_library/app/app.dart';

void main() {
  testWidgets('App boots on Home tab and bottom nav switches tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: VocabApp()));
    await tester.pumpAndSettle();

    expect(find.text('Home dashboard — coming in a later phase'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Words'));
    await tester.pumpAndSettle();
    expect(find.text('Word list — coming in a later phase'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Tags'));
    await tester.pumpAndSettle();
    expect(find.text('Tag list — coming in a later phase'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Review'));
    await tester.pumpAndSettle();
    expect(find.text('Review queue — coming in a later phase'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Settings — coming in a later phase'), findsOneWidget);
  });
}
