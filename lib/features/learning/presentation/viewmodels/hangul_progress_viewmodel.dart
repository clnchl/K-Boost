import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_progress_viewmodel.dart';

const List<String> _hangulCourseExerciseIds = <String>['h1', 'h2', 'h3', 'h4'];

// État de la progression Hangul
class HangulProgressState {
  const HangulProgressState({
    required this.completedCategories,
    required this.categoryScores,
    required this.learnedLetters,
  });

  final Map<String, bool> completedCategories; // categoryId -> completed
  final Map<String, double> categoryScores; // categoryId -> score
  final Set<String> learnedLetters; // letterId -> apprise

  HangulProgressState copyWith({
    Map<String, bool>? completedCategories,
    Map<String, double>? categoryScores,
    Set<String>? learnedLetters,
  }) {
    return HangulProgressState(
      completedCategories: completedCategories ?? this.completedCategories,
      categoryScores: categoryScores ?? this.categoryScores,
      learnedLetters: learnedLetters ?? this.learnedLetters,
    );
  }

  // Obtenir le score global
  double getGlobalScore() {
    if (categoryScores.isEmpty) return 0;
    final double total = categoryScores.values.reduce(
      (double a, double b) => a + b,
    );
    return total / categoryScores.length;
  }
}

// ViewModel pour gérer la progression
class HangulProgressViewModel extends StateNotifier<HangulProgressState> {
  HangulProgressViewModel()
    : super(
        const HangulProgressState(
          completedCategories: <String, bool>{},
          categoryScores: <String, double>{},
          learnedLetters: <String>{},
        ),
      );

  // Marquer une catégorie comme complétée
  void markCategoryCompleted(String categoryId) {
    final Map<String, bool> updated = {
      ...state.completedCategories,
      categoryId: true,
    };
    state = state.copyWith(completedCategories: updated);
  }

  // Sauvegarder le score d'une catégorie
  void saveCategoryScore(String categoryId, double score) {
    final Map<String, double> updated = {
      ...state.categoryScores,
      categoryId: score,
    };
    state = state.copyWith(categoryScores: updated);
  }

  // Ajouter des lettres apprises
  void addLearnedLetters(Set<String> letterIds) {
    final Set<String> updated = {...state.learnedLetters, ...letterIds};
    state = state.copyWith(learnedLetters: updated);
  }

  // Réinitialiser la progression
  void resetProgress() {
    state = const HangulProgressState(
      completedCategories: <String, bool>{},
      categoryScores: <String, double>{},
      learnedLetters: <String>{},
    );
  }
}

// Provider pour la progression
final hangulProgressViewModelProvider =
    StateNotifierProvider<HangulProgressViewModel, HangulProgressState>(
      (Ref ref) => HangulProgressViewModel(),
    );

// Provider pour obtenir les catégories complétées
final completedHangulCategoriesProvider = Provider<List<String>>((Ref ref) {
  final state = ref.watch(hangulProgressViewModelProvider);
  return state.completedCategories.entries
      .where((MapEntry<String, bool> e) => e.value)
      .map((MapEntry<String, bool> e) => e.key)
      .toList();
});

// Provider pour obtenir le score global
final hangulGlobalScoreProvider = Provider<double>((Ref ref) {
  return ref.watch(hangulProgressViewModelProvider).getGlobalScore();
});

// Provider pour obtenir le nombre de lettres apprises
final hangulLearnedLettersCountProvider = Provider<int>((Ref ref) {
  final state = ref.watch(hangulProgressViewModelProvider);
  return state.learnedLetters.length;
});

final hangulCourseCompletedCountProvider = Provider<int>((Ref ref) {
  final Set<String> completedExerciseIds = ref.watch(
    themeProgressViewModelProvider,
  );
  return _hangulCourseExerciseIds.where(completedExerciseIds.contains).length;
});

final hangulCourseProgressProvider = Provider<double>((Ref ref) {
  final int completed = ref.watch(hangulCourseCompletedCountProvider);
  if (_hangulCourseExerciseIds.isEmpty) {
    return 0;
  }
  return completed / _hangulCourseExerciseIds.length;
});
