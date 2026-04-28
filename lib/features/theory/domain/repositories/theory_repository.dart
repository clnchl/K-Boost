import '../entities/category.dart';
import '../entities/word.dart';
import '../entities/word_detail.dart';

abstract class TheoryRepository {
  /// Récupère la liste de toutes les catégories disponibles.
  Future<List<Category>> getCategories();

  /// Récupère tous les mots d'une catégorie spécifique.
  Future<List<Word>> getWordsByCategory(String categoryId);

  /// Récupère le détail complet d'un mot.
  Future<WordDetail> getWordDetail(String wordId);
}
