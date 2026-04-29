import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/categories_viewmodel.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe le provider qui charge les catégories
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catégories')),
      body: categoriesAsync.when(
        // Cas 1️: données en cours de chargement
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        // Cas 2️: erreur
        error: (error, stackTrace) {
          return Center(child: Text('Erreur: $error'));
        },
        // Cas 3️: données chargées avec succès
        data: (categories) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name),
                onTap: () {
                  print('Catégorie sélectionnée: ${category.name}');
              
                },
              );
            },
          );
        },
      ),
    );
  }
}
