import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/learning/presentation/screens/learning_screen.dart';

void main() {
  runApp(const ProviderScope(child: KBoostApp()));
}

class KBoostApp extends StatelessWidget {
  const KBoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Boost',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const LearningScreen(),
    );
  }
}
