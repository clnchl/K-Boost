// Entité: mot avec infos basiques
class Word {
  final String id;
  final String korean;
  final String romanisation;
  final String translation;
  final String categoryId;

  const Word({
    required this.id,
    required this.korean,
    required this.romanisation,
    required this.translation,
    required this.categoryId,
  });
}
