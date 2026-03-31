import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/word.dart';
import '../viewmodels/theory_viewmodel.dart';
import '../widgets/word_card.dart';
import 'word_detail_screen.dart';

class TheoryScreen extends ConsumerWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<WordEntity>> wordsState =
        ref.watch(theoryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theorie'),
      ),
      body: wordsState.when(
        data: (List<WordEntity> words) {
          if (words.isEmpty) {
            return const Center(
              child: Text('Aucun mot disponible.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: words.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              final WordEntity word = words[index];

              return WordCard(
                word: word,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => WordDetailScreen(wordId: word.id),
                    ),
                  );
                },
              );
            },
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
                  const Text('Impossible de charger la theorie.'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => ref
                        .read(theoryViewModelProvider.notifier)
                        .loadWords(),
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
