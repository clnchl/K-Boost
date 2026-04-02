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
      case 'symbol':
        return 'Symbole';
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
      case 'symbol':
        return const Color(0xFF0F766E);
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

  static String themeLabel(String theme, {String allThemeKey = 'all'}) {
    if (theme == allThemeKey) {
      return 'Tous';
    }

    switch (theme) {
      case 'education':
        return 'Education';
      case 'restaurant':
        return 'Restaurant';
      case 'transport':
        return 'Transport';
      case 'social':
        return 'Social';
      case 'family':
        return 'Famille';
      case 'hangul':
        return 'Hangul';
      case 'culture':
        return 'Culture';
      case 'daily_life':
        return 'Quotidien';
      default:
        return theme;
    }
  }

  static Color themeFilterAccentColor(
    String theme, {
    String allThemeKey = 'all',
  }) {
    if (theme == allThemeKey) {
      return koreaBlue;
    }

    switch (theme) {
      case 'education':
        return const Color(0xFF1D4ED8);
      case 'restaurant':
        return koreaRed;
      case 'transport':
        return const Color(0xFF0F766E);
      case 'social':
        return const Color(0xFF7A4D94);
      case 'family':
        return const Color(0xFFBE185D);
      case 'hangul':
        return const Color(0xFF0F766E);
      case 'culture':
        return const Color(0xFF9A3412);
      case 'daily_life':
        return const Color(0xFF0F766E);
      default:
        return koreaBlue;
    }
  }

  static String subThemeLabel(
    String subTheme, {
    String allSubThemeKey = 'all',
  }) {
    if (subTheme == allSubThemeKey) {
      return 'Tous sous-themes';
    }

    switch (subTheme) {
      case 'family_core':
        return 'Noyau familial';
      case 'family_extended':
        return 'Famille elargie';
      case 'hangul_consonants':
        return 'Consonnes';
      case 'hangul_vowels':
        return 'Voyelles';
      default:
        return subTheme;
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
