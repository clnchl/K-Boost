import 'package:flutter_test/flutter_test.dart';
import 'package:k_boost/features/theory/data/repositories/theory_repository_impl.dart';

void main() {
  group('TheoryRepositoryImpl', () {
    late TheoryRepositoryImpl repository;

    setUp(() {
      repository = TheoryRepositoryImpl();
    });

    // Vérifie qu'on récupère les catégories
    test('getCategories() retourne 7 catégories', () async {
      final categories = await repository.getCategories();

      expect(categories.length, equals(7));
      expect(categories.first.name, equals('Tous les mots'));
      expect(categories.last.name, equals('Famille'));
    });

    // Vérifie qu'on récupère les mots par catégorie
    test('getWordsByCategory() retourne 2 mots pour Pronoms', () async {
      final words = await repository.getWordsByCategory('1');

      expect(words.length, equals(2));
      expect(words.first.korean, equals('나'));
      expect(words.first.translation, equals('Je/Moi'));
    });

    // Vérifie les détails complets du mot
    test('getWordDetail() retourne les infos complètes', () async {
      final wordDetail = await repository.getWordDetail('1');

      expect(wordDetail.korean, equals('나'));
      expect(wordDetail.romanisation, equals('na'));
      expect(wordDetail.grammaticalType, equals('Pronom'));
    });
  });
}
