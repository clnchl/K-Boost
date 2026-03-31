import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/exercise.dart';
import '../../../../../lib/features/learning/domain/entities/word.dart';
import '../../../../../lib/features/learning/domain/usecases/get_exercises_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_words_usecase.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/course_viewmodel.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/theory_viewmodel.dart';

void main() {
  group('TheoryViewModel', () {
    test('loadWords exposes AsyncData when successful', () async {
      final FakeWordRepository repository =
          FakeWordRepository(initialWords: [sampleWord()]);
      final TheoryViewModel viewModel =
          TheoryViewModel(GetWordsUseCase(repository));

      await viewModel.loadWords();

        expect(viewModel.state, isA<AsyncData<List<WordEntity>>>());
        final AsyncData<List<WordEntity>> state =
          viewModel.state as AsyncData<List<WordEntity>>;
        expect(state.value, hasLength(1));
    });

    test('loadWords exposes AsyncError when repository fails', () async {
      final FakeWordRepository repository =
          FakeWordRepository(error: Exception('load words failed'));
      final TheoryViewModel viewModel =
          TheoryViewModel(GetWordsUseCase(repository));

      await viewModel.loadWords();

        expect(viewModel.state, isA<AsyncError<List<WordEntity>>>());
    });
  });

  group('CourseViewModel', () {
    test('loadExercises exposes AsyncData when successful', () async {
      final FakeExerciseRepository repository =
          FakeExerciseRepository(initialExercises: [sampleExercise()]);
      final CourseViewModel viewModel =
          CourseViewModel(GetExercisesUseCase(repository));

      await viewModel.loadExercises();

        expect(viewModel.state, isA<AsyncData<List<ExerciseEntity>>>());
        final AsyncData<List<ExerciseEntity>> state =
          viewModel.state as AsyncData<List<ExerciseEntity>>;
        expect(state.value, hasLength(1));
    });

    test('loadExercises exposes AsyncError when repository fails', () async {
      final FakeExerciseRepository repository =
          FakeExerciseRepository(error: Exception('load exercises failed'));
      final CourseViewModel viewModel =
          CourseViewModel(GetExercisesUseCase(repository));

      await viewModel.loadExercises();

      expect(viewModel.state, isA<AsyncError<List<ExerciseEntity>>>());
    });
  });
}
