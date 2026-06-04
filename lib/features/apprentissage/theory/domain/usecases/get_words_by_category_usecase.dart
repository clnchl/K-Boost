import '../entities/word.dart';
import '../repositories/theory_repository.dart';

class GetWordsByCategoryUseCase {
  const GetWordsByCategoryUseCase(this._repository);

  final TheoryRepository _repository;

  Future<List<Word>> call(String categoryId) {
    return _repository.getWordsByCategory(categoryId);
  }
}
