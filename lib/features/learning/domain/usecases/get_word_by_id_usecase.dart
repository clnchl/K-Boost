import '../entities/word.dart';
import '../repositories/word_repository.dart';

class GetWordByIdUseCase {
  const GetWordByIdUseCase(this._repository);

  final WordRepository _repository;

  Future<WordEntity?> call(String id) {
    return _repository.getWordById(id);
  }
}
