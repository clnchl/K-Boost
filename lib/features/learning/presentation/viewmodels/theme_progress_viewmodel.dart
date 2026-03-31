import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProgressViewModelProvider =
    StateNotifierProvider<ThemeProgressViewModel, Set<String>>(
      (Ref ref) => ThemeProgressViewModel(),
    );

class ThemeProgressViewModel extends StateNotifier<Set<String>> {
  ThemeProgressViewModel() : super(<String>{});

  void markExerciseCompleted(String exerciseId) {
    if (state.contains(exerciseId)) {
      return;
    }

    state = <String>{...state, exerciseId};
  }
}
