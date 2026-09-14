import 'package:flutter/material.dart';

/// Home tab.
///
/// Phase 1 only renders a placeholder. Later phases will add:
/// - Today's Learning summary (due / new / weak counts)
/// - Daily goal progress bar
/// - "Start Review" button
/// - Recent words list
/// - Tag shortcuts
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Home dashboard — coming in a later phase'),
      ),
    );
  }
}
