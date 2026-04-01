import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_learning.dart';
import '../../domain/entities/theme.dart';
import '../viewmodels/course_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../viewmodels/theme_progress_viewmodel.dart';
import '../widgets/exercise_card.dart';
import '../widgets/theme_card.dart';
import '../widgets/theme_preview_sheet.dart';
import 'exercise_execution_screen.dart';
import 'theme_exercise_session_screen.dart';

class CourseScreen extends ConsumerWidget {
  const CourseScreen({super.key, this.lessonIdFilter, this.sourceWord});

  final String? lessonIdFilter;
  final String? sourceWord;

  bool get _isContextualMode => lessonIdFilter != null;

  String get _contextualHeaderText {
    if (sourceWord == null) {
      return 'Exercices de la lecon $lessonIdFilter';
    }
    return 'Exercices lies au mot "$sourceWord" (lecon $lessonIdFilter)';
  }

  void _openExercise(BuildContext context, ExerciseEntity exercise) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ExerciseExecutionScreen(exercise: exercise),
      ),
    );
  }

  Widget _buildRetryState({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message),
            const SizedBox(height: 8),
            FilledButton(onPressed: onRetry, child: const Text('Reessayer')),
          ],
        ),
      ),
    );
  }

  Future<void> _showThemePreviewAndOpen(
    BuildContext context,
    ThemeEntity theme,
    List<ExerciseEntity> allExercises,
    double progress,
  ) async {
    final List<ExerciseEntity> rawThemeExercises = allExercises
        .where(
          (ExerciseEntity exercise) => theme.exerciseIds.contains(exercise.id),
        )
        .toList();

    final List<ExerciseEntity> themeExercises = orderExercisesForLearning(
      rawThemeExercises,
    ).take(2).toList();

    final bool? shouldOpen = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ThemePreviewSheet(
        theme: theme,
        exercises: themeExercises,
        progress: progress,
      ),
    );

    if (shouldOpen == true && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ThemeExerciseSessionScreen(
            exercises: themeExercises,
            themeName: theme.name,
          ),
        ),
      );
    }
  }

  Widget _buildContextualContent(
    BuildContext context,
    List<ExerciseEntity> exercises,
  ) {
    final List<ExerciseEntity> displayedExercises = exercises
        .where((ExerciseEntity exercise) => exercise.lessonId == lessonIdFilter)
        .toList();

    if (displayedExercises.isEmpty) {
      return const Center(child: Text('Aucun exercice lie a cette lecon.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                _contextualHeaderText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: displayedExercises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) => ExerciseCard(
              exercise: displayedExercises[index],
              onTap: () => _openExercise(context, displayedExercises[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeList(
    BuildContext context,
    List<ThemeEntity> themes,
    List<ExerciseEntity> allExercises,
    Set<String> completedExerciseIds,
  ) {
    if (themes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.school_rounded, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Aucun thème disponible.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: themes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final ThemeEntity theme = themes[index];
        final List<ExerciseEntity> themeExercises = allExercises
            .where((ExerciseEntity e) => theme.exerciseIds.contains(e.id))
            .toList();
        final LearningSummary summary = summarizeExercisesForLearning(
          themeExercises,
        );

        final double progress = _themeProgress(theme, completedExerciseIds);
        final bool isCompleted = progress == 1 && theme.exerciseIds.isNotEmpty;

        return ThemeCard(
          theme: theme,
          stageLabel: summary.stageLabel,
          levelLabel: summary.levelLabel,
          stageBreakdownParts: summary.stageBreakdownParts,
          progress: progress,
          isCompleted: isCompleted,
          onTap: () =>
              _showThemePreviewAndOpen(context, theme, allExercises, progress),
        );
      },
    );
  }

  double _themeProgress(ThemeEntity theme, Set<String> completedExerciseIds) {
    final int total = theme.exerciseIds.length;
    if (total == 0) {
      return 0;
    }
    final int completed = theme.exerciseIds
        .where(completedExerciseIds.contains)
        .length;
    return completed / total;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_isContextualMode) {
      final AsyncValue<List<ExerciseEntity>> exercisesState = ref.watch(
        courseViewModelProvider,
      );

      return Scaffold(
        appBar: AppBar(title: const Text('Exercices lies')),
        body: exercisesState.when(
          data: (List<ExerciseEntity> exercises) =>
              _buildContextualContent(context, exercises),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => _buildRetryState(
            message: 'Impossible de charger les exercices.',
            onRetry: () =>
                ref.read(courseViewModelProvider.notifier).loadExercises(),
          ),
        ),
      );
    }

    final AsyncValue<List<ThemeEntity>> themesState = ref.watch(
      themeViewModelProvider,
    );
    final AsyncValue<List<ExerciseEntity>> exercisesState = ref.watch(
      courseViewModelProvider,
    );
    final Set<String> completedExerciseIds = ref.watch(
      themeProgressViewModelProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Cours')),
      body: themesState.when(
        data: (List<ThemeEntity> themes) => _buildThemeList(
          context,
          themes,
          exercisesState.valueOrNull ?? <ExerciseEntity>[],
          completedExerciseIds,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _buildRetryState(
          message: 'Impossible de charger les thèmes.',
          onRetry: () => ref.read(themeViewModelProvider.notifier).loadThemes(),
        ),
      ),
    );
  }
}
