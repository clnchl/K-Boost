class HangulExercise {
  const HangulExercise({
    required this.id,
    required this.title,
    required this.modeDescription,
    required this.prompt,
    required this.correctChoice,
    required this.choices,
  });

  final String id;
  final String title;
  final String modeDescription;
  final String prompt;
  final String correctChoice;
  final List<String> choices;
}
