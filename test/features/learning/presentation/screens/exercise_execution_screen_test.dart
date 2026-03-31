import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/presentation/screens/exercise_execution_screen.dart';

void main() {
  Widget buildTestApp() {
    return ProviderScope(
      child: MaterialApp(
        home: ExerciseExecutionScreen(exercise: sampleExercise()),
      ),
    );
  }

  group('ExerciseExecutionScreen', () {
    testWidgets('shows success state for correct answer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('manger'));
      await tester.pump();
      await tester.tap(find.text('Valider la reponse'));
      await tester.pump();

      expect(find.text('Bonne reponse !'), findsOneWidget);
      expect(find.text('Points: 10'), findsOneWidget);
      expect(find.text('Tentatives: 1'), findsOneWidget);
      expect(find.text('Reussites: 1'), findsOneWidget);
    });

    testWidgets('shows failure state and correction for wrong answer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('boire'));
      await tester.pump();
      await tester.tap(find.text('Valider la reponse'));
      await tester.pump();

      expect(find.text('Mauvaise reponse.'), findsOneWidget);
      expect(find.text('Bonne reponse: manger'), findsOneWidget);
      expect(find.text('Points: 0'), findsOneWidget);
      expect(find.text('Tentatives: 1'), findsOneWidget);
      expect(find.text('Reussites: 0'), findsOneWidget);
    });
  });
}
