import 'package:flutter/material.dart';

import '../../domain/entities/exercise.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise, this.onTap});

  final ExerciseEntity exercise;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                exercise.type,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                exercise.questionText,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: exercise.options
                    .map((String option) => Chip(label: Text(option)))
                    .toList(),
              ),
              if (onTap != null) ...<Widget>[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Lancer',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.play_circle_outline_rounded, size: 18),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
