class ExerciseEntity {
  const ExerciseEntity({
    required this.id,
    required this.type,
    required this.difficulty,
    required this.lessonId,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });

  final String id;
  final String type;
  final int difficulty;
  final String lessonId;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
}
