import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise.dart';
import '../viewmodels/course_viewmodel.dart';
import '../widgets/exercise_card.dart';
import 'exercise_execution_screen.dart';

class CourseScreen extends ConsumerWidget {
  const CourseScreen({super.key, this.lessonIdFilter, this.sourceWord});

  final String? lessonIdFilter;
  final String? sourceWord;

  bool get _isContextualMode => lessonIdFilter != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ExerciseEntity>> exercisesState = ref.watch(
      courseViewModelProvider,
    );

    return Scaffold(
      appBar: AppBar(title: Text(_isContextualMode ? 'Cours lies' : 'Cours')),
      body: exercisesState.when(
        data: (List<ExerciseEntity> exercises) {
          final List<ExerciseEntity> displayedExercises = lessonIdFilter == null
              ? exercises
              : exercises
                    .where(
                      (ExerciseEntity exercise) =>
                          exercise.lessonId == lessonIdFilter,
                    )
                    .toList();

          if (displayedExercises.isEmpty) {
            return Center(
              child: Text(
                _isContextualMode
                    ? 'Aucun exercice lie a cette lecon.'
                    : 'Aucun exercice disponible.',
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_isContextualMode)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        sourceWord == null
                            ? 'Exercices de la lecon $lessonIdFilter'
                            : 'Exercices lies au mot "$sourceWord" (lecon $lessonIdFilter)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    _isContextualMode ? 0 : 16,
                    16,
                    16,
                  ),
                  itemCount: displayedExercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    final ExerciseEntity exercise = displayedExercises[index];

                    return ExerciseCard(
                      exercise: exercise,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                ExerciseExecutionScreen(exercise: exercise),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Impossible de charger les exercices.'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => ref
                        .read(courseViewModelProvider.notifier)
                        .loadExercises(),
                    child: const Text('Reessayer'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
