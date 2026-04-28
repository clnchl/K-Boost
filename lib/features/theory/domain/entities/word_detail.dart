// Entité: détails complets d'un mot
class WordDetail {
  final String id;
  final String korean;
  final String romanisation;
  final String translation;
  final String grammaticalType; 
  final String exampleSentence;

  const WordDetail({
    required this.id,
    required this.korean,
    required this.romanisation,
    required this.translation,
    required this.grammaticalType,
    required this.exampleSentence,
  });
}
