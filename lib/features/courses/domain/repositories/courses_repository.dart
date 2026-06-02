import '../entities/hangul_exercise.dart';

abstract class CoursesRepository {
  Future<List<HangulExercise>> getHangulExercises();

  Future<List<HangulExercise>> getHangulQuizSession({int count = 10});
}
