import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';
import '../viewmodels/hangul_progress_viewmodel.dart';
import '../viewmodels/hangul_viewmodel.dart';

const List<String> _pedagogicalProgressionLabels = <String>[
  '1. Structure des syllabes',
  '2. Voyelles de base',
  '3. Consonnes de base',
  '4. Premières syllabes',
  '5. Premiers mots simples',
  '6. Batchim',
  '7. Batchim doubles',
  '8. Règles de liaison',
  '9. Assimilations de prononciation',
  '10. Voyelles composées',
  '11. Consonnes doubles',
  '12. Mots plus complexes',
  '13. Phrases simples',
];

class HangulTestScreen extends ConsumerStatefulWidget {
  const HangulTestScreen({super.key});

  @override
  ConsumerState<HangulTestScreen> createState() => _HangulTestScreenState();
}

class _HangulTestScreenState extends ConsumerState<HangulTestScreen> {
  late List<HangulTestQuestion> _questions;
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _generateQuestions();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    final HangulSessionState state = ref.read(hangulViewModelProvider);
    final Random random = Random();
    final List<HangulSyllable> syllables = state.generatedSyllables;
    final List<HangulLetter> consonants = state.selectedConsonants;
    final List<HangulLetter> vowels = state.selectedVowels;

    final List<HangulTestQuestion> generated = <HangulTestQuestion>[];
    final int target = state.targetLessonExercises;
    final List<HangulExerciseType> selectedTypes =
        state.selectedExerciseTypes.isEmpty
        ? HangulExerciseType.values
        : state.selectedExerciseTypes;

    if (syllables.isEmpty || consonants.isEmpty || vowels.isEmpty) {
      _questions = <HangulTestQuestion>[];
      return;
    }

    int cursor = 0;
    while (generated.length < target) {
      final HangulExerciseType type =
          selectedTypes[cursor % selectedTypes.length];
      generated.add(
        _buildQuestionForType(
          type: type,
          index: generated.length,
          syllables: syllables,
          consonants: consonants,
          vowels: vowels,
          random: random,
        ),
      );
      cursor++;
    }

    generated.shuffle(random);
    _questions = generated;
  }

  HangulTestQuestion _buildQuestionForType({
    required HangulExerciseType type,
    required int index,
    required List<HangulSyllable> syllables,
    required List<HangulLetter> consonants,
    required List<HangulLetter> vowels,
    required Random random,
  }) {
    final HangulSyllable syllable = syllables[index % syllables.length];
    final HangulLetter consonant = consonants[index % consonants.length];
    final HangulLetter vowel = vowels[index % vowels.length];

    switch (type) {
      case HangulExerciseType.qcmReading:
        return HangulTestQuestion(
          id: 'q_${index}_qcm_reading',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[3],
          prompt: 'QCM de lecture : choisissez la bonne romanisation',
          displayValue: syllable.character,
          correctAnswer: syllable.romanization,
          options: _buildOptions(
            correct: syllable.romanization,
            pool: syllables
                .map((HangulSyllable s) => s.romanization)
                .toList(growable: false),
            fallback: const <String>['ga', 'na', 'da', 'ra', 'ma', 'ba'],
            random: random,
          ),
        );
      case HangulExerciseType.syllableComposition:
        final HangulSyllable composed = HangulSyllable(
          consonant: consonant,
          vowel: vowel,
          character: composeHangulSyllable(
            consonant.character,
            vowel.character,
          ),
          romanization: _normalize(consonant.romanization) + vowel.romanization,
        );
        return HangulTestQuestion(
          id: 'q_${index}_compose',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[0],
          prompt: 'Construisez la bonne syllabe',
          displayValue: '${consonant.character} + ${vowel.character}',
          correctAnswer: composed.character,
          options: _buildOptions(
            correct: composed.character,
            pool: syllables
                .map((HangulSyllable s) => s.character)
                .toList(growable: false),
            fallback: const <String>['가', '고', '나', '노', '다', '도'],
            random: random,
          ),
        );
      case HangulExerciseType.audioRecognition:
        return HangulTestQuestion(
          id: 'q_${index}_audio',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[4],
          prompt: 'Reconnaissance audio : choisissez la syllabe entendue',
          displayValue: '🔊 ${syllable.romanization}',
          correctAnswer: syllable.character,
          options: _buildOptions(
            correct: syllable.character,
            pool: syllables
                .map((HangulSyllable s) => s.character)
                .toList(growable: false),
            fallback: const <String>['가', '나', '다', '라', '마', '바'],
            random: random,
          ),
        );
      case HangulExerciseType.romanizationToHangul:
        return HangulTestQuestion(
          id: 'q_${index}_r2h',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[4],
          prompt: 'Romanisation → Hangul',
          displayValue: syllable.romanization,
          correctAnswer: syllable.character,
          options: _buildOptions(
            correct: syllable.character,
            pool: syllables
                .map((HangulSyllable s) => s.character)
                .toList(growable: false),
            fallback: const <String>['가', '나', '다', '라', '마', '바'],
            random: random,
          ),
        );
      case HangulExerciseType.hangulToRomanization:
        return HangulTestQuestion(
          id: 'q_${index}_h2r',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[3],
          prompt: 'Hangul → Romanisation',
          displayValue: syllable.character,
          correctAnswer: syllable.romanization,
          options: _buildOptions(
            correct: syllable.romanization,
            pool: syllables
                .map((HangulSyllable s) => s.romanization)
                .toList(growable: false),
            fallback: const <String>['ga', 'na', 'da', 'ra', 'ma', 'ba'],
            random: random,
          ),
        );
      case HangulExerciseType.keyboardWriting:
        return HangulTestQuestion(
          id: 'q_${index}_keyboard',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[4],
          prompt: 'Écrivez la syllabe Hangul avec votre clavier',
          displayValue: syllable.romanization,
          correctAnswer: syllable.character,
          options: const <String>[],
          requiresTextInput: true,
        );
      case HangulExerciseType.dragDropComposition:
        final String correctPair =
            '${consonant.character} + ${vowel.character}';
        final List<String> pairPool = <String>[
          for (final HangulLetter c in consonants.take(4))
            for (final HangulLetter v in vowels.take(4))
              '${c.character} + ${v.character}',
        ];
        return HangulTestQuestion(
          id: 'q_${index}_dragdrop',
          exerciseType: type,
          stageLabel: _pedagogicalProgressionLabels[0],
          prompt: 'Drag & drop : choisissez la bonne combinaison',
          displayValue: composeHangulSyllable(
            consonant.character,
            vowel.character,
          ),
          correctAnswer: correctPair,
          options: _buildOptions(
            correct: correctPair,
            pool: pairPool,
            fallback: const <String>['ㄱ + ㅏ', 'ㄴ + ㅏ', 'ㄱ + ㅗ', 'ㄴ + ㅗ'],
            random: random,
          ),
        );
    }
  }

  List<String> _buildOptions({
    required String correct,
    required List<String> pool,
    required List<String> fallback,
    required Random random,
  }) {
    final Set<String> options = <String>{correct};
    final List<String> candidates =
        pool.where((String value) => value != correct).toSet().toList()
          ..shuffle(random);

    for (final String value in candidates) {
      if (options.length >= 4) {
        break;
      }
      options.add(value);
    }

    for (final String value in fallback) {
      if (options.length >= 4) {
        break;
      }
      if (value != correct) {
        options.add(value);
      }
    }

    final List<String> result = options.toList()..shuffle(random);
    return result.take(4).toList(growable: false);
  }

  void _answerQuestion(String answer) {
    final HangulTestQuestion question = _questions[_currentQuestionIndex];
    final bool isCorrect =
        _normalize(answer) == _normalize(question.correctAnswer);

    ref
        .read(hangulViewModelProvider.notifier)
        .recordTestAnswer(question.id, isCorrect);

    setState(() {
      _selectedAnswer = answer;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) {
        return;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
          _textController.clear();
        });
      } else {
        ref.read(hangulViewModelProvider.notifier).endTest();
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const HangulTestResultScreen(),
          ),
        );
      }
    });
  }

  void _submitTypedAnswer() {
    final String typed = _textController.text.trim();
    if (typed.isEmpty || _selectedAnswer != null) {
      return;
    }
    _answerQuestion(typed);
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Test Hangul')),
        body: const Center(child: Text('Impossible de générer des questions.')),
      );
    }

    final HangulTestQuestion question = _questions[_currentQuestionIndex];
    final bool isAnswered = _selectedAnswer != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Test Hangul')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                    ),
                    Text(_typeLabel(question.exerciseType)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _questions.length,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Chip(label: Text(question.stageLabel)),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Text(
                  question.prompt,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Text(
                  question.displayValue,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: question.requiresTextInput
                ? _buildTextInputAnswerArea(question, isAnswered)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.8,
                      children: question.options
                          .map(
                            (String option) => _buildOptionButton(
                              option,
                              question,
                              isAnswered,
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputAnswerArea(
    HangulTestQuestion question,
    bool isAnswered,
  ) {
    final bool typedCorrect =
        isAnswered &&
        _normalize(_selectedAnswer ?? '') == _normalize(question.correctAnswer);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _textController,
            enabled: !isAnswered,
            decoration: const InputDecoration(
              labelText: 'Votre réponse en Hangul',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submitTypedAnswer(),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: isAnswered ? null : _submitTypedAnswer,
            child: const Text('Valider'),
          ),
          const SizedBox(height: 12),
          if (isAnswered)
            Text(
              typedCorrect
                  ? '✅ Correct'
                  : '❌ Incorrect (bonne réponse: ${question.correctAnswer})',
            ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(
    String option,
    HangulTestQuestion question,
    bool isAnswered,
  ) {
    final bool isSelected = _selectedAnswer == option;
    final bool isCorrect = option == question.correctAnswer;
    final bool shouldShowCorrect = isAnswered && isCorrect;
    final bool shouldShowIncorrect = isAnswered && isSelected && !isCorrect;

    Color? backgroundColor;
    if (shouldShowCorrect) {
      backgroundColor = Colors.green.withOpacity(0.2);
    } else if (shouldShowIncorrect) {
      backgroundColor = Colors.red.withOpacity(0.2);
    }

    return OutlinedButton(
      onPressed: isAnswered ? null : () => _answerQuestion(option),
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: backgroundColor,
        side: BorderSide(
          color: shouldShowCorrect
              ? Colors.green
              : shouldShowIncorrect
              ? Colors.red
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Text(
        option,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _typeLabel(HangulExerciseType type) {
    switch (type) {
      case HangulExerciseType.qcmReading:
        return 'QCM lecture';
      case HangulExerciseType.syllableComposition:
        return 'Construire syllabe';
      case HangulExerciseType.audioRecognition:
        return 'Reconnaissance audio';
      case HangulExerciseType.romanizationToHangul:
        return 'Romanisation → Hangul';
      case HangulExerciseType.hangulToRomanization:
        return 'Hangul → Romanisation';
      case HangulExerciseType.keyboardWriting:
        return 'Écriture clavier';
      case HangulExerciseType.dragDropComposition:
        return 'Drag & drop';
    }
  }
}

String _normalize(String value) {
  if (!value.contains('/')) {
    return value.trim().toLowerCase();
  }
  return value.split('/').first.trim().toLowerCase();
}

class HangulTestQuestion {
  const HangulTestQuestion({
    required this.id,
    required this.exerciseType,
    required this.stageLabel,
    required this.prompt,
    required this.displayValue,
    required this.correctAnswer,
    required this.options,
    this.requiresTextInput = false,
  });

  final String id;
  final HangulExerciseType exerciseType;
  final String stageLabel;
  final String prompt;
  final String displayValue;
  final String correctAnswer;
  final List<String> options;
  final bool requiresTextInput;
}

class HangulTestResultScreen extends ConsumerWidget {
  const HangulTestResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HangulSessionState state = ref.watch(hangulViewModelProvider);
    final double score = state.getTestScore();
    final String percentage = (score * 100).toStringAsFixed(0);
    final int total = state.testResults.length;
    final int correct = state.testResults.values.where((bool v) => v).length;
    final int totalPoints = total * 10;
    final int correctPoints = correct * 10;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String scoreKey = state.trainingMode
          ? 'hangul_training'
          : 'hangul_core';
      ref
          .read(hangulProgressViewModelProvider.notifier)
          .saveCategoryScore(scoreKey, score);

      final Set<String> letterIds = state.selectedLetters
          .map((HangulLetter letter) => letter.id)
          .toSet();
      ref
          .read(hangulProgressViewModelProvider.notifier)
          .addLearnedLetters(letterIds);

      if (score >= 0.8) {
        ref
            .read(hangulProgressViewModelProvider.notifier)
            .markCategoryCompleted(scoreKey);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats du test'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$percentage%',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '$correctPoints/$totalPoints points',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text('$correct/$total réponses correctes'),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  ref.read(hangulViewModelProvider.notifier).resetSession();
                  Navigator.of(
                    context,
                  ).popUntil((Route<dynamic> route) => route.isFirst);
                },
                icon: const Icon(Icons.home),
                label: const Text('Retour aux cours'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
