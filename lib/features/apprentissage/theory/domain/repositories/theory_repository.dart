import '../entities/category.dart';
import '../entities/word.dart';
import '../entities/word_detail.dart';

abstract class TheoryRepository {
  /// Récupère liste de tt les catégories dispo.
  Future<List<Category>> getCategories();

  /// Récupère ts les mots d'une catégorie.
  Future<List<Word>> getWordsByCategory(String categoryId);

  /// Récupère détail complet d'un mot.
  Future<WordDetail> getWordDetail(String wordId);
}
