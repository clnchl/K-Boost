import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseScoreViewModelProvider =
    StateNotifierProvider<ExerciseScoreViewModel, ExerciseScoreState>(
      (Ref ref) => ExerciseScoreViewModel(),
    );

class ExerciseScoreState {
  const ExerciseScoreState({
    this.totalAttempts = 0,
    this.successAttempts = 0,
    this.totalPoints = 0,
  });

  final int totalAttempts;
  final int successAttempts;
  final int totalPoints;

  double get successRate {
    if (totalAttempts == 0) {
      return 0;
    }

    return successAttempts / totalAttempts;
  }

  ExerciseScoreState copyWith({
    int? totalAttempts,
    int? successAttempts,
    int? totalPoints,
  }) {
    return ExerciseScoreState(
      totalAttempts: totalAttempts ?? this.totalAttempts,
      successAttempts: successAttempts ?? this.successAttempts,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }
}

class ExerciseScoreViewModel extends StateNotifier<ExerciseScoreState> {
  ExerciseScoreViewModel() : super(const ExerciseScoreState());

  void registerAttempt({required bool isCorrect}) {
    state = state.copyWith(
      totalAttempts: state.totalAttempts + 1,
      successAttempts: state.successAttempts + (isCorrect ? 1 : 0),
      totalPoints: state.totalPoints + (isCorrect ? 10 : 0),
    );
  }

  void resetScore() {
    state = const ExerciseScoreState();
  }
}
