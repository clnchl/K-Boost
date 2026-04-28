class WordDetail {
  final String id;
  final String korean;
  final String translation;
  final String definition;
  final String? example;

  const WordDetail({
    required this.id,
    required this.korean,
    required this.translation,
    required this.definition,
    this.example,
  });
}