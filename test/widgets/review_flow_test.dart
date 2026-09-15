// Phase 7 widget tests, run against an in-memory database:
// - Start Review builds a queue and opens the flashcard flow
// - Show Answer reveals the meaning, then rating advances to the next word
// - Finishing the queue shows the Review Complete summary
// - Start Review with nothing to review shows a message instead of opening

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';
import 'package:vocab_library/pages/review/review_page.dart';
import 'package:vocab_library/pages/review/review_session_args.dart';
import 'package:vocab_library/pages/review/review_session_page.dart';

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
      initialLocation: '/review',
      routes: [
        GoRoute(
          path: '/review',
          builder: (context, state) => const ReviewPage(),
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

  testWidgets('Start Review with nothing due shows a message', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Due'), findsOneWidget);
    expect(find.text('0', skipOffstage: false), findsWidgets);

    await tester.tap(find.widgetWithText(FilledButton, 'Start Review'));
    await tester.pumpAndSettle();

    expect(find.text('Không có từ nào cần ôn lúc này.'), findsOneWidget);
    // Didn't navigate away from the Review tab.
    expect(find.widgetWithText(AppBar, 'Review'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets(
    'reviewing a word: Show Answer reveals meaning, rating advances',
    (tester) async {
      await db
          .into(db.words)
          .insert(
            WordsCompanion.insert(
              word: 'efficient',
              meaning: const Value('hiệu quả'),
            ),
          );
      await db
          .into(db.words)
          .insert(
            WordsCompanion.insert(
              word: 'ambiguous',
              meaning: const Value('không rõ ràng'),
            ),
          );

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Start Review'));
      await tester.pumpAndSettle();

      // Now in the session, on question 1 of 2.
      expect(find.widgetWithText(AppBar, '1 / 2'), findsOneWidget);
      expect(find.text('hiệu quả'), findsNothing); // not revealed yet

      await tester.tap(find.widgetWithText(FilledButton, 'Show Answer'));
      await tester.pumpAndSettle();

      expect(find.text('hiệu quả'), findsOneWidget);

      await tester.tap(find.text('Nhớ')); // Good
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, '2 / 2'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Show Answer'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Quên')); // Forgot
      await tester.pumpAndSettle();

      // Queue exhausted -> completion summary.
      expect(find.widgetWithText(AppBar, 'Review Complete'), findsOneWidget);
      expect(find.text('2 words reviewed'), findsOneWidget);
      expect(find.text('1 correct · 1 wrong'), findsOneWidget);

      final words = await db.select(db.words).get();
      final efficient = words.firstWhere((w) => w.word == 'efficient');
      final ambiguous = words.firstWhere((w) => w.word == 'ambiguous');
      expect(efficient.reviewCount, 1);
      expect(efficient.correctCount, 1);
      expect(ambiguous.wrongCount, 1);

      await tester.tap(find.widgetWithText(FilledButton, 'Done'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Review'), findsOneWidget);

      await disposeApp(tester);
    },
  );
}
