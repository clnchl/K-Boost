import 'package:flutter_test/flutter_test.dart';
import 'package:k_boost/features/apprentissage/theory/domain/entities/category.dart';
import 'package:k_boost/features/apprentissage/theory/domain/repositories/theory_repository.dart';
import 'package:k_boost/features/apprentissage/theory/domain/usecases/get_categories_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTheoryRepository extends Mock implements TheoryRepository {}

void main() {
  group('GetCategoriesUseCase', () {
    late MockTheoryRepository mockRepository;
    late GetCategoriesUseCase useCase;

    setUp(() {
      mockRepository = MockTheoryRepository();
      useCase = GetCategoriesUseCase(mockRepository);
    });

    test('retourne les catégories du repository', () async {
      final mockCategories = [
        const Category(id: '0', name: 'Tous les mots'),
        const Category(id: '1', name: 'Pronoms'),
      ];
      when(
        () => mockRepository.getCategories(),
      ).thenAnswer((_) async => mockCategories);

      final result = await useCase.call();

      expect(result.length, equals(2));
      expect(result.first.name, equals('Tous les mots'));
      verify(() => mockRepository.getCategories()).called(1);
    });
  });
}
