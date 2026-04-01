import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';

// État de la session d'apprentissage Hangul
class HangulSessionState {
  const HangulSessionState({
    required this.selectedCategory,
    required this.selectedLetters,
    required this.currentIndex,
    required this.completedLetters,
    required this.isTestMode,
    required this.testResults,
    required this.allLearned,
  });

  final HangulCategory? selectedCategory;
  final List<HangulLetter> selectedLetters;
  final int currentIndex;
  final Set<String> completedLetters;
  final bool isTestMode;
  final Map<String, bool> testResults;
  final Set<String> allLearned;

  HangulSessionState copyWith({
    HangulCategory? selectedCategory,
    List<HangulLetter>? selectedLetters,
    int? currentIndex,
    Set<String>? completedLetters,
    bool? isTestMode,
    Map<String, bool>? testResults,
    Set<String>? allLearned,
  }) {
    return HangulSessionState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedLetters: selectedLetters ?? this.selectedLetters,
      currentIndex: currentIndex ?? this.currentIndex,
      completedLetters: completedLetters ?? this.completedLetters,
      isTestMode: isTestMode ?? this.isTestMode,
      testResults: testResults ?? this.testResults,
      allLearned: allLearned ?? this.allLearned,
    );
  }

  // Obtenir le score du test
  double getTestScore() {
    if (testResults.isEmpty) return 0;
    final int correct = testResults.values.where((bool v) => v).length;
    return correct / testResults.length;
  }
}

// ViewModel pour gérer Hangul
class HangulViewModel extends StateNotifier<HangulSessionState> {
  HangulViewModel()
    : super(
        const HangulSessionState(
          selectedCategory: null,
          selectedLetters: <HangulLetter>[],
          currentIndex: 0,
          completedLetters: <String>{},
          isTestMode: false,
          testResults: <String, bool>{},
          allLearned: <String>{},
        ),
      );

  // Sélectionner une catégorie et un nombre d'éléments
  void selectCategoryWithCount(HangulCategory category, int count) {
    final int actualCount = count > category.letters.length
        ? category.letters.length
        : count;

    final List<HangulLetter> selected = category.letters
        .take(actualCount)
        .toList();

    state = state.copyWith(
      selectedCategory: category,
      selectedLetters: selected,
      currentIndex: 0,
      completedLetters: <String>{},
      isTestMode: false,
      testResults: <String, bool>{},
    );
  }

  // Avancer à la prochaine lettre
  void nextLetter() {
    if (state.currentIndex < state.selectedLetters.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  // Revenir à la lettre précédente
  void previousLetter() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  // Marquer une lettre comme complétée
  void markLetterCompleted(String letterId) {
    final Set<String> updated = {...state.completedLetters, letterId};
    state = state.copyWith(completedLetters: updated);
  }

  // Démarrer le mode test
  void startTest() {
    state = state.copyWith(
      isTestMode: true,
      testResults: <String, bool>{},
      currentIndex: 0,
    );
  }

  // Terminer le mode test
  void endTest() {
    // Ajouter les lettres apprises aux allLearned
    final Set<String> newLearned = {
      ...state.allLearned,
      ...state.selectedLetters.map((HangulLetter l) => l.id),
    };

    state = state.copyWith(isTestMode: false, allLearned: newLearned);
  }

  // Enregistrer le résultat d'une question de test
  void recordTestAnswer(String letterId, bool isCorrect) {
    final Map<String, bool> updated = {
      ...state.testResults,
      letterId: isCorrect,
    };

    state = state.copyWith(testResults: updated);
  }

  // Réinitialiser la session
  void resetSession() {
    state = const HangulSessionState(
      selectedCategory: null,
      selectedLetters: <HangulLetter>[],
      currentIndex: 0,
      completedLetters: <String>{},
      isTestMode: false,
      testResults: <String, bool>{},
      allLearned: <String>{},
    );
  }
}

// Provider pour le ViewModel
final hangulViewModelProvider =
    StateNotifierProvider<HangulViewModel, HangulSessionState>(
      (Ref ref) => HangulViewModel(),
    );

// Provider pour les catégories
final hangulCategoriesProvider = Provider<List<HangulCategory>>(
  (Ref ref) => hangulCategoriesData,
);
