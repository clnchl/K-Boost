import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/example_sentence.dart';
import '../../domain/entities/word.dart';
import 'course_screen.dart';
import '../viewmodels/word_by_id_viewmodel.dart';
import '../viewmodels/word_detail_viewmodel.dart';

class WordDetailScreen extends ConsumerWidget {
  const WordDetailScreen({
    super.key,
    required this.wordId,
  });

  final String wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<WordEntity?> wordState =
        ref.watch(wordByIdViewModelProvider(wordId));
    final AsyncValue<List<ExampleSentenceEntity>> examplesState =
        ref.watch(wordDetailViewModelProvider(wordId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Detail'),
      ),
      body: wordState.when(
        data: (WordEntity? word) {
          if (word == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Mot introuvable.'),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () =>
                          ref.read(wordByIdViewModelProvider(wordId).notifier)
                              .loadWord(),
                      child: const Text('Reessayer'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Text(
                word.word,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(
                '${word.translation} • ${word.romanization}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 18),
              _InfoRow(label: 'Categorie', value: word.category),
              _InfoRow(label: 'Particule', value: word.particle ?? '-'),
              _InfoRow(label: 'Definition', value: word.definition),
              _InfoRow(label: 'Difficulte', value: word.difficulty.toString()),
              _InfoRow(label: 'Lecon', value: word.lessonId),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Audio mock: fonctionnalite backend/tts future.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.volume_up_rounded),
                label: const Text('Ecouter (mock)'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => CourseScreen(
                        lessonIdFilter: word.lessonId,
                        sourceWord: word.word,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz_rounded),
                label: const Text('Voir exercices lies'),
              ),
              const SizedBox(height: 24),
              Text(
                'Exemples',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...examplesState.when(
                data: (List<ExampleSentenceEntity> examples) {
                  if (examples.isEmpty) {
                    return <Widget>[
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Aucun exemple disponible.'),
                        ),
                      ),
                    ];
                  }

                  return examples
                      .map(
                        (ExampleSentenceEntity example) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  example.sentence,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(example.romanization),
                                const SizedBox(height: 2),
                                Text(example.translation),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList();
                },
                loading: () => <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
                error: (Object error, StackTrace stackTrace) => <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Impossible de charger les exemples.'),
                          const SizedBox(height: 8),
                          FilledButton(
                            onPressed: () => ref
                                .read(wordDetailViewModelProvider(wordId)
                                    .notifier)
                                .loadExamples(),
                            child: const Text('Reessayer'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Impossible de charger le mot.'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () =>
                        ref.read(wordByIdViewModelProvider(wordId).notifier)
                            .loadWord(),
                    child: const Text('Reessayer'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
