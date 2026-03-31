import '../../domain/entities/word.dart';
import '../../domain/repositories/word_repository.dart';
import '../datasources/learning_local_datasource.dart';

class WordRepositoryImpl implements WordRepository {
  WordRepositoryImpl(this._datasource);

  final LearningLocalDatasource _datasource;

  @override
  Future<List<WordEntity>> getWords() {
    return _datasource.fetchWords();
  }

  @override
  Future<WordEntity?> getWordById(String id) {
    return _datasource.fetchWordById(id);
  }
}
