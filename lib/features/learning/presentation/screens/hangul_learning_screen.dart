import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';
import '../viewmodels/hangul_viewmodel.dart';
import 'hangul_test_screen.dart';

class HangulLearningScreen extends ConsumerWidget {
  const HangulLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hangulViewModelProvider);

    if (state.selectedLetters.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Module Hangul')),
        body: const Center(child: Text('Aucune session active')),
      );
    }

    final int step = state.currentIndex;
    final List<String> titles = <String>[
      '1. Présentation',
      '2. Découverte',
      '3. Construction',
      '4. Lecture',
      '5. Test',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Leçon Hangul')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(titles[step], style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (step + 1) / 5),
            const SizedBox(height: 16),
            Expanded(child: _buildStepContent(context, state, step)),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: step > 0
                        ? () => ref
                              .read(hangulViewModelProvider.notifier)
                              .previousLessonStep()
                        : null,
                    child: const Text('Précédent'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (step < 4) {
                        ref
                            .read(hangulViewModelProvider.notifier)
                            .nextLessonStep();
                        return;
                      }
                      ref.read(hangulViewModelProvider.notifier).startTest();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const HangulTestScreen(),
                        ),
                      );
                    },
                    child: Text(step < 4 ? 'Suivant' : 'Lancer le test'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    HangulSessionState state,
    int step,
  ) {
    switch (step) {
      case 0:
        return ListView(
          children: <Widget>[
            Text('Consonnes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.selectedConsonants
                  .map(
                    (HangulLetter letter) => Chip(
                      label: Text(
                        '${letter.character} (${letter.romanization})',
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text('Voyelles', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.selectedVowels
                  .map(
                    (HangulLetter letter) => Chip(
                      label: Text(
                        '${letter.character} (${letter.romanization})',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      case 1:
        return ListView(
          children: <Widget>[
            Text(
              'Syllabes générées automatiquement',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.generatedSyllables
                  .map(
                    (HangulSyllable syllable) => Chip(
                      label: Text(
                        '${syllable.character} (${syllable.romanization})',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      case 2:
        return Center(
          child: Text(
            '${state.selectedConsonants.first.character} + ${state.selectedVowels.first.character} → ${state.generatedSyllables.first.character}',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        );
      case 3:
        return ListView(
          children: state.generatedSyllables
              .take(5)
              .map(
                (HangulSyllable syllable) => ListTile(
                  title: Text(
                    syllable.character,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(syllable.romanization),
                ),
              )
              .toList(),
        );
      default:
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  state.trainingMode
                      ? 'Mode entraînement: 50 questions aléatoires'
                      : 'Petit test final: 5 questions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text('Feedback immédiat après chaque réponse.'),
              ],
            ),
          ),
        );
    }
  }
}
