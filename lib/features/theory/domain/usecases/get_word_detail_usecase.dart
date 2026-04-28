import '../entities/word_detail.dart';
import '../repositories/theory_repository.dart';

class GetWordDetailUseCase {
  final TheoryRepository _repository;

  const GetWordDetailUseCase(this._repository);

  Future<WordDetail> call(String wordId) {
    return _repository.getWordDetail(wordId);
  }
}
