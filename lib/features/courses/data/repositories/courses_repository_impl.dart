import '../../domain/entities/hangul_exercise.dart';
import '../../domain/repositories/courses_repository.dart';
import '../datasources/courses_remote_datasource.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  const CoursesRepositoryImpl(this._remote);

  final CoursesRemoteDataSource _remote;

  @override
  Future<List<HangulExercise>> getHangulExercises() {
    return _remote.getHangulExercises();
  }

  @override
  Future<List<HangulExercise>> getHangulQuizSession({int count = 10}) {
    return _remote.getHangulQuizSession(count: count);
  }
}
