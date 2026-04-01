import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';
import '../viewmodels/hangul_progress_viewmodel.dart';
import '../viewmodels/hangul_viewmodel.dart';
import 'hangul_learning_screen.dart';

class HangulCategorySelectionScreen extends ConsumerStatefulWidget {
  const HangulCategorySelectionScreen({super.key});

  @override
  ConsumerState<HangulCategorySelectionScreen> createState() =>
      _HangulCategorySelectionScreenState();
}

class _HangulCategorySelectionScreenState
    extends ConsumerState<HangulCategorySelectionScreen> {
  HangulCategory? _selectedCategory;
  late int _selectedCount;

  @override
  void initState() {
    super.initState();
    _selectedCount = 2; // Valeur par défaut
  }

  void _startLearning() {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une catégorie')),
      );
      return;
    }

    // Utiliser le viewmodel pour configurer la session
    ref
        .read(hangulViewModelProvider.notifier)
        .selectCategoryWithCount(_selectedCategory!, _selectedCount);

    // Naviguer vers l'écran d'apprentissage
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HangulLearningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<HangulCategory> categories = ref.watch(hangulCategoriesProvider);
    final double courseProgress = ref.watch(hangulCourseProgressProvider);
    final int completedCourseExercises = ref.watch(
      hangulCourseCompletedCountProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Apprentissage Hangul')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Instructions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Comment commencer ?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1. Sélectionnez une catégorie\n'
                        '2. Choisissez le nombre de lettres\n'
                        '3. Apprenez et testez-vous',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Progression du cours Hangul',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: courseProgress),
                      const SizedBox(height: 8),
                      Text(
                        '$completedCourseExercises / 4 exercices terminés',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sélection de catégorie
              Text(
                'Choisir une catégorie',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...categories.map(
                (HangulCategory category) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: RadioListTile<HangulCategory>(
                      title: Text(category.name),
                      subtitle: Text(category.description),
                      value: category,
                      groupValue: _selectedCategory,
                      onChanged: (HangulCategory? value) {
                        setState(() {
                          _selectedCategory = value;
                          // Réajuster le count si nécessaire
                          if (_selectedCount > (value?.letters.length ?? 0)) {
                            _selectedCount = value?.letters.length ?? 2;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sélection du nombre d'éléments
              if (_selectedCategory != null) ...<Widget>[
                Text(
                  'Nombre de lettres à apprendre',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Slider
                        Slider(
                          value: _selectedCount.toDouble(),
                          min: 1,
                          max: _selectedCategory!.letters.length.toDouble(),
                          divisions: _selectedCategory!.letters.length - 1,
                          label: _selectedCount.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _selectedCount = value.toInt();
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        // Affichage du compte sélectionné
                        Center(
                          child: Chip(
                            label: Text(
                              '$_selectedCount / ${_selectedCategory!.letters.length} lettres',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Preset buttons
                        Wrap(
                          spacing: 8,
                          children: <int>[2, 4, 6].map((int count) {
                            return OutlinedButton(
                              onPressed:
                                  count <= _selectedCategory!.letters.length
                                  ? () {
                                      setState(() {
                                        _selectedCount = count;
                                      });
                                    }
                                  : null,
                              child: Text(count.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Bouton de démarrage
              FilledButton.icon(
                onPressed: _startLearning,
                icon: const Icon(Icons.school_rounded),
                label: const Text('Commencer l\'apprentissage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
