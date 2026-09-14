import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

void main() {
  // Wrapping the whole app in ProviderScope now (even though no provider
  // exists yet) so Phase 2's database/repository providers can be added
  // without touching this entry point again.
  runApp(const ProviderScope(child: VocabApp()));
}
