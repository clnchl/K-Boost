import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';

enum HangulCourseFocus {
  structure,
  vowels,
  consonants,
  vowelsAdvanced,
  consonantsAdvanced,
  mixed,
}

// État de la session d'apprentissage Hangul
class HangulSessionState {
  const HangulSessionState({
    required this.courseFocus,
    required this.selectedConsonants,
    required this.selectedVowels,
    required this.generatedSyllables,
    required this.currentIndex,
    required this.isTestMode,
    required this.trainingMode,
    required this.trainingQuestionCount,
    required this.selectedExerciseTypes,
    required this.testResults,
    required this.allLearned,
  });

  final HangulCourseFocus courseFocus;
  final List<HangulLetter> selectedConsonants;
  final List<HangulLetter> selectedVowels;
  final List<HangulSyllable> generatedSyllables;
  final int currentIndex;
  final bool isTestMode;
  final bool trainingMode;
  final int trainingQuestionCount;
  final List<HangulExerciseType> selectedExerciseTypes;
  final Map<String, bool> testResults;
  final Set<String> allLearned;

  List<HangulLetter> get selectedLetters => <HangulLetter>[
    ...selectedConsonants,
    ...selectedVowels,
  ];

  int get targetLessonExercises => trainingMode ? trainingQuestionCount : 5;

  HangulSessionState copyWith({
    HangulCourseFocus? courseFocus,
    List<HangulLetter>? selectedConsonants,
    List<HangulLetter>? selectedVowels,
    List<HangulSyllable>? generatedSyllables,
    int? currentIndex,
    bool? isTestMode,
    bool? trainingMode,
    int? trainingQuestionCount,
    List<HangulExerciseType>? selectedExerciseTypes,
    Map<String, bool>? testResults,
    Set<String>? allLearned,
  }) {
    return HangulSessionState(
      courseFocus: courseFocus ?? this.courseFocus,
      selectedConsonants: selectedConsonants ?? this.selectedConsonants,
      selectedVowels: selectedVowels ?? this.selectedVowels,
      generatedSyllables: generatedSyllables ?? this.generatedSyllables,
      currentIndex: currentIndex ?? this.currentIndex,
      isTestMode: isTestMode ?? this.isTestMode,
      trainingMode: trainingMode ?? this.trainingMode,
      trainingQuestionCount:
          trainingQuestionCount ?? this.trainingQuestionCount,
      selectedExerciseTypes:
          selectedExerciseTypes ?? this.selectedExerciseTypes,
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
          courseFocus: HangulCourseFocus.structure,
          selectedConsonants: <HangulLetter>[],
          selectedVowels: <HangulLetter>[],
          generatedSyllables: <HangulSyllable>[],
          currentIndex: 0,
          isTestMode: false,
          trainingMode: false,
          trainingQuestionCount: 50,
          selectedExerciseTypes: HangulExerciseType.values,
          testResults: <String, bool>{},
          allLearned: <String>{},
        ),
      );

  List<HangulLetter> _allConsonants() => hangulCategoriesData
      .expand((HangulCategory category) => category.letters)
      .where((HangulLetter letter) => letter.category.startsWith('consonant'))
      .toList(growable: false);

  List<HangulLetter> _allVowels() => hangulCategoriesData
      .expand((HangulCategory category) => category.letters)
      .where((HangulLetter letter) => letter.category.startsWith('vowel'))
      .toList(growable: false);

  List<HangulSyllable> _buildSyllables(
    List<HangulLetter> consonants,
    List<HangulLetter> vowels,
  ) {
    final List<HangulSyllable> generated = <HangulSyllable>[];
    for (final HangulLetter consonant in consonants) {
      for (final HangulLetter vowel in vowels) {
        generated.add(
          HangulSyllable(
            consonant: consonant,
            vowel: vowel,
            character: composeHangulSyllable(
              consonant.character,
              vowel.character,
            ),
            romanization:
                _normalizeRomanization(consonant.romanization) +
                vowel.romanization,
          ),
        );
      }
    }
    return generated;
  }

  String _normalizeRomanization(String value) {
    if (!value.contains('/')) {
      return value;
    }
    return value.split('/').first;
  }

  void configureSession({
    required int letterCount,
    required bool trainingMode,
    required List<HangulExerciseType> selectedExerciseTypes,
    required HangulCourseFocus courseFocus,
  }) {
    final List<HangulLetter> allConsonants = _allConsonants();
    final List<HangulLetter> allVowels = _allVowels();
    final int totalAlphabetCount = allConsonants.length + allVowels.length;
    final HangulLetter silentConsonant = allConsonants.firstWhere(
      (HangulLetter letter) => letter.character == 'ㅇ',
      orElse: () => allConsonants.first,
    );
    final HangulLetter baseVowel = allVowels.first;

    late final List<HangulLetter> selectedConsonants;
    late final List<HangulLetter> selectedVowels;

    switch (courseFocus) {
      case HangulCourseFocus.vowels:
        selectedConsonants = <HangulLetter>[silentConsonant];
        selectedVowels = letterCount >= allVowels.length
            ? allVowels
            : allVowels.take(max(letterCount, 4)).toList(growable: false);
        break;
      case HangulCourseFocus.vowelsAdvanced:
        final List<HangulLetter> advancedVowels = allVowels
            .where((HangulLetter letter) => letter.category == 'vowel_advanced')
            .toList(growable: false);
        selectedConsonants = <HangulLetter>[silentConsonant];
        selectedVowels = letterCount >= advancedVowels.length
            ? advancedVowels
            : advancedVowels.take(max(letterCount, 4)).toList(growable: false);
        break;
      case HangulCourseFocus.consonants:
        selectedConsonants = letterCount >= allConsonants.length
            ? allConsonants
            : allConsonants.take(max(letterCount, 4)).toList(growable: false);
        selectedVowels = <HangulLetter>[baseVowel];
        break;
      case HangulCourseFocus.consonantsAdvanced:
        final List<HangulLetter> advancedConsonants = allConsonants
            .where(
              (HangulLetter letter) => letter.category == 'consonant_advanced',
            )
            .toList(growable: false);
        selectedConsonants = letterCount >= advancedConsonants.length
            ? advancedConsonants
            : advancedConsonants
                  .take(max(letterCount, 4))
                  .toList(growable: false);
        selectedVowels = <HangulLetter>[baseVowel];
        break;
      case HangulCourseFocus.structure:
      case HangulCourseFocus.mixed:
        if (letterCount >= totalAlphabetCount) {
          selectedConsonants = allConsonants;
          selectedVowels = allVowels;
        } else {
          final int evenCount = letterCount.isOdd
              ? letterCount - 1
              : letterCount;
          final int clampedCount = evenCount < 4 ? 4 : evenCount;
          final int maxPairCount = min(allConsonants.length, allVowels.length);
          final int pairCount = min(max(clampedCount ~/ 2, 2), maxPairCount);

          selectedConsonants = allConsonants
              .take(pairCount)
              .toList(growable: false);
          selectedVowels = allVowels.take(pairCount).toList(growable: false);
        }
        break;
    }

    final List<HangulSyllable> syllables = _buildSyllables(
      selectedConsonants,
      selectedVowels,
    );

    state = state.copyWith(
      courseFocus: courseFocus,
      selectedConsonants: selectedConsonants,
      selectedVowels: selectedVowels,
      generatedSyllables: syllables,
      currentIndex: 0,
      isTestMode: false,
      trainingMode: trainingMode,
      trainingQuestionCount: 50,
      selectedExerciseTypes: selectedExerciseTypes.isEmpty
          ? HangulExerciseType.values
          : selectedExerciseTypes,
      testResults: <String, bool>{},
    );
  }

  void nextLessonStep() {
    if (state.currentIndex < 4) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previousLessonStep() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void startTest() {
    state = state.copyWith(
      isTestMode: true,
      testResults: <String, bool>{},
      currentIndex: 0,
    );
  }

  void endTest() {
    final Set<String> newLearned = {
      ...state.allLearned,
      ...state.selectedLetters.map((HangulLetter l) => l.id),
    };

    state = state.copyWith(isTestMode: false, allLearned: newLearned);
  }

  void recordTestAnswer(String questionId, bool isCorrect) {
    final Map<String, bool> updated = {
      ...state.testResults,
      questionId: isCorrect,
    };

    state = state.copyWith(testResults: updated);
  }

  void resetSession() {
    state = const HangulSessionState(
      courseFocus: HangulCourseFocus.structure,
      selectedConsonants: <HangulLetter>[],
      selectedVowels: <HangulLetter>[],
      generatedSyllables: <HangulSyllable>[],
      currentIndex: 0,
      isTestMode: false,
      trainingMode: false,
      trainingQuestionCount: 50,
      selectedExerciseTypes: HangulExerciseType.values,
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

final hangulConsonantCountProvider = Provider<int>((Ref ref) {
  return hangulCategoriesData
      .expand((HangulCategory category) => category.letters)
      .where((HangulLetter letter) => letter.category.startsWith('consonant'))
      .length;
});

final hangulVowelCountProvider = Provider<int>((Ref ref) {
  return hangulCategoriesData
      .expand((HangulCategory category) => category.letters)
      .where((HangulLetter letter) => letter.category.startsWith('vowel'))
      .length;
});

final hangulAlphabetTotalCountProvider = Provider<int>((Ref ref) {
  final int consonants = ref.watch(hangulConsonantCountProvider);
  final int vowels = ref.watch(hangulVowelCountProvider);
  return consonants + vowels;
});

enum HangulExerciseType {
  qcmReading,
  syllableComposition,
  audioRecognition,
  romanizationToHangul,
  hangulToRomanization,
  keyboardWriting,
  dragDropComposition,
}

class HangulSyllable {
  const HangulSyllable({
    required this.consonant,
    required this.vowel,
    required this.character,
    required this.romanization,
  });

  final HangulLetter consonant;
  final HangulLetter vowel;
  final String character;
  final String romanization;
}

String composeHangulSyllable(String onset, String nucleus) {
  const List<String> initials = <String>[
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ',
  ];
  const List<String> medials = <String>[
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅗ',
    'ㅘ',
    'ㅙ',
    'ㅚ',
    'ㅛ',
    'ㅜ',
    'ㅝ',
    'ㅞ',
    'ㅟ',
    'ㅠ',
    'ㅡ',
    'ㅢ',
    'ㅣ',
  ];

  final int onsetIndex = initials.indexOf(onset);
  final int nucleusIndex = medials.indexOf(nucleus);
  if (onsetIndex < 0 || nucleusIndex < 0) {
    return onset + nucleus;
  }

  final int syllableCode = 0xAC00 + ((onsetIndex * 21) + nucleusIndex) * 28;
  return String.fromCharCode(syllableCode);
}
