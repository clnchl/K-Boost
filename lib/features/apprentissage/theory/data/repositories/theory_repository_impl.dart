import '../../domain/entities/category.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_detail.dart';
import '../../domain/repositories/theory_repository.dart';
import '../datasources/theory_remote_datasource.dart';

class TheoryRepositoryImpl implements TheoryRepository {
  const TheoryRepositoryImpl(this._remote);

  final TheoryRemoteDataSource _remote;

  @override
  Future<List<Category>> getCategories() {
    return _remote.getCategories();
  }

  @override
  Future<List<Word>> getWordsByCategory(String categoryId) {
    return _remote.getWordsByCategory(categoryId);
  }

  @override
  Future<WordDetail> getWordDetail(String wordId) {
    return _remote.getWordDetail(wordId);
  }
}
