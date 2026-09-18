// Phase 8 widget tests, run against an in-memory database:
// - Empty state when there are no weak words yet
// - Weak words are listed worst-wrong-rate-first with their counts
// - Review Weak Words starts a session containing only those words

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vocab_library/database/app_database.dart';
import 'package:vocab_library/database/database_provider.dart';
import 'package:vocab_library/pages/review/review_session_args.dart';
import 'package:vocab_library/pages/review/review_session_page.dart';
import 'package:vocab_library/pages/review/weak_words_page.dart';

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
      initialLocation: '/review/weak-words',
      routes: [
        GoRoute(
          path: '/review/weak-words',
          builder: (context, state) => const WeakWordsPage(),
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

  testWidgets('shows an empty state when there are no weak words', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Chưa có từ nào yếu'), findsOneWidget);
    final button = find.widgetWithText(FilledButton, 'Review Weak Words');
    expect(tester.widget<FilledButton>(button).onPressed, isNull);

    await disposeApp(tester);
  });

  testWidgets('lists weak words worst-wrong-rate-first with their counts', (
    tester,
  ) async {
    await db.into(db.words).insert(
      WordsCompanion.insert(
        word: 'somewhat-weak',
        reviewCount: const Value(10),
        wrongCount: const Value(3),
      ),
    );
    await db.into(db.words).insert(
      WordsCompanion.insert(
        word: 'very-weak',
        reviewCount: const Value(5),
        wrongCount: const Value(4),
      ),
    );

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('4 wrong / 5 reviews'), findsOneWidget);
    expect(find.text('3 wrong / 10 reviews'), findsOneWidget);

    final veryWeakY = tester.getCenter(find.text('very-weak')).dy;
    final somewhatWeakY = tester.getCenter(find.text('somewhat-weak')).dy;
    expect(veryWeakY, lessThan(somewhatWeakY));

    await disposeApp(tester);
  });

  testWidgets('Review Weak Words starts a session with only those words', (
    tester,
  ) async {
    await db.into(db.words).insert(
      WordsCompanion.insert(
        word: 'weak-one',
        reviewCount: const Value(5),
        wrongCount: const Value(4),
      ),
    );
    await db.into(db.words).insert(WordsCompanion.insert(word: 'not-weak'));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Review Weak Words'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, '1 / 1'), findsOneWidget);
    expect(find.text('weak-one'), findsOneWidget);
    expect(find.text('not-weak'), findsNothing);

    await disposeApp(tester);
  });
}
