import 'package:go_router/go_router.dart';

import '../database/app_database.dart';
import '../pages/home/home_page.dart';
import '../pages/review/review_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/tags/tag_words_page.dart';
import '../pages/tags/tags_page.dart';
import '../pages/words/word_detail_page.dart';
import '../pages/words/words_page.dart';
import '../widgets/main_scaffold.dart';

/// App-wide route configuration.
///
/// Uses `StatefulShellRoute.indexedStack` so each of the 5 tabs keeps its own
/// navigation stack and scroll position when the user switches tabs.
/// `MainScaffold` renders the bottom navigation bar and the shared "+" FAB
/// around whichever branch is currently active.
///
/// This is a plain top-level `GoRouter` (not wrapped in a Riverpod provider)
/// because Phase 1 has no state that should influence routing (e.g. no
/// auth/onboarding redirect). If that need appears later, this can be
/// upgraded to a provider without touching the pages themselves.
final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/words',
              builder: (context, state) => const WordsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
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
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/review',
              builder: (context, state) => const ReviewPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    // Top-level (outside the shell) rather than nested under the /words
    // branch: Word Detail is reachable from several different tabs (Words,
    // a tag's word list, Inbox), and covering the whole screen — no bottom
    // nav, a back button instead — makes sense regardless of which tab it
    // was opened from.
    GoRoute(
      path: '/words/:wordId',
      builder: (context, state) {
        final wordId = int.parse(state.pathParameters['wordId']!);
        final initialWord = state.extra as Word?;
        return WordDetailPage(wordId: wordId, initialWord: initialWord);
      },
    ),
  ],
);
