import '../models/category_model.dart';
import '../models/word_detail_model.dart';
import '../models/word_model.dart';

abstract class TheoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<WordModel>> getWordsByCategory(String categoryId);
  Future<WordDetailModel> getWordDetail(String wordId);
}
