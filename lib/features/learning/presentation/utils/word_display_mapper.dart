import 'package:flutter/material.dart';

import '../../domain/entities/word.dart';

class WordDisplayMapper {
  static const Color koreaBlue = Color(0xFF0C4A8A);
  static const Color koreaRed = Color(0xFFC51F3A);

  static String categoryLabel(
    String category, {
    String allCategoryKey = 'all',
  }) {
    if (category == allCategoryKey) {
      return 'Tous';
    }

    switch (category) {
      case 'subject':
        return 'Sujet';
      case 'object':
        return 'Objet';
      case 'action':
        return 'Action';
      case 'place':
        return 'Lieu';
      case 'time':
        return 'Temps';
      default:
        return category;
    }
  }

  static Color categoryAccentColor(String category) {
    switch (category) {
      case 'subject':
        return koreaBlue;
      case 'action':
        return koreaRed;
      case 'object':
        return const Color(0xFF3B82F6);
      case 'place':
        return const Color(0xFF2563EB);
      case 'time':
        return const Color(0xFF1D4ED8);
      default:
        return const Color(0xFF334155);
    }
  }

  static Color categoryFilterAccentColor(
    String category, {
    String allCategoryKey = 'all',
  }) {
    if (category == allCategoryKey) {
      return koreaBlue;
    }

    switch (category) {
      case 'subject':
      case 'object':
        return koreaBlue;
      case 'place':
        return const Color(0xFF0F766E);
      case 'action':
      case 'time':
        return const Color(0xFF6D28D9);
      default:
        return koreaBlue;
    }
  }

  static String tenseLabel(WordTense tense) {
    switch (tense) {
      case WordTense.past:
        return 'Passe';
      case WordTense.present:
        return 'Present';
      case WordTense.future:
        return 'Futur';
    }
  }

  static Color tenseAccentColor(WordTense tense) {
    switch (tense) {
      case WordTense.past:
        return const Color(0xFF7A4D94);
      case WordTense.present:
        return koreaBlue;
      case WordTense.future:
        return koreaRed;
    }
  }

  static String politenessLabel(PolitenessLevel politenessLevel) {
    switch (politenessLevel) {
      case PolitenessLevel.informal:
        return 'Informelle';
      case PolitenessLevel.polite:
        return 'Poli';
      case PolitenessLevel.formal:
        return 'Formelle';
    }
  }

  static Color politenessAccentColor(PolitenessLevel politenessLevel) {
    switch (politenessLevel) {
      case PolitenessLevel.informal:
        return const Color(0xFF0F766E);
      case PolitenessLevel.polite:
        return koreaBlue;
      case PolitenessLevel.formal:
        return const Color(0xFF6D28D9);
    }
  }

  static String missingPolitenessMessage({
    required WordTense tense,
    required PolitenessLevel level,
  }) {
    final String tenseText = tenseLabel(tense).toLowerCase();
    final String levelText = politenessLabel(level).toLowerCase();
    return 'Information indisponible pour $tenseText ($levelText).';
  }

  static String presentPolitenessPreview(WordEntity word) {
    final Map<PolitenessLevel, String>? presentPoliteness =
        word.politenessByTense[WordTense.present];

    return presentPoliteness?[PolitenessLevel.polite] ??
        presentPoliteness?[PolitenessLevel.informal] ??
        WordEntity.defaultPolitenessByTense[WordTense.present]![PolitenessLevel
            .polite]!;
  }
}
