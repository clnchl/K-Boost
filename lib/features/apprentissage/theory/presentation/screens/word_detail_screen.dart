import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/categories_viewmodel.dart';

// Écran: détails 
class WordDetailScreen extends ConsumerWidget {
  final String wordId;
  final String wordKorean;

  const WordDetailScreen({
    super.key,
    required this.wordId,
    required this.wordKorean,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Charge les détails du mot avec le provider.family
    final wordDetailAsync = ref.watch(wordDetailProvider(wordId));

    return Scaffold(
      appBar: AppBar(title: Text(wordKorean)),
      body: wordDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Erreur: $error')),
        data: (wordDetail) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MOT EN CORÉEN
                  Text(
                    wordDetail.korean,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ROMANISATION
                  Text(
                    wordDetail.romanisation,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // TRADUCTION 
                  Text(
                    wordDetail.translation,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const Divider(height: 32),

                  // TYPE GRAMMATICAL 
                  _buildDetailRow(
                    label: 'Type grammatical',
                    value: wordDetail.grammaticalType,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 24),

                  // PHRASE D'EXEMPLE 
                  _buildDetailSection(
                    title: 'Exemple d\'utilisation',
                    content: wordDetail.exampleSentence,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget réutilisable pour une ligne de détail
  Widget _buildDetailRow({
    required String label,
    required String value,
    Color? color,
  }) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Flexible(
          child: Text(value, style: TextStyle(fontSize: 16, color: color)),
        ),
      ],
    );
  }

  // Widget réutilisable pour une section
  Widget _buildDetailSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
