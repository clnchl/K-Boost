import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise.dart';
import '../../domain/usecases/get_exercises_usecase.dart';
import 'learning_providers.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, AsyncValue<List<ExerciseEntity>>>(
  (Ref ref) {
    final CourseViewModel viewModel =
        CourseViewModel(ref.watch(getExercisesUseCaseProvider));
    viewModel.loadExercises();
    return viewModel;
  },
);

class CourseViewModel
    extends StateNotifier<AsyncValue<List<ExerciseEntity>>> {
  CourseViewModel(this._getExercisesUseCase)
      : super(const AsyncValue<List<ExerciseEntity>>.loading());

  final GetExercisesUseCase _getExercisesUseCase;

  Future<void> loadExercises() async {
    state = const AsyncValue<List<ExerciseEntity>>.loading();

    try {
      final List<ExerciseEntity> exercises = await _getExercisesUseCase();
      state = AsyncValue<List<ExerciseEntity>>.data(exercises);
    } catch (error, stackTrace) {
      state = AsyncValue<List<ExerciseEntity>>.error(error, stackTrace);
    }
  }
}
