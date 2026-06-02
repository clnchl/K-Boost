import '../entities/hangul_exercise.dart';
import '../repositories/courses_repository.dart';

class GetHangulQuizSessionUseCase {
  const GetHangulQuizSessionUseCase(this._repository);

  final CoursesRepository _repository;

  Future<List<HangulExercise>> call({int count = 10}) {
    return _repository.getHangulQuizSession(count: count);
  }
}
