import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/theory/presentation/screens/theory_screen.dart';

void main() {
  runApp(
    const ProviderScope(child: KBoostApp()),
  ); // ProviderScope pour Riverpod
}

class KBoostApp extends StatelessWidget {
  const KBoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Boost',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      debugShowCheckedModeBanner: false,
      home: const TheoryScreen(),
    );
  }
}
