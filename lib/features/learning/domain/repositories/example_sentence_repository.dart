import '../entities/example_sentence.dart';

abstract class ExampleSentenceRepository {
  Future<List<ExampleSentenceEntity>> getExamplesByWordId(String wordId);
}
