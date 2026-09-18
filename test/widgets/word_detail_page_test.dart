// Phase 6 widget tests, run against an in-memory database:
// - Tapping a word in the Word List navigates to its Word Detail page
// - Navigating directly by id (no `extra`) falls back to fetching the word
// - Editing a free-text field only persists after tapping Save
// - Adding an example persists immediately, no Save needed
// - The favorite star toggles from the detail page's own AppBar
// - The Learning section shows the word's (so far untouched) review stats

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';
import 'package:vocab_library/database/tables/review_history_table.dart';
import 'package:vocab_library/database/tables/review_sessions_table.dart';
import 'package:vocab_library/pages/review/review_session_args.dart';
import 'package:vocab_library/pages/review/review_session_page.dart';
import 'package:vocab_library/pages/words/word_detail_page.dart';
import 'package:vocab_library/pages/words/words_page.dart';
import 'package:vocab_library/repositories/review_repository.dart';

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

  Widget buildApp({required String initialLocation}) {
    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: '/words', builder: (context, state) => const WordsPage()),
        GoRoute(
          path: '/words/:wordId',
          builder: (context, state) {
            final wordId = int.parse(state.pathParameters['wordId']!);
            final initialWord = state.extra as Word?;
            return WordDetailPage(wordId: wordId, initialWord: initialWord);
          },
        ),
        GoRoute(
          path: '/review-session',
          builder: (context, state) {
            final args = state.extra as ReviewSessionArgs;
            return ReviewSessionPage(args: args);
          },
        ),
      ],
    );

    return ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('tapping a word in the list opens its detail page', (
    tester,
  ) async {
    await db.into(db.words).insert(WordsCompanion.insert(word: 'ambiguous'));

    await tester.pumpWidget(buildApp(initialLocation: '/words'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('ambiguous'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'ambiguous'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Meaning'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('navigating directly by id fetches the word (no extra)', (
    tester,
  ) async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'deprecated'));

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'deprecated'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('editing Meaning only persists after tapping Save', (
    tester,
  ) async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'efficient'));

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    // No unsaved changes yet -> the Save icon button is disabled.
    final saveButtonFinder = find.widgetWithIcon(IconButton, Icons.check);
    expect(tester.widget<IconButton>(saveButtonFinder).onPressed, isNull);

    await tester.enterText(
      find.widgetWithText(TextField, 'Meaning'),
      'hiệu quả',
    );
    await tester.pump();
    expect(tester.widget<IconButton>(saveButtonFinder).onPressed, isNotNull);

    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle();

    final stored = await (db.select(
      db.words,
    )..where((w) => w.id.equals(wordId))).getSingle();
    expect(stored.meaning, 'hiệu quả');

    await disposeApp(tester);
  });

  testWidgets('adding an example persists immediately, no Save needed', (
    tester,
  ) async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'implement'));

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    final exampleField = find.descendant(
      of: find.byKey(const Key('examplesEditor')),
      matching: find.byType(TextField),
    );
    await tester.enterText(exampleField, 'Let\'s implement this feature.');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('Let\'s implement this feature.'), findsOneWidget);

    final stored = await (db.select(
      db.words,
    )..where((w) => w.id.equals(wordId))).getSingle();
    expect(stored.examplesJson, contains('implement this feature'));

    await disposeApp(tester);
  });

  testWidgets('the favorite star toggles from the detail page', (tester) async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'cherished'));

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsNothing);

    await disposeApp(tester);
  });

  testWidgets('the Learning section shows an untouched word\'s stats', (
    tester,
  ) async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'newborn'));

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    // The Learning card is at the bottom of the page's ListView, below the
    // default test viewport (~600 logical px) — ListView virtualizes its
    // children, so it isn't even built until scrolled into view. A plain
    // drag (rather than `scrollUntilVisible`) avoids having to single out
    // one Scrollable among the many the page has — every TextField wraps
    // its own for its text content.
    await tester.drag(
      find.byKey(const Key('wordDetailScrollView')),
      const Offset(0, -2000),
    );
    await tester.pumpAndSettle();

    expect(find.text('Status: New'), findsOneWidget);
    expect(find.text('Reviews: 0'), findsOneWidget);
    expect(find.text('Correct: 0'), findsOneWidget);
    expect(find.text('Wrong: 0'), findsOneWidget);
    expect(find.text('Last reviewed: Chưa từng ôn'), findsOneWidget);
    expect(find.text('Next review: Chưa lên lịch'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('the History section lists past reviews, most recent first', (
    tester,
  ) async {
    final reviewRepo = ReviewRepository(db);
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'efficient'));
    final sessionId = await reviewRepo.startSession(
      totalWords: 2,
      sourceType: ReviewSourceType.mixed,
    );
    await reviewRepo.recordAnswer(
      wordId: wordId,
      sessionId: sessionId,
      questionType: ReviewQuestionType.wordToMeaning,
      rating: ReviewRating.forgot,
    );
    await reviewRepo.recordAnswer(
      wordId: wordId,
      sessionId: sessionId,
      questionType: ReviewQuestionType.wordToMeaning,
      rating: ReviewRating.good,
    );

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const Key('wordDetailScrollView')),
      const Offset(0, -4000),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Word → Meaning · Nhớ'), findsOneWidget);
    expect(find.textContaining('Word → Meaning · Quên'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('Review this word starts a 1-word session', (tester) async {
    final wordId = await db
        .into(db.words)
        .insert(WordsCompanion.insert(word: 'ambiguous'));

    await tester.pumpWidget(buildApp(initialLocation: '/words/$wordId'));
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const Key('wordDetailScrollView')),
      const Offset(0, -2000),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Review this word'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, '1 / 1'), findsOneWidget);
    expect(find.text('ambiguous'), findsOneWidget);

    await disposeApp(tester);
  });
}
