import '../../domain/entities/example_sentence.dart';
import '../../domain/repositories/example_sentence_repository.dart';
import '../datasources/learning_local_datasource.dart';

class ExampleSentenceRepositoryImpl implements ExampleSentenceRepository {
  ExampleSentenceRepositoryImpl(this._datasource);

  final LearningLocalDatasource _datasource;

  @override
  Future<List<ExampleSentenceEntity>> getExamplesByWordId(String wordId) {
    return _datasource.fetchExamplesByWordId(wordId);
  }
}
