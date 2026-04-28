import 'package:flutter_test/flutter_test.dart';
import 'package:k_boost/features/theory/domain/entities/category.dart';
import 'package:k_boost/features/theory/domain/repositories/theory_repository.dart';
import 'package:k_boost/features/theory/domain/usecases/get_categories_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock du repository
class MockTheoryRepository extends Mock implements TheoryRepository {}

void main() {
  group('GetCategoriesUseCase', () {
    late MockTheoryRepository mockRepository;
    late GetCategoriesUseCase useCase;

    setUp(() {
      mockRepository = MockTheoryRepository();
      useCase = GetCategoriesUseCase(mockRepository);
    });

    test('call() retourne les catégories du repository', () async {
      // Arrange: Préparer les données mock
      final mockCategories = [
        const Category(id: '0', name: 'Tous les mots'),
        const Category(id: '1', name: 'Pronoms'),
      ];
      when(
        () => mockRepository.getCategories(),
      ).thenAnswer((_) async => mockCategories);

      // Act: Exécuter le UseCase
      final result = await useCase.call();

      // Assert: Vérifier le résultat
      expect(result, equals(mockCategories));
      expect(result.length, equals(2));
      verify(() => mockRepository.getCategories()).called(1);
    });
  });
}
