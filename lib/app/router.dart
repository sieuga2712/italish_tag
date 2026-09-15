import 'package:go_router/go_router.dart';

import '../pages/home/home_page.dart';
import '../pages/review/review_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/tags/tag_words_page.dart';
import '../pages/tags/tags_page.dart';
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
  ],
);
