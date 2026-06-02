import '../entities/hangul_exercise.dart';
import '../repositories/courses_repository.dart';

class GetHangulExercisesUseCase {
  const GetHangulExercisesUseCase(this._repository);

  final CoursesRepository _repository;

  Future<List<HangulExercise>> call() {
    return _repository.getHangulExercises();
  }
}
