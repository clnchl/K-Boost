import '../entities/exercise.dart';
import '../repositories/exercise_repository.dart';

class GetExercisesUseCase {
  const GetExercisesUseCase(this._repository);

  final ExerciseRepository _repository;

  Future<List<ExerciseEntity>> call() {
    return _repository.getExercises();
  }
}
