import 'package:flutter/material.dart';

import '../../domain/entities/exercise_learning.dart';

Color parseThemeColor(String? hexColor) {
  if (hexColor == null) {
    return Colors.purple;
  }
  try {
    return Color(int.parse('0xFF${hexColor.replaceFirst('#', '')}'));
  } catch (_) {
    return Colors.purple;
  }
}

IconData themeIconData(String icon) => switch (icon.toLowerCase()) {
  'hangul' => Icons.language_rounded,
  'chat' => Icons.chat_rounded,
  'brain' => Icons.psychology_rounded,
  'calculator' => Icons.calculate_rounded,
  'book' => Icons.menu_book_rounded,
  'star' => Icons.star_rounded,
  _ => Icons.school_rounded,
};

String exerciseTypeLabel(String type) => switch (type) {
  ExerciseType.multipleChoice => 'QCM',
  ExerciseType.audioChoice => 'Choix audio',
  ExerciseType.memory => 'Memory',
  ExerciseType.translation => 'Traduction',
  ExerciseType.sentenceOrder => 'Ordre des phrases',
  ExerciseType.fillBlank => 'Texte à trous',
  ExerciseType.writing => 'Écriture',
  ExerciseType.dictation => 'Dictée',
  ExerciseType.grammar => 'Grammaire',
  _ => 'Exercice',
};

String exerciseStageLabel(String type) => learningStageLabel(type);

Widget exerciseMetaChips(String type) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: <Widget>[
      Chip(label: Text(exerciseTypeLabel(type))),
      Chip(label: Text(exerciseStageLabel(type))),
      Chip(label: Text('Niveau ${recommendedLevelForType(type)}')),
    ],
  );
}
