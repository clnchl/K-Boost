import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise.dart';
import '../viewmodels/exercise_score_viewmodel.dart';

class ExerciseExecutionScreen extends ConsumerStatefulWidget {
  const ExerciseExecutionScreen({super.key, required this.exercise});

  final ExerciseEntity exercise;

  @override
  ConsumerState<ExerciseExecutionScreen> createState() =>
      _ExerciseExecutionScreenState();
}

class _ExerciseExecutionScreenState
    extends ConsumerState<ExerciseExecutionScreen> {
  String? _selectedOption;
  bool _isSubmitted = false;

  bool get _isCorrect => _selectedOption == widget.exercise.correctAnswer;

  void _submitAnswer() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Selectionne une reponse.')));
      return;
    }

    final bool isCorrect = _isCorrect;

    setState(() {
      _isSubmitted = true;
    });

    ref
        .read(exerciseScoreViewModelProvider.notifier)
        .registerAttempt(isCorrect: isCorrect);
  }

  void _resetExercise() {
    setState(() {
      _isSubmitted = false;
      _selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseEntity exercise = widget.exercise;
    final ExerciseScoreState scoreState = ref.watch(
      exerciseScoreViewModelProvider,
    );
    final int successRatePercent = (scoreState.successRate * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Execution exercice'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Reinitialiser score',
            onPressed: () =>
                ref.read(exerciseScoreViewModelProvider.notifier).resetScore(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Score session',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text('Points: ${scoreState.totalPoints}'),
                  Text('Tentatives: ${scoreState.totalAttempts}'),
                  Text('Reussites: ${scoreState.successAttempts}'),
                  Text('Taux de reussite: $successRatePercent%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(exercise.type, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Text(
            exercise.questionText,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ...exercise.options.map(
            (String option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _selectedOption,
              onChanged: _isSubmitted
                  ? null
                  : (String? value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
            ),
          ),
          const SizedBox(height: 12),
          if (!_isSubmitted)
            FilledButton(
              onPressed: _submitAnswer,
              child: const Text('Valider la reponse'),
            ),
          if (_isSubmitted) ...<Widget>[
            Card(
              color: _isCorrect
                  ? Colors.green.withOpacity(0.12)
                  : Colors.red.withOpacity(0.12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _isCorrect ? 'Bonne reponse !' : 'Mauvaise reponse.',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (!_isCorrect) ...<Widget>[
                      const SizedBox(height: 6),
                      Text('Bonne reponse: ${exercise.correctAnswer}'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetExercise,
                    child: const Text('Recommencer'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Terminer'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
