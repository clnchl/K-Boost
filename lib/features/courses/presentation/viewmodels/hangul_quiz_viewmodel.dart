// Providers Riverpod pour le module Cours (Hangul).
//
// Chaîne d'appel :
//   hangulQuizSessionProvider
//     → GetHangulQuizSessionUseCase
//     → CoursesRepository
//     → CoursesRemoteDataSource
//     → GET /courses/hangul/exercises/session?count=10
//
// Voir expliquation.md (partie 2) pour le détail architecture + BDD.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/courses_remote_datasource.dart';
import '../../data/datasources/courses_remote_datasource_impl.dart';
import '../../data/repositories/courses_repository_impl.dart';
import '../../domain/entities/hangul_exercise.dart';
import '../../domain/repositories/courses_repository.dart';
import '../../domain/usecases/get_hangul_exercises_usecase.dart';
import '../../domain/usecases/get_hangul_quiz_session_usecase.dart';

/// Source HTTP (URL via ApiConfig dans l'implémentation).
final coursesRemoteDataSourceProvider = Provider<CoursesRemoteDataSource>((ref) {
  return CoursesRemoteDataSourceImpl();
});

/// Repository : fait le pont entre domain et API.
final coursesRepositoryProvider = Provider<CoursesRepository>((ref) {
  final remote = ref.watch(coursesRemoteDataSourceProvider);
  return CoursesRepositoryImpl(remote);
});

/// Liste complète des exercices (utile pour debug / futurs écrans).
final getHangulExercisesUseCaseProvider = Provider<GetHangulExercisesUseCase>((ref) {
  final repository = ref.watch(coursesRepositoryProvider);
  return GetHangulExercisesUseCase(repository);
});

final hangulExercisesProvider = FutureProvider<List<HangulExercise>>((ref) async {
  final useCase = ref.watch(getHangulExercisesUseCaseProvider);
  return useCase.call();
});

final getHangulQuizSessionUseCaseProvider =
    Provider<GetHangulQuizSessionUseCase>((ref) {
  final repository = ref.watch(coursesRepositoryProvider);
  return GetHangulQuizSessionUseCase(repository);
});

/// Charge 10 questions pour UNE partie de quiz.
/// autoDispose : nouvel appel API à chaque ouverture de l'écran quiz.
final hangulQuizSessionProvider =
    FutureProvider.autoDispose<List<HangulExercise>>((ref) async {
  const questionCount = 10;
  final useCase = ref.watch(getHangulQuizSessionUseCaseProvider);
  return useCase.call(count: questionCount);
});
