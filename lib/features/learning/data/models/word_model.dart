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
  });

  factory WordModel.fromMap(Map<String, dynamic> map) {
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
    };
  }

  String toJson() => json.encode(toMap());
}
