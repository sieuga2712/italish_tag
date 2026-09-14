import 'package:flutter/material.dart';

/// Settings tab.
///
/// Phase 1 only renders a placeholder. Later phases will add list tiles for:
/// Daily Goal, Review Settings, Theme, Default Review Mode, Import/Export,
/// Backup, About.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text('Settings — coming in a later phase'),
      ),
    );
  }
}
