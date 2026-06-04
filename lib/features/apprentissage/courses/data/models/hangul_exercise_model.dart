import '../../domain/entities/hangul_exercise.dart';

class HangulExerciseModel extends HangulExercise {
  const HangulExerciseModel({
    required super.id,
    required super.title,
    required super.modeDescription,
    required super.prompt,
    required super.correctChoice,
    required super.choices,
  });

  factory HangulExerciseModel.fromJson(Map<String, dynamic> json) {
    return HangulExerciseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      modeDescription: json['modeDescription'] as String,
      prompt: json['prompt'] as String,
      correctChoice: json['correctChoice'] as String,
      choices: (json['choices'] as List<dynamic>).map((c) => c as String).toList(),
    );
  }
}
