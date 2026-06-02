import 'dart:math';

import 'package:flutter/material.dart';

class HangulQuizAndRecognitionScreen extends StatefulWidget {
  const HangulQuizAndRecognitionScreen({super.key});

  @override
  State<HangulQuizAndRecognitionScreen> createState() =>
      _HangulQuizAndRecognitionScreenState();
}

class _HangulQuizAndRecognitionScreenState
    extends State<HangulQuizAndRecognitionScreen> {
  static const int totalQuestions = 10;
  static const int pointsPerCorrectAnswer = 10;

  late final _ExerciseSession _session = _ExerciseSession.random();

  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;

  String? _pendingSelected;

  void _startNextQuestion() {
    if (_currentIndex >= totalQuestions - 1) {
      _finishQuiz();
      return;
    }

    setState(() {
      _currentIndex++;
      _pendingSelected = null;
      _session.regenerate();
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
            'Score : $_score / ${totalQuestions * pointsPerCorrectAnswer}',
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
                      'Question ${_currentIndex + 1}/$totalQuestions',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _QuizCard(
                  session: _session,
                  onAnswer: _onSelectAnswer,
                  onNext: _onValidateAndNext,
                  isFinished: _isFinished,
                  pendingSelected: _pendingSelected,
                  currentQuestionIndex: _currentIndex,
                  totalQuestions: totalQuestions,
                ),
              ),
            ),
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

  void regenerate() {
    final next = _ExerciseSession.random();
    title = next.title;
    modeDescription = next.modeDescription;
    prompt = next.prompt;
    correctChoice = next.correctChoice;
    choices = next.choices;
  }

  static _ExerciseSession random() {
    final rnd = Random();

    // Banque élargie pour réduire les répétitions.
    final exercises = <_ExerciseDefinition>[
      // -------------------- QUIZZ : son -> hangul (a) --------------------
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "ga" ?',
        correctChoice: '가',
        choices: ['가', '나', '다', '라'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "na" ?',
        correctChoice: '나',
        choices: ['가', '나', '다', '마'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "da" ?',
        correctChoice: '다',
        choices: ['다', '라', '바', '사'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "ra" ?',
        correctChoice: '라',
        choices: ['라', '마', '바', '다'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "ma" ?',
        correctChoice: '마',
        choices: ['마', '나', '바', '사'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "ba" ?',
        correctChoice: '바',
        choices: ['바', '다', '사', '라'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "sa" ?',
        correctChoice: '사',
        choices: ['사', '다', '바', '아'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (son → hangul)',
        modeDescription: 'Associe le son à la bonne syllabe hangul.',
        prompt: 'Quel hangul correspond au son : "ah" ?',
        correctChoice: '아',
        choices: ['아', '나', '다', '라'],
      ),

      // -------------------- QUIZZ : jamo -> hangul (a) --------------------
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㄱ + ㅏ → quel hangul ?',
        correctChoice: '가',
        choices: ['가', '나', '다', '바'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㄴ + ㅏ → quel hangul ?',
        correctChoice: '나',
        choices: ['나', '가', '다', '마'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㄷ + ㅏ → quel hangul ?',
        correctChoice: '다',
        choices: ['다', '라', '바', '사'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㄹ + ㅏ → quel hangul ?',
        correctChoice: '라',
        choices: ['라', '마', '바', '다'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㅁ + ㅏ → quel hangul ?',
        correctChoice: '마',
        choices: ['마', '바', '나', '다'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㅂ + ㅏ → quel hangul ?',
        correctChoice: '바',
        choices: ['바', '다', '사', '라'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㅅ + ㅏ → quel hangul ?',
        correctChoice: '사',
        choices: ['사', '다', '바', '아'],
      ),
      _ExerciseDefinition(
        title: 'Quizz (jamo → syllabe)',
        modeDescription: 'Compose la syllabe à partir des jamo.',
        prompt: 'Associe ㅇ + ㅏ → quel hangul ? (아)',
        correctChoice: '아',
        choices: ['아', '나', '다', '라'],
      ),

      // -------------------- RECONNAISSANCE : hangul -> son --------------------
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 가 ?',
        correctChoice: 'ga',
        choices: ['ga', 'na', 'da', 'ba'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 나 ?',
        correctChoice: 'na',
        choices: ['na', 'ga', 'da', 'ma'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 다 ?',
        correctChoice: 'da',
        choices: ['da', 'ra', 'ba', 'sa'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 라 ?',
        correctChoice: 'ra',
        choices: ['ra', 'ma', 'ba', 'da'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 마 ?',
        correctChoice: 'ma',
        choices: ['ma', 'na', 'ba', 'da'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 바 ?',
        correctChoice: 'ba',
        choices: ['ba', 'da', 'sa', 'ra'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 사 ?',
        correctChoice: 'sa',
        choices: ['sa', 'da', 'ba', 'ah'],
      ),
      _ExerciseDefinition(
        title: 'Reconnaissance (hangul → son)',
        modeDescription: 'Reconnais la lecture correspondante à la syllabe.',
        prompt: 'Quelle lecture correspond à : 아 ?',
        correctChoice: 'ah',
        choices: ['ah', 'na', 'da', 'ra'],
      ),
    ];

    final ex = exercises[rnd.nextInt(exercises.length)];
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

class _ExerciseDefinition {
  _ExerciseDefinition({
    required this.title,
    required this.modeDescription,
    required this.prompt,
    required this.correctChoice,
    required this.choices,
  });

  final String title;
  final String modeDescription;
  final String prompt;
  final String correctChoice;
  final List<String> choices;
}
