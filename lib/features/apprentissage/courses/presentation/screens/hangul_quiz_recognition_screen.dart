// Quiz Hangul (module Cours).
//
// Données : hangulQuizSessionProvider → API GET /courses/hangul/exercises/session?count=10
// Le backend renvoie 10 exercices distincts ; cet écran les enchaîne sans retirer au hasard.
// Le visuel (cartes, boutons, score) est resté identique à la version « front seul » du collègue.
//
// Voir expliquation.md §10–§15 pour l'architecture complète.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/hangul_exercise.dart';
import '../viewmodels/hangul_quiz_viewmodel.dart';

class HangulQuizAndRecognitionScreen extends ConsumerStatefulWidget {
  const HangulQuizAndRecognitionScreen({super.key});

  @override
  ConsumerState<HangulQuizAndRecognitionScreen> createState() =>
      _HangulQuizAndRecognitionScreenState();
}

class _HangulQuizAndRecognitionScreenState
    extends ConsumerState<HangulQuizAndRecognitionScreen> {
  static const int pointsPerCorrectAnswer = 10;

  List<_ExerciseSession>? _questions;
  late _ExerciseSession _session = _ExerciseSession.empty();

  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;

  String? _pendingSelected;

  int get _totalQuestions => _questions?.length ?? 10;

  /// Construit la liste des 10 questions une seule fois (ordre fixé par l'API).
  void _initSession(List<HangulExercise> exercises) {
    if (_questions != null) return;
    final rnd = Random();
    _questions = exercises
        .map((e) => _ExerciseSession.fromExercise(e, rnd))
        .toList();
    _session = _questions!.first;
  }

  void _startNextQuestion() {
    final questions = _questions;
    if (questions == null) return;

    if (_currentIndex >= questions.length - 1) {
      _finishQuiz();
      return;
    }

    setState(() {
      _currentIndex++;
      _pendingSelected = null;
      _session = questions[_currentIndex];
    });
  }

  void _finishQuiz() {
    setState(() {
      _isFinished = true;
    });

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz terminé'),
          content: Text(
            'Score : $_score / ${_totalQuestions * pointsPerCorrectAnswer}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).maybePop();
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _onSelectAnswer(String selected) {
    if (_isFinished) return;
    setState(() {
      _pendingSelected = selected;
    });
  }

  void _onValidateAndNext() {
    if (_isFinished) return;
    final selected = _pendingSelected;
    if (selected == null) return;

    final isCorrect = selected == _session.correctChoice;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect
              ? 'Bonne réponse ✅'
              : 'Mauvaise réponse ❌ (bonne réponse : ${_session.correctChoice})',
        ),
        duration: const Duration(milliseconds: 1200),
      ),
    );

    if (isCorrect) {
      setState(() {
        _score += pointsPerCorrectAnswer;
      });
    }

    _startNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(hangulQuizSessionProvider);

    return exercisesAsync.when(
      loading: () => _buildShell(
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => _buildShell(
        child: Center(child: Text('Erreur: $error')),
      ),
      data: (exercises) {
        if (exercises.isEmpty) {
          return _buildShell(
            child: const Center(child: Text('Aucun exercice disponible.')),
          );
        }

        _initSession(exercises);

        return _buildShell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _QuizCard(
              session: _session,
              onAnswer: _onSelectAnswer,
              onNext: _onValidateAndNext,
              isFinished: _isFinished,
              pendingSelected: _pendingSelected,
              currentQuestionIndex: _currentIndex,
              totalQuestions: _totalQuestions,
            ),
          ),
        );
      },
    );
  }

  Widget _buildShell({required Widget child}) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SizedBox(
                height: 32,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        tooltip: 'Fermer',
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    Text(
                      'Question ${_currentIndex + 1}/$_totalQuestions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Score : $_score',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  const _QuizCard({
    required this.session,
    required this.onAnswer,
    required this.onNext,
    required this.isFinished,
    required this.pendingSelected,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  });

  final _ExerciseSession session;
  final ValueChanged<String> onAnswer;
  final VoidCallback onNext;
  final bool isFinished;
  final String? pendingSelected;
  final int currentQuestionIndex;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          session.title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Text(
          session.modeDescription,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Question : ${currentQuestionIndex + 1}/$totalQuestions',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(session.prompt, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                const Text(
                  'Choisissez la bonne réponse :',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                ...session.choices.map((c) {
                  final isSelected = pendingSelected == c;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: OutlinedButton(
                      onPressed: isFinished ? null : () => onAnswer(c),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        side: BorderSide(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).dividerColor,
                        ),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (isFinished || pendingSelected == null)
                        ? null
                        : onNext,
                    child: const Text('Suivant'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ExerciseSession {
  _ExerciseSession({
    required this.title,
    required this.modeDescription,
    required this.prompt,
    required this.correctChoice,
    required this.choices,
  });

  String title;
  String modeDescription;
  String prompt;
  String correctChoice;
  List<String> choices;

  factory _ExerciseSession.empty() {
    return _ExerciseSession(
      title: '',
      modeDescription: '',
      prompt: '',
      correctChoice: '',
      choices: const [],
    );
  }

  static _ExerciseSession fromExercise(HangulExercise ex, Random rnd) {
    final shuffledChoices = [...ex.choices]..shuffle(rnd);

    return _ExerciseSession(
      title: ex.title,
      modeDescription: ex.modeDescription,
      prompt: ex.prompt,
      correctChoice: ex.correctChoice,
      choices: shuffledChoices,
    );
  }
}
