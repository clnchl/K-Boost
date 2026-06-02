import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api_config.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_detail.dart';
import '../../domain/repositories/theory_repository.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_words_by_category_usecase.dart';
import '../../domain/usecases/get_word_detail_usecase.dart';
import '../../data/datasources/theory_remote_datasource.dart';
import '../../data/datasources/theory_remote_datasource_impl.dart';
import '../../data/repositories/theory_repository_impl.dart';

final theoryRemoteDataSourceProvider = Provider<TheoryRemoteDataSource>((ref) {
  return TheoryRemoteDataSourceImpl(baseUrl: ApiConfig.baseUrl);
});

// Repository - créé une seule fois
final theoryRepositoryProvider = Provider<TheoryRepository>((ref) {
  final remote = ref.watch(theoryRemoteDataSourceProvider);
  return TheoryRepositoryImpl(remote);
});

// Provider du UseCase
final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  final repository = ref.watch(theoryRepositoryProvider);
  return GetCategoriesUseCase(repository);
});

// Charge toutes les catégories au démarrage
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return useCase.call();
});

// Catégorie actuellement sélectionnée (par défaut: "Tous les mots")
final selectedCategoryProvider = StateProvider<String?>((ref) {
  return '0';
});

// Charge les mots de la catégorie actuellement sélectionnée
final selectedWordsProvider = FutureProvider<List<Word>>((ref) async {
  final selectedCategoryId = ref.watch(selectedCategoryProvider);

  // Si aucune catégorie sélectionnée, retourne liste vide
  if (selectedCategoryId == null) {
    return [];
  }

  final useCase = ref.watch(getWordsByCategoryUseCaseProvider);
  return useCase.call(selectedCategoryId);
});

// Provider du UseCase pour récupérer les mots
final getWordsByCategoryUseCaseProvider = Provider<GetWordsByCategoryUseCase>((
  ref,
) {
  final repository = ref.watch(theoryRepositoryProvider);
  return GetWordsByCategoryUseCase(repository);
});

// Provider du UseCase pour récupérer détail
final getWordDetailUseCaseProvider = Provider<GetWordDetailUseCase>((ref) {
  final repository = ref.watch(theoryRepositoryProvider);
  return GetWordDetailUseCase(repository);
});

// Charge le détail d'un mot par son ID (prend un paramètre avec .family)
final wordDetailProvider = FutureProvider.family<WordDetail, String>((
  ref,
  wordId,
) async {
  final useCase = ref.watch(getWordDetailUseCaseProvider);
  return useCase.call(wordId);
});

class CategoriesViewModel {
  // Pour l'instant, on la laisse vide
  // Les providers font le job!
}