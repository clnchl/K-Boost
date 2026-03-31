import 'dart:convert';

import '../../domain/entities/word.dart';

class WordModel extends WordEntity {
  const WordModel({
    required super.id,
    required super.word,
    required super.translation,
    required super.romanization,
    required super.category,
    super.particle,
    required super.definition,
    required super.difficulty,
    super.audioUrl,
    required super.lessonId,
    super.politenessByTense,
  });

  factory WordModel.fromMap(Map<String, dynamic> map) {
    final Map<WordTense, Map<PolitenessLevel, String>> politenessByTense =
        _parsePolitenessByTense(map['politenessByTense']);

    return WordModel(
      id: map['id'] as String,
      word: map['word'] as String,
      translation: map['translation'] as String,
      romanization: map['romanization'] as String,
      category: map['category'] as String,
      particle: map['particle'] as String?,
      definition: map['definition'] as String,
      difficulty: map['difficulty'] as int,
      audioUrl: map['audioUrl'] as String?,
      lessonId: map['lessonId'] as String,
      politenessByTense: politenessByTense,
    );
  }

  factory WordModel.fromJson(String source) {
    return WordModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'word': word,
      'translation': translation,
      'romanization': romanization,
      'category': category,
      'particle': particle,
      'definition': definition,
      'difficulty': difficulty,
      'audioUrl': audioUrl,
      'lessonId': lessonId,
      'politenessByTense': _serializePolitenessByTense(politenessByTense),
    };
  }

  String toJson() => json.encode(toMap());

  static Map<WordTense, Map<PolitenessLevel, String>> _parsePolitenessByTense(
    dynamic source,
  ) {
    if (source is! Map<String, dynamic>) {
      return WordEntity.defaultPolitenessByTense;
    }

    final bool hasNestedValues = source.values.any(
      (dynamic value) => value is Map,
    );

    final Map<WordTense, Map<PolitenessLevel, String>> parsed = hasNestedValues
        ? _parseNestedPolitenessByTense(source)
        : _parseLegacyFlatPolitenessByTense(source);

    if (parsed.isEmpty) {
      return WordEntity.defaultPolitenessByTense;
    }

    return parsed;
  }

  static Map<WordTense, Map<PolitenessLevel, String>>
  _parseNestedPolitenessByTense(Map<String, dynamic> source) {
    final Map<WordTense, Map<PolitenessLevel, String>> result =
        <WordTense, Map<PolitenessLevel, String>>{};

    for (final WordTense tense in WordTense.values) {
      final dynamic byLevelRaw = source[tense.key];
      if (byLevelRaw is! Map) {
        continue;
      }

      final Map<dynamic, dynamic> dynamicMap = byLevelRaw;

      final Map<PolitenessLevel, String> byLevel = <PolitenessLevel, String>{};
      for (final PolitenessLevel level in PolitenessLevel.values) {
        final String? normalized = _normalizeText(dynamicMap[level.key]);
        if (normalized != null) {
          byLevel[level] = normalized;
        }
      }

      if (byLevel.isNotEmpty) {
        result[tense] = byLevel;
      }
    }

    return result;
  }

  static Map<WordTense, Map<PolitenessLevel, String>>
  _parseLegacyFlatPolitenessByTense(Map<String, dynamic> source) {
    final Map<WordTense, Map<PolitenessLevel, String>> result =
        <WordTense, Map<PolitenessLevel, String>>{};

    for (final WordTense tense in WordTense.values) {
      final Map<PolitenessLevel, String> byLevel = <PolitenessLevel, String>{};

      for (final PolitenessLevel level in PolitenessLevel.values) {
        final String compoundKey = '${tense.key}_${level.key}';
        final String? normalized = _normalizeText(source[compoundKey]);
        if (normalized != null) {
          byLevel[level] = normalized;
        }
      }

      // Legacy fallback where only tense keys existed and represented polite.
      if (!byLevel.containsKey(PolitenessLevel.polite)) {
        final String? legacyTenseValue = _normalizeText(source[tense.key]);
        if (legacyTenseValue != null) {
          byLevel[PolitenessLevel.polite] = legacyTenseValue;
        }
      }

      if (byLevel.isNotEmpty) {
        result[tense] = byLevel;
      }
    }

    return result;
  }

  static Map<String, Map<String, String>> _serializePolitenessByTense(
    Map<WordTense, Map<PolitenessLevel, String>> source,
  ) {
    final Map<String, Map<String, String>> serialized =
        <String, Map<String, String>>{};

    source.forEach((WordTense tense, Map<PolitenessLevel, String> byLevel) {
      final Map<String, String> serializedByLevel = <String, String>{};
      byLevel.forEach((PolitenessLevel level, String value) {
        serializedByLevel[level.key] = value;
      });

      if (serializedByLevel.isNotEmpty) {
        serialized[tense.key] = serializedByLevel;
      }
    });

    return serialized;
  }

  static String? _normalizeText(dynamic value) {
    final String text = value?.toString().trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    return text;
  }
}
