import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../datasources/learning_local_datasource.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRepositoryImpl(this._datasource);

  final LearningLocalDatasource _datasource;

  @override
  Future<List<ExerciseEntity>> getExercises() {
    return _datasource.fetchExercises();
  }
}
