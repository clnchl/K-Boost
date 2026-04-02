import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  int _selectedCount = 4;
  bool _trainingMode = false;
  Set<HangulExerciseType> _selectedExerciseTypes = HangulExerciseType.values
      .toSet();

  void _startSession() {
    ref
        .read(hangulViewModelProvider.notifier)
        .configureSession(
          letterCount: _selectedCount,
          trainingMode: _trainingMode,
          selectedExerciseTypes: _selectedExerciseTypes.toList(),
        );

    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HangulLearningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int consonantCount = ref.watch(hangulConsonantCountProvider);
    final int vowelCount = ref.watch(hangulVowelCountProvider);
    final int totalAlphabetCount = ref.watch(hangulAlphabetTotalCountProvider);
    final bool isFullAlphabet = _selectedCount == totalAlphabetCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Module Hangul')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Session par paires',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isFullAlphabet
                            ? 'Tout l\'alphabet: $consonantCount consonnes + $vowelCount voyelles'
                            : '$_selectedCount lettres = ${_selectedCount ~/ 2} consonnes + ${_selectedCount ~/ 2} voyelles',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nombre de lettres par session',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  ...<int>[4, 6, 8].map((int count) {
                    return ChoiceChip(
                      label: Text('$count lettres'),
                      selected: _selectedCount == count,
                      onSelected: (_) {
                        setState(() {
                          _selectedCount = count;
                        });
                      },
                    );
                  }),
                  ChoiceChip(
                    label: const Text('Tout l\'alphabet'),
                    selected: isFullAlphabet,
                    onSelected: (_) {
                      setState(() {
                        _selectedCount = totalAlphabetCount;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Types d\'exercices à entraîner',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: HangulExerciseType.values.map((
                  HangulExerciseType type,
                ) {
                  final bool selected = _selectedExerciseTypes.contains(type);
                  return FilterChip(
                    label: Text(_exerciseTypeLabel(type)),
                    selected: selected,
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _selectedExerciseTypes.add(type);
                        } else if (_selectedExerciseTypes.length > 1) {
                          _selectedExerciseTypes.remove(type);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Text(
                'Sélectionnez au moins 1 type d\'exercice.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                value: _trainingMode,
                onChanged: (bool value) {
                  setState(() {
                    _trainingMode = value;
                  });
                },
                title: const Text('Mode entraînement libre'),
                subtitle: const Text('50 questions aléatoires'),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _startSession,
                icon: Icon(_trainingMode ? Icons.fitness_center : Icons.school),
                label: Text(
                  _trainingMode
                      ? 'Démarrer entraînement (50 questions)'
                      : 'Démarrer leçon (5 exercices + test)',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _exerciseTypeLabel(HangulExerciseType type) {
    switch (type) {
      case HangulExerciseType.qcmReading:
        return 'QCM lecture';
      case HangulExerciseType.syllableComposition:
        return 'Construire syllabe';
      case HangulExerciseType.audioRecognition:
        return 'Reconnaissance audio';
      case HangulExerciseType.romanizationToHangul:
        return 'Romanisation → Hangul';
      case HangulExerciseType.hangulToRomanization:
        return 'Hangul → Romanisation';
      case HangulExerciseType.keyboardWriting:
        return 'Écriture clavier';
      case HangulExerciseType.dragDropComposition:
        return 'Drag & drop';
    }
  }
}
