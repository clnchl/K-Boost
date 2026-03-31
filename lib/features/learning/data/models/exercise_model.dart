import 'dart:convert';

import '../../domain/entities/exercise.dart';

class ExerciseModel extends ExerciseEntity {
  const ExerciseModel({
    required super.id,
    required super.type,
    required super.difficulty,
    required super.lessonId,
    required super.questionText,
    required super.options,
    required super.correctAnswer,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] as String,
      type: map['type'] as String,
      difficulty: map['difficulty'] as int,
      lessonId: map['lessonId'] as String,
      questionText: map['questionText'] as String,
      options: List<String>.from(map['options'] as List<dynamic>),
      correctAnswer: map['correctAnswer'] as String,
    );
  }

  factory ExerciseModel.fromJson(String source) {
    return ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'difficulty': difficulty,
      'lessonId': lessonId,
      'questionText': questionText,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }

  String toJson() => json.encode(toMap());
}
