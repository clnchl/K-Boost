import '../entities/example_sentence.dart';
import '../repositories/example_sentence_repository.dart';

class GetWordExamplesUseCase {
  const GetWordExamplesUseCase(this._repository);

  final ExampleSentenceRepository _repository;

  Future<List<ExampleSentenceEntity>> call(String wordId) {
    return _repository.getExamplesByWordId(wordId);
  }
}
