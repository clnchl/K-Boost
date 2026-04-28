import 'theory_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/word_detail_model.dart';
import '../models/word_model.dart';

class TheoryRemoteDataSourceImpl implements TheoryRemoteDataSource {
  const TheoryRemoteDataSourceImpl();

  @override
  Future<List<CategoryModel>> getCategories() {
    throw UnimplementedError();
  }

  @override
  Future<List<WordModel>> getWordsByCategory(String categoryId) {
    throw UnimplementedError();
  }

  @override
  Future<WordDetailModel> getWordDetail(String wordId) {
    throw UnimplementedError();
  }
}
