import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/categories_viewmodel.dart';
import 'word_detail_screen.dart';

class TheoryScreen extends ConsumerWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe les données Riverpod
    final categoriesAsync = ref.watch(categoriesProvider);
    final wordsAsync = ref.watch(selectedWordsProvider);
    final selectedCategoryId = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Théorie')),
      body: Column(
        children: [
          
          SizedBox(
            height: 60,
            child: categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Erreur: $error')),
              data: (categories) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategoryId == category.id;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                        label: Text(category.name),
                        selected: isSelected,
                        onSelected: (_) {
                          // Mettre à jour la catégorie sélectionnée
                          ref.read(selectedCategoryProvider.notifier).state =
                              category.id;
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),

          Expanded(
            child: wordsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Erreur: $error')),
              data: (words) {
                if (words.isEmpty) {
                  return const Center(
                    child: Text('Aucun mot. Sélectionnez une catégorie.'),
                  );
                }

                return ListView.builder(
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    final word = words[index];
                    return ListTile(
                      title: Text(
                        word.korean,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            word.romanisation,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(word.translation),
                        ],
                      ),
                      onTap: () {
                        // Aller au détail du mot
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordDetailScreen(
                              wordId: word.id,
                              wordKorean: word.korean,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
