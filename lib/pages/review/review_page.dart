import 'package:flutter/material.dart';

/// Review tab.
///
/// Phase 1 only renders a placeholder. Later phases will add:
/// - Today's queue summary (due / weak / new counts)
/// - Session size picker (5 / 10 / 20 / 30)
/// - "Start Review" entry point into a full-screen review session
class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: const Center(
        child: Text('Review queue — coming in a later phase'),
      ),
    );
  }
}
