import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/exercise.dart';
import '../../../../../lib/features/learning/domain/usecases/get_exercises_usecase.dart';
import '../../../../../lib/features/learning/presentation/screens/course_screen.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/learning_providers.dart';

void main() {
  Widget buildTestApp({
    required GetExercisesUseCase useCase,
    String? lessonIdFilter,
    String? sourceWord,
  }) {
    return ProviderScope(
      overrides: <Override>[
        getExercisesUseCaseProvider.overrideWithValue(useCase),
      ],
      child: MaterialApp(
        home: CourseScreen(
          lessonIdFilter: lessonIdFilter,
          sourceWord: sourceWord,
        ),
      ),
    );
  }

  group('CourseScreen', () {
    testWidgets('filters exercises in contextual mode', (
      WidgetTester tester,
    ) async {
      final FakeExerciseRepository repository = FakeExerciseRepository(
        initialExercises: <ExerciseEntity>[
          sampleExercise(id: 'e1'),
          const ExerciseEntity(
            id: 'e2',
            type: 'translation',
            difficulty: 1,
            lessonId: 'l2',
            questionText: 'Question l2',
            options: <String>['a', 'b'],
            correctAnswer: 'a',
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestApp(
          useCase: GetExercisesUseCase(repository),
          lessonIdFilter: 'l1',
          sourceWord: '사람',
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.textContaining('Exercices lies au mot'), findsOneWidget);
      expect(find.text('Que signifie 먹다 ?'), findsOneWidget);
      expect(find.text('Question l2'), findsNothing);
    });

    testWidgets('shows empty contextual message when no exercise matches', (
      WidgetTester tester,
    ) async {
      final FakeExerciseRepository repository = FakeExerciseRepository(
        initialExercises: <ExerciseEntity>[sampleExercise(id: 'e1')],
      );

      await tester.pumpWidget(
        buildTestApp(
          useCase: GetExercisesUseCase(repository),
          lessonIdFilter: 'l9',
          sourceWord: '사람',
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Aucun exercice lie a cette lecon.'), findsOneWidget);
    });

    testWidgets('opens exercise execution screen when tapping an exercise', (
      WidgetTester tester,
    ) async {
      final FakeExerciseRepository repository = FakeExerciseRepository(
        initialExercises: <ExerciseEntity>[sampleExercise(id: 'e1')],
      );

      await tester.pumpWidget(
        buildTestApp(useCase: GetExercisesUseCase(repository)),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('Que signifie 먹다 ?'));
      await tester.pumpAndSettle();

      expect(find.text('Execution exercice'), findsOneWidget);
      expect(find.text('Valider la reponse'), findsOneWidget);
    });
  });
}
