import 'dart:convert';

import '../../domain/entities/example_sentence.dart';

class ExampleSentenceModel extends ExampleSentenceEntity {
  const ExampleSentenceModel({
    required super.sentence,
    required super.romanization,
    required super.translation,
  });

  factory ExampleSentenceModel.fromMap(Map<String, dynamic> map) {
    return ExampleSentenceModel(
      sentence: map['sentence'] as String,
      romanization: map['romanization'] as String,
      translation: map['translation'] as String,
    );
  }

  factory ExampleSentenceModel.fromJson(String source) {
    return ExampleSentenceModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentence': sentence,
      'romanization': romanization,
      'translation': translation,
    };
  }

  String toJson() => json.encode(toMap());
}
