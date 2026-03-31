import '../entities/word.dart';

abstract class WordRepository {
  Future<List<WordEntity>> getWords();
  Future<WordEntity?> getWordById(String id);
}
