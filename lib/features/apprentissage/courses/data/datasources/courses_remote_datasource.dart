import '../models/hangul_exercise_model.dart';

abstract class CoursesRemoteDataSource {
  Future<List<HangulExerciseModel>> getHangulExercises();

  Future<List<HangulExerciseModel>> getHangulQuizSession({int count = 10});
}
