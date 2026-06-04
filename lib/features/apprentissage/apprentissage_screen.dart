import 'package:flutter/material.dart';
import 'package:k_boost/features/apprentissage/theory/presentation/screens/theory_screen.dart';
import 'package:k_boost/features/apprentissage/courses/presentation/screens/cours_screen.dart';



class ApprentissageScreen extends StatelessWidget {
  const ApprentissageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apprentissage')),
      body: Column(
        children: [
          const Text('Bienvenue dans l\'écran d\'apprentissage!'),
          ListTile(
            title: const Text('théorie'),
            onTap: () {
              // Aller a la page theorie
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TheoryScreen(),
                ),
              );
            },
            // Ajoutez d'autres ListTile pour les autres sections d'apprentissage
            ),
          ListTile(
              title: const Text('cours'),
              onTap: () {
                // Aller a la page cours (à implémenter)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoursScreen(),
                  ),
                );
              },
            ),
          // Ajoutez ici les widgets spécifiques à l\'apprentissage
        ],
      )
    );
  }
}