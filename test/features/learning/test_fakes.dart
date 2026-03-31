import '../../../lib/features/learning/domain/entities/exercise.dart';
import '../../../lib/features/learning/domain/entities/example_sentence.dart';
import '../../../lib/features/learning/domain/entities/note.dart';
import '../../../lib/features/learning/domain/entities/word.dart';
import '../../../lib/features/learning/domain/repositories/exercise_repository.dart';
import '../../../lib/features/learning/domain/repositories/example_sentence_repository.dart';
import '../../../lib/features/learning/domain/repositories/note_repository.dart';
import '../../../lib/features/learning/domain/repositories/word_repository.dart';

WordEntity sampleWord({
  String id = 'w1',
  String word = '사람',
  String translation = 'personne',
}) {
  return WordEntity(
    id: id,
    word: word,
    translation: translation,
    romanization: 'saram',
    category: 'subject',
    particle: '은/는',
    definition: 'Un etre humain.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l1',
  );
}

ExerciseEntity sampleExercise({String id = 'e1'}) {
  return ExerciseEntity(
    id: id,
    type: 'multiple_choice',
    difficulty: 1,
    lessonId: 'l1',
    questionText: 'Que signifie 먹다 ?',
    options: <String>['manger', 'boire'],
    correctAnswer: 'manger',
  );
}

ExampleSentenceEntity sampleExampleSentence({
  String sentence = '나는 밥을 먹어요.',
  String romanization = 'naneun babeul meogeoyo.',
  String translation = 'Je mange du riz.',
}) {
  return ExampleSentenceEntity(
    sentence: sentence,
    romanization: romanization,
    translation: translation,
  );
}

NoteEntity sampleNote({
  String id = 'n1',
  String title = 'Titre',
  String content = 'Contenu',
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final DateTime now = DateTime(2026, 3, 31, 10, 0);

  return NoteEntity(
    id: id,
    userId: 'u1',
    title: title,
    content: content,
    createdAt: createdAt ?? now,
    updatedAt: updatedAt ?? now,
  );
}

class FakeWordRepository implements WordRepository {
  FakeWordRepository({
    List<WordEntity>? initialWords,
    this.error,
  }) : words = initialWords ?? <WordEntity>[];

  final List<WordEntity> words;
  Object? error;

  @override
  Future<List<WordEntity>> getWords() async {
    if (error != null) {
      throw error!;
    }

    return List<WordEntity>.from(words);
  }

  @override
  Future<WordEntity?> getWordById(String id) async {
    for (final WordEntity word in words) {
      if (word.id == id) {
        return word;
      }
    }

    return null;
  }
}

class FakeExerciseRepository implements ExerciseRepository {
  FakeExerciseRepository({
    List<ExerciseEntity>? initialExercises,
    this.error,
  }) : exercises = initialExercises ?? <ExerciseEntity>[];

  final List<ExerciseEntity> exercises;
  Object? error;

  @override
  Future<List<ExerciseEntity>> getExercises() async {
    if (error != null) {
      throw error!;
    }

    return List<ExerciseEntity>.from(exercises);
  }
}

class FakeNoteRepository implements NoteRepository {
  FakeNoteRepository({
    List<NoteEntity>? initialNotes,
    this.getNotesError,
  }) : notes = initialNotes ?? <NoteEntity>[];

  final List<NoteEntity> notes;
  Object? getNotesError;

  NoteEntity? upsertedNote;
  String? deletedId;

  @override
  Future<List<NoteEntity>> getNotes() async {
    if (getNotesError != null) {
      throw getNotesError!;
    }

    return List<NoteEntity>.from(notes);
  }

  @override
  Future<void> upsertNote(NoteEntity note) async {
    upsertedNote = note;

    final int index = notes.indexWhere((NoteEntity item) => item.id == note.id);
    if (index == -1) {
      notes.insert(0, note);
      return;
    }

    notes[index] = note;
  }

  @override
  Future<void> deleteNote(String id) async {
    deletedId = id;
    notes.removeWhere((NoteEntity note) => note.id == id);
  }
}

class FakeExampleSentenceRepository implements ExampleSentenceRepository {
  FakeExampleSentenceRepository({
    Map<String, List<ExampleSentenceEntity>>? initialExamples,
    this.error,
  }) : examplesByWordId =
            initialExamples ?? <String, List<ExampleSentenceEntity>>{};

  final Map<String, List<ExampleSentenceEntity>> examplesByWordId;
  Object? error;

  @override
  Future<List<ExampleSentenceEntity>> getExamplesByWordId(String wordId) async {
    if (error != null) {
      throw error!;
    }

    return List<ExampleSentenceEntity>.from(
      examplesByWordId[wordId] ?? <ExampleSentenceEntity>[],
    );
  }
}
