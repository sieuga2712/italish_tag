// Phase 5 widget tests, run against an in-memory database:
// - Creating a tag adds it to the list with a "0 words" count
// - Tapping a tag navigates to its (filtered) word list

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';
import 'package:vocab_library/pages/tags/tag_words_page.dart';
import 'package:vocab_library/pages/tags/tags_page.dart';

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
    final router = GoRouter(
      initialLocation: '/tags',
      routes: [
        GoRoute(
          path: '/tags',
          builder: (context, state) => const TagsPage(),
          routes: [
            GoRoute(
              path: ':tagId',
              builder: (context, state) {
                final tagId = int.parse(state.pathParameters['tagId']!);
                final tagName = state.extra as String? ?? '';
                return TagWordsPage(tagId: tagId, tagName: tagName);
              },
            ),
          ],
        ),
      ],
    );

    return ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('creating a tag adds it to the list with 0 words', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Chưa có tag nào'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'IT');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('IT'), findsOneWidget);
    expect(find.text('0 words'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('tapping a tag navigates to its word list', (tester) async {
    final tagId = await db
        .into(db.tags)
        .insert(TagsCompanion.insert(name: 'IT'));
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'efficient'));
    await db
        .into(db.wordTags)
        .insert(WordTagsCompanion.insert(wordId: wordId, tagId: tagId));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('IT'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'IT'), findsOneWidget);
    expect(find.text('efficient'), findsOneWidget);

    await disposeApp(tester);
  });
}
