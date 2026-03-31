import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/learning/presentation/viewmodels/exercise_score_viewmodel.dart';

void main() {
  group('ExerciseScoreViewModel', () {
    test('starts with zeroed score state', () {
      final ExerciseScoreViewModel viewModel = ExerciseScoreViewModel();

      expect(viewModel.state.totalAttempts, 0);
      expect(viewModel.state.successAttempts, 0);
      expect(viewModel.state.totalPoints, 0);
      expect(viewModel.state.successRate, 0);
    });

    test('registerAttempt updates score for success', () {
      final ExerciseScoreViewModel viewModel = ExerciseScoreViewModel();

      viewModel.registerAttempt(isCorrect: true);

      expect(viewModel.state.totalAttempts, 1);
      expect(viewModel.state.successAttempts, 1);
      expect(viewModel.state.totalPoints, 10);
      expect(viewModel.state.successRate, 1);
    });

    test('registerAttempt updates score for failure', () {
      final ExerciseScoreViewModel viewModel = ExerciseScoreViewModel();

      viewModel.registerAttempt(isCorrect: false);

      expect(viewModel.state.totalAttempts, 1);
      expect(viewModel.state.successAttempts, 0);
      expect(viewModel.state.totalPoints, 0);
      expect(viewModel.state.successRate, 0);
    });

    test('resetScore clears all accumulated values', () {
      final ExerciseScoreViewModel viewModel = ExerciseScoreViewModel();
      viewModel.registerAttempt(isCorrect: true);
      viewModel.registerAttempt(isCorrect: false);

      viewModel.resetScore();

      expect(viewModel.state.totalAttempts, 0);
      expect(viewModel.state.successAttempts, 0);
      expect(viewModel.state.totalPoints, 0);
      expect(viewModel.state.successRate, 0);
    });
  });
}
