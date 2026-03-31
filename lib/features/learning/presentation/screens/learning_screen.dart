import 'package:flutter/material.dart';

import 'course_screen.dart';
import 'notes_screen.dart';
import 'theory_screen.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apprentissage'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _LearningSectionCard(
            title: 'Theorie',
            subtitle: 'Vocabulaire et structure grammaticale',
            icon: Icons.menu_book_rounded,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const TheoryScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _LearningSectionCard(
            title: 'Cours',
            subtitle: 'Exercices interactifs bases sur les mots appris',
            icon: Icons.quiz_rounded,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const CourseScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _LearningSectionCard(
            title: 'Notes',
            subtitle: 'Creer et organiser tes notes personnelles',
            icon: Icons.sticky_note_2_rounded,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const NotesScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LearningSectionCard extends StatelessWidget {
  const _LearningSectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                child: Icon(icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
