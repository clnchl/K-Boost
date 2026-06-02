import 'package:flutter/material.dart';
class CoursScreen extends StatelessWidget {
  const CoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cours')),
      body: const Center(child: Text('Contenu du cours')),
    );
  }
}