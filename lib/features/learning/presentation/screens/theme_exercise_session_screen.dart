import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exercise.dart';
import '../viewmodels/exercise_score_viewmodel.dart';
import '../viewmodels/theme_progress_viewmodel.dart';
import '../widgets/theme_ui_helpers.dart';

class ThemeExerciseSessionScreen extends ConsumerStatefulWidget {
  const ThemeExerciseSessionScreen({
    super.key,
    required this.exercises,
    required this.themeName,
  });

  final List<ExerciseEntity> exercises;
  final String themeName;

  @override
  ConsumerState<ThemeExerciseSessionScreen> createState() =>
      _ThemeExerciseSessionScreenState();
}

class _ThemeExerciseSessionScreenState
    extends ConsumerState<ThemeExerciseSessionScreen> {
  int _index = 0;
  int _sessionPoints = 0;
  String? _selectedOption;
  bool _isSubmitted = false;
  late List<String> _shuffledOptions;

  ExerciseEntity get _currentExercise => widget.exercises[_index];
  bool get _hasNext => _index < widget.exercises.length - 1;
  String get _actionLabel => !_isSubmitted
      ? 'Vérifier'
      : (_hasNext ? 'Question suivante' : 'Terminer');

  @override
  void initState() {
    super.initState();
    _shuffleCurrentOptions();
  }

  void _shuffleCurrentOptions() {
    _shuffledOptions = List<String>.from(_currentExercise.options)..shuffle();
  }

  void _submitCurrentAnswer() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Selectionne une reponse.')));
      return;
    }

    final bool isCorrect = _selectedOption == _currentExercise.correctAnswer;

    if (isCorrect) {
      _sessionPoints += 10;
    }

    ref
        .read(exerciseScoreViewModelProvider.notifier)
        .registerAttempt(isCorrect: isCorrect);
    ref
        .read(themeProgressViewModelProvider.notifier)
        .markExerciseCompleted(_currentExercise.id);

    setState(() {
      _isSubmitted = true;
    });
  }

  void _goNext() {
    setState(() {
      _index += 1;
      _selectedOption = null;
      _isSubmitted = false;
      _shuffleCurrentOptions();
    });
  }

  Future<void> _showFinishBanner() async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    messenger.clearMaterialBanners();
    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text('Bravo ! +$_sessionPoints points gagnés.'),
        leading: const Icon(Icons.emoji_events_rounded, color: Colors.amber),
        backgroundColor: Colors.green.withOpacity(0.12),
        actions: <Widget>[
          TextButton(
            onPressed: messenger.hideCurrentMaterialBanner,
            child: const Text('OK'),
          ),
        ],
      ),
    );

    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }
    messenger.hideCurrentMaterialBanner();
    Navigator.of(context).pop();
  }

  Future<void> _goNextOrFinish() async {
    if (!_isSubmitted) {
      _submitCurrentAnswer();
      return;
    }
    if (_hasNext) {
      _goNext();
      return;
    }
    await _showFinishBanner();
  }

  Color get _defaultOptionColor =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  Color _optionTileColor(String option) {
    final bool isCorrect = option == _currentExercise.correctAnswer;
    final bool isWrongSelected =
        _isSubmitted && option == _selectedOption && !isCorrect;

    if (!_isSubmitted) {
      return _defaultOptionColor.withOpacity(0.35);
    }
    if (isCorrect) {
      return Colors.green.withOpacity(0.18);
    }
    if (isWrongSelected) {
      return Colors.red.withOpacity(0.18);
    }
    return _defaultOptionColor.withOpacity(0.2);
  }

  Widget? _optionTrailingIcon(String option) {
    final bool isCorrect = option == _currentExercise.correctAnswer;
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: RadioListTile<String>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: _optionTileColor(option),
        secondary: _optionTrailingIcon(option),
        title: Text(option),
        value: option,
        groupValue: _selectedOption,
        onChanged: _isSubmitted
            ? null
            : (String? value) => setState(() => _selectedOption = value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.exercises.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.themeName)),
        body: const Center(child: Text('Aucun exercice disponible.')),
      );
    }

    final int total = widget.exercises.length;
    final textTheme = Theme.of(context).textTheme;
    final Color pointsBg = Theme.of(context).colorScheme.primaryContainer;
    final double progress = (_index + 1) / total;

    return Scaffold(
      appBar: AppBar(title: Text(widget.themeName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Question ${_index + 1}/$total',
                  style: textTheme.titleLarge,
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: pointsBg,
                  child: Text('$_sessionPoints'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(value: progress, minHeight: 12),
            ),
            const SizedBox(height: 24),
            exerciseMetaChips(_currentExercise.type),
            const SizedBox(height: 10),
            Text(_currentExercise.questionText, style: textTheme.headlineSmall),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: _shuffledOptions.map(_buildOptionTile).toList(),
              ),
            ),
            FilledButton(onPressed: _goNextOrFinish, child: Text(_actionLabel)),
          ],
        ),
      ),
    );
  }
}
