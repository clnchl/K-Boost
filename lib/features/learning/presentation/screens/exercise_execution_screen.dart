import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise.dart';
import '../viewmodels/exercise_score_viewmodel.dart';
import '../viewmodels/theme_progress_viewmodel.dart';

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
  late List<String> _shuffledOptions;

  bool get _isCorrect => _selectedOption == widget.exercise.correctAnswer;

  @override
  void initState() {
    super.initState();
    _shuffledOptions = List<String>.from(widget.exercise.options)..shuffle();
  }

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
    ref
        .read(themeProgressViewModelProvider.notifier)
        .markExerciseCompleted(widget.exercise.id);
  }

  void _resetExercise() {
    setState(() {
      _isSubmitted = false;
      _selectedOption = null;
      _shuffledOptions = List<String>.from(widget.exercise.options)..shuffle();
    });
  }

  Color get _defaultOptionColor =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  Color _optionTileColor(String option) {
    final bool isCorrect = option == widget.exercise.correctAnswer;
    final bool isWrongSelected =
        _isSubmitted && option == _selectedOption && !isCorrect;

    if (!_isSubmitted) {
      return _defaultOptionColor.withOpacity(0.2);
    }
    if (isCorrect) {
      return Colors.green.withOpacity(0.18);
    }
    if (isWrongSelected) {
      return Colors.red.withOpacity(0.18);
    }
    return _defaultOptionColor.withOpacity(0.1);
  }

  Widget? _optionTrailingIcon(String option) {
    final bool isCorrect = option == widget.exercise.correctAnswer;
    final bool isWrongSelected =
        _isSubmitted && option == _selectedOption && !isCorrect;

    if (!_isSubmitted) {
      return null;
    }
    if (isCorrect) {
      return const Icon(Icons.check_circle_rounded, color: Colors.green);
    }
    if (isWrongSelected) {
      return const Icon(Icons.cancel_rounded, color: Colors.red);
    }
    return null;
  }

  Widget _buildOptionTile(String option) {
    return RadioListTile<String>(
      tileColor: _optionTileColor(option),
      secondary: _optionTrailingIcon(option),
      title: Text(option),
      value: option,
      groupValue: _selectedOption,
      onChanged: _isSubmitted
          ? null
          : (String? value) => setState(() => _selectedOption = value),
    );
  }

  Widget _buildResultCard(ExerciseEntity exercise) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
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
              style: textTheme.titleMedium,
            ),
            if (!_isCorrect) ...<Widget>[
              const SizedBox(height: 6),
              Text('Bonne reponse: ${exercise.correctAnswer}'),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseEntity exercise = widget.exercise;
    final textTheme = Theme.of(context).textTheme;
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
                  Text('Score session', style: textTheme.titleMedium),
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
          Text(exercise.type, style: textTheme.titleSmall),
          const SizedBox(height: 8),
          Text(exercise.questionText, style: textTheme.headlineSmall),
          const SizedBox(height: 16),
          ..._shuffledOptions.map(_buildOptionTile),
          const SizedBox(height: 12),
          if (!_isSubmitted)
            FilledButton(
              onPressed: _submitAnswer,
              child: const Text('Valider la reponse'),
            ),
          if (_isSubmitted) ...<Widget>[
            _buildResultCard(exercise),
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
