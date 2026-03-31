import 'package:flutter/material.dart';

import '../../domain/entities/word.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.word,
    required this.onTap,
  });

  final WordEntity word;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(word.word),
        subtitle: Text('${word.translation} • ${word.romanization}'),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
