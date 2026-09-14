import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'quick_add_sheet.dart';

/// Shared shell for the 5 main tabs (Home, Words, Tags, Review, Settings).
///
/// [navigationShell] is provided by go_router's `StatefulShellRoute` — it
/// keeps a separate navigation stack per tab, so switching tabs preserves
/// each tab's scroll position and sub-navigation state.
///
/// The floating "+" button is placed here (not inside WordsPage) because
/// Quick Add should be reachable from every tab, per the product spec.
class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Words'),
    NavigationDestination(icon: Icon(Icons.label_outline), selectedIcon: Icon(Icons.label), label: 'Tags'),
    NavigationDestination(icon: Icon(Icons.style_outlined), selectedIcon: Icon(Icons.style), label: 'Review'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
  ];

  void _onQuickAddPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const QuickAddSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onQuickAddPressed(context),
        tooltip: 'Quick add word',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Tapping the already-selected tab resets its stack to the root.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: _destinations,
      ),
    );
  }
}
