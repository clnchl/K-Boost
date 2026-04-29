import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:k_boost/features/theory/data/repositories/theory_repository_impl.dart';
import 'package:k_boost/features/theory/data/datasources/theory_remote_datasource.dart';
import 'package:k_boost/features/theory/data/models/category_model.dart';

class MockTheoryRemoteDataSource extends Mock
    implements TheoryRemoteDataSource {}

void main() {
  test('TheoryRepository.getCategories() retourne les catégories', () async {
    final mockDataSource = MockTheoryRemoteDataSource();
    final repository = TheoryRepositoryImpl(mockDataSource);

    final mockCategories = [
      const CategoryModel(id: '0', name: 'Tous les mots'),
      const CategoryModel(id: '1', name: 'Pronoms'),
    ];
    when(
      () => mockDataSource.getCategories(),
    ).thenAnswer((_) async => mockCategories);

    final result = await repository.getCategories();

    expect(result.length, equals(2));
    expect(result.first.name, equals('Tous les mots'));
    verify(() => mockDataSource.getCategories()).called(1);
  });
}
