import '../entities/word.dart';
import '../repositories/word_repository.dart';

class GetWordsUseCase {
  const GetWordsUseCase(this._repository);

  final WordRepository _repository;

  Future<List<WordEntity>> call() {
    return _repository.getWords();
  }
}
