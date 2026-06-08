import 'package:flutter/material.dart';
import 'package:k_boost/features/apprentissage/courses/presentation/screens/cours_screen.dart';
import 'package:k_boost/features/apprentissage/theory/presentation/screens/theory_screen.dart';
import '../widgets/learning_section_card.dart';

class ApprentissageScreen extends StatelessWidget {
  const ApprentissageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apprentissage')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Choisis ton espace d\'apprentissage',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Révise la théorie ou entraîne-toi avec les cours.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          LearningSectionCard(
            title: 'Théorie',
            description:
                'Parcours les mots, leur romanisation et leur traduction.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TheoryScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          LearningSectionCard(
            title: 'Cours',
            description:
                'Entraîne-toi avec les modules et les quiz disponibles.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoursScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
