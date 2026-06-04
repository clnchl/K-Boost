import '../entities/category.dart';
import '../repositories/theory_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final TheoryRepository _repository;

  Future<List<Category>> call() {
    return _repository.getCategories();
  }
}
