class WordEntity {
  const WordEntity({
    required this.id,
    required this.word,
    required this.translation,
    required this.romanization,
    required this.category,
    this.particle,
    required this.definition,
    required this.difficulty,
    this.audioUrl,
    required this.lessonId,
  });

  final String id;
  final String word;
  final String translation;
  final String romanization;
  final String category;
  final String? particle;
  final String definition;
  final int difficulty;
  final String? audioUrl;
  final String lessonId;
}
