import 'package:flutter/material.dart';

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
  'multiple_choice' => 'QCM',
  'translation' => 'Traduction',
  'sentence_order' => 'Ordre des phrases',
  _ => 'Exercice',
};
