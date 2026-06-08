import 'package:flutter/material.dart';

import 'hangul_quiz_recognition_screen.dart';

class CoursScreen extends StatelessWidget {
  const CoursScreen({super.key});

  void _showHangulModulePopup(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hangul'),
          content: const Text(
            'Objectif : apprendre la structure et la lecture du hangul.\n\n'
            'Exercices :\n'
            '• Quizz\n'
            '• Reconnaissance de caractère\n\n'
            'Score max : 100 points',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const HangulQuizAndRecognitionScreen(),
                  ),
                );
              },
              child: const Text("S'entraîner"),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cours')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sélectionnez un module :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Module Hangul
            ElevatedButton.icon(
              onPressed: () => _showHangulModulePopup(context),
              icon: const Icon(Icons.language),
              label: const Text('Hangul'),
            ),

            const SizedBox(height: 20),
            const Text(
              'Autres modules (bloqués) :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            ...[
              'Salutation quotidienne',
              'Vocabulaire de base',
              'Nombre',
              'Voyage',
              'École',
            ].map((theme) {
              return Opacity(
                opacity: 1.0, // Affiché normalement, mais le bouton est bloqué
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // bloqué : ne rien faire
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).disabledColor,
                    ),
                    icon: const Icon(Icons.lock),
                    label: Text(theme),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
