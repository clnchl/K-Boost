import 'package:flutter_test/flutter_test.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/usecases/delete_note_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_exercises_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_notes_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_word_by_id_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_word_examples_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_words_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/upsert_note_usecase.dart';

void main() {
  group('Learning usecases', () {
    test('GetWordsUseCase returns repository data', () async {
      final FakeWordRepository repository =
          FakeWordRepository(initialWords: [sampleWord()]);
      final GetWordsUseCase useCase = GetWordsUseCase(repository);

      final words = await useCase();

      expect(words, hasLength(1));
      expect(words.first.word, '사람');
    });

    test('GetExercisesUseCase returns repository data', () async {
      final FakeExerciseRepository repository =
          FakeExerciseRepository(initialExercises: [sampleExercise()]);
      final GetExercisesUseCase useCase = GetExercisesUseCase(repository);

      final exercises = await useCase();

      expect(exercises, hasLength(1));
      expect(exercises.first.correctAnswer, 'manger');
    });

    test('GetNotesUseCase returns repository data', () async {
      final FakeNoteRepository repository =
          FakeNoteRepository(initialNotes: [sampleNote()]);
      final GetNotesUseCase useCase = GetNotesUseCase(repository);

      final notes = await useCase();

      expect(notes, hasLength(1));
      expect(notes.first.title, 'Titre');
    });

    test('GetWordExamplesUseCase returns repository data', () async {
      final FakeExampleSentenceRepository repository =
          FakeExampleSentenceRepository(
        initialExamples: {
          'w1': [sampleExampleSentence()],
        },
      );
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(repository);

      final examples = await useCase('w1');

      expect(examples, hasLength(1));
      expect(examples.first.translation, 'Je mange du riz.');
    });

    test('GetWordByIdUseCase returns word when id exists', () async {
      final FakeWordRepository repository =
          FakeWordRepository(initialWords: [sampleWord(id: 'w1')]);
      final GetWordByIdUseCase useCase = GetWordByIdUseCase(repository);

      final word = await useCase('w1');

      expect(word, isNotNull);
      expect(word!.id, 'w1');
    });

    test('GetWordByIdUseCase returns null when id is missing', () async {
      final FakeWordRepository repository =
          FakeWordRepository(initialWords: [sampleWord(id: 'w1')]);
      final GetWordByIdUseCase useCase = GetWordByIdUseCase(repository);

      final word = await useCase('missing');

      expect(word, isNull);
    });

    test('UpsertNoteUseCase forwards note to repository', () async {
      final FakeNoteRepository repository = FakeNoteRepository();
      final UpsertNoteUseCase useCase = UpsertNoteUseCase(repository);
      final note = sampleNote(id: 'n42', title: 'Memo', content: 'abc');

      await useCase(note);

      expect(repository.upsertedNote, isNotNull);
      expect(repository.upsertedNote!.id, 'n42');
      expect(repository.notes, hasLength(1));
    });

    test('DeleteNoteUseCase forwards id to repository', () async {
      final FakeNoteRepository repository = FakeNoteRepository(
        initialNotes: [sampleNote(id: 'n1')],
      );
      final DeleteNoteUseCase useCase = DeleteNoteUseCase(repository);

      await useCase('n1');

      expect(repository.deletedId, 'n1');
      expect(repository.notes, isEmpty);
    });
  });
}
