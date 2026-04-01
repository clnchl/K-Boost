import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/hangul_viewmodel.dart';
import 'hangul_test_screen.dart';

class HangulLearningScreen extends ConsumerWidget {
  const HangulLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hangulViewModelProvider);

    if (state.selectedLetters.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Apprentissage Hangul')),
        body: const Center(child: Text('Aucune lettre sélectionnée')),
      );
    }

    final currentLetter = state.selectedLetters[state.currentIndex];
    final isLastLetter = state.currentIndex == state.selectedLetters.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apprentissage Hangul'),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          // Barre de progression
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Lettre ${state.currentIndex + 1} / ${state.selectedLetters.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Chip(label: Text(state.selectedCategory?.name ?? 'Autres')),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value:
                      (state.currentIndex + 1) / state.selectedLetters.length,
                ),
              ],
            ),
          ),
          // Contenu principal
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Grande affichage de la lettre
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Text(
                      currentLetter.character,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Romanisation
                Text(
                  'Prononciation',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Text(
                      currentLetter.romanization,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Boutons de contrôle
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Boutons de navigation
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: state.currentIndex > 0
                            ? () => ref
                                  .read(hangulViewModelProvider.notifier)
                                  .previousLetter()
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Précédent'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: !isLastLetter
                            ? () => ref
                                  .read(hangulViewModelProvider.notifier)
                                  .nextLetter()
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Suivant'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Bouton test
                FilledButton.icon(
                  onPressed: () {
                    // Démarrer le mode test
                    ref.read(hangulViewModelProvider.notifier).startTest();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const HangulTestScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.quiz_rounded),
                  label: const Text('Passer au test'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
