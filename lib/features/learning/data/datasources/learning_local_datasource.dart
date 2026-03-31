import '../models/exercise_model.dart';
import '../models/example_sentence_model.dart';
import '../models/note_model.dart';
import '../models/word_model.dart';
import 'mock_exercises.dart';
import 'mock_notes.dart';
import 'mock_words.dart';

abstract class LearningLocalDatasource {
  Future<List<WordModel>> fetchWords();
  Future<WordModel?> fetchWordById(String id);
  Future<List<ExerciseModel>> fetchExercises();
  Future<List<ExampleSentenceModel>> fetchExamplesByWordId(String wordId);
  Future<List<NoteModel>> fetchNotes();
  Future<void> upsertNote(NoteModel note);
  Future<void> deleteNote(String id);
}

class LearningLocalDatasourceImpl implements LearningLocalDatasource {
  LearningLocalDatasourceImpl();

  final List<WordModel> _words = List<WordModel>.from(mockWords);
  final List<ExerciseModel> _exercises = List<ExerciseModel>.from(mockExercises);
  final Map<String, List<ExampleSentenceModel>> _examplesByWordId =
      <String, List<ExampleSentenceModel>>{...mockWordExamples};
  final List<NoteModel> _notes = List<NoteModel>.from(mockNotes);

  @override
  Future<List<WordModel>> fetchWords() async {
    return List<WordModel>.from(_words);
  }

  @override
  Future<WordModel?> fetchWordById(String id) async {
    for (final WordModel word in _words) {
      if (word.id == id) {
        return word;
      }
    }
    return null;
  }

  @override
  Future<List<ExerciseModel>> fetchExercises() async {
    return List<ExerciseModel>.from(_exercises);
  }

  @override
  Future<List<ExampleSentenceModel>> fetchExamplesByWordId(String wordId) async {
    return List<ExampleSentenceModel>.from(
      _examplesByWordId[wordId] ?? <ExampleSentenceModel>[],
    );
  }

  @override
  Future<List<NoteModel>> fetchNotes() async {
    return List<NoteModel>.from(_notes);
  }

  @override
  Future<void> upsertNote(NoteModel note) async {
    final int index = _notes.indexWhere((NoteModel item) => item.id == note.id);

    if (index == -1) {
      _notes.insert(0, note);
      return;
    }

    _notes[index] = note;
  }

  @override
  Future<void> deleteNote(String id) async {
    _notes.removeWhere((NoteModel note) => note.id == id);
  }
}
