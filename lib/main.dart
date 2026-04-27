import 'package:flutter/material.dart';

void main() {
  runApp(const KBoostApp());
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
      home: const Scaffold(backgroundColor: Colors.white),
    );
  }
}
