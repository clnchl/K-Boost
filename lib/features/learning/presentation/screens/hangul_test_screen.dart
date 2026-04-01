import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';
import '../viewmodels/hangul_progress_viewmodel.dart';
import '../viewmodels/hangul_viewmodel.dart';

List<HangulLetter> _flattenAllHangulLetters() => hangulCategoriesData
    .expand((HangulCategory category) => category.letters)
    .toList(growable: false);

String _hangulFamilyOf(HangulLetter letter) {
  if (letter.category.startsWith('vowel')) {
    return 'vowel';
  }
  if (letter.category.startsWith('consonant')) {
    return 'consonant';
  }
  return letter.category;
}

List<HangulLetter> _sameFamilyLetters(HangulLetter letter) {
  final String family = _hangulFamilyOf(letter);
  return _flattenAllHangulLetters()
      .where((HangulLetter other) => _hangulFamilyOf(other) == family)
      .toList(growable: false);
}

class HangulTestScreen extends ConsumerStatefulWidget {
  const HangulTestScreen({super.key});

  @override
  ConsumerState<HangulTestScreen> createState() => _HangulTestScreenState();
}

class _HangulTestScreenState extends ConsumerState<HangulTestScreen> {
  late List<HangulTestQuestion> _questions;
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    final state = ref.read(hangulViewModelProvider);
    final letters = state.selectedLetters;

    _questions = <HangulTestQuestion>[];

    // Générer deux types de questions
    for (int i = 0; i < letters.length; i++) {
      final letter = letters[i];
      final List<HangulLetter> familyPool = _sameFamilyLetters(letter);

      // Question type 1: Afficher la lettre, demander la romanisation
      _questions.add(
        HangulTestQuestion(
          id: '${letter.id}_1',
          type: HangulTestType.recognitionToRomanization,
          correctLetter: letter,
          correctAnswer: letter.romanization,
          options: _generateOptions(
            correct: letter.romanization,
            allLetters: familyPool,
            isRomanization: true,
          ),
        ),
      );

      // Question type 2: Afficher la romanisation, demander la lettre
      _questions.add(
        HangulTestQuestion(
          id: '${letter.id}_2',
          type: HangulTestType.romanizationToRecognition,
          correctLetter: letter,
          correctAnswer: letter.character,
          options: _generateOptions(
            correct: letter.character,
            allLetters: familyPool,
            isRomanization: false,
          ),
        ),
      );
    }

    // Mélanger les questions
    _questions.shuffle();
  }

  List<String> _generateOptions({
    required String correct,
    required List<HangulLetter> allLetters,
    required bool isRomanization,
  }) {
    final Set<String> options = <String>{correct};

    final List<String> pool = allLetters
        .map(
          (HangulLetter letter) =>
              isRomanization ? letter.romanization : letter.character,
        )
        .where((String option) => option != correct)
        .toSet()
        .toList();
    pool.shuffle();

    for (final String option in pool) {
      if (options.length >= 4) break;
      options.add(option);
    }

    if (options.length < 4) {
      final List<String> fallback = isRomanization
          ? <String>[
              'a',
              'eo',
              'o',
              'u',
              'ya',
              'yo',
              'yu',
              'eu',
              'i',
              'wa',
              'we',
              'wi',
            ]
          : <String>[
              'ㄱ',
              'ㄴ',
              'ㄷ',
              'ㄹ',
              'ㅁ',
              'ㅂ',
              'ㅅ',
              'ㅇ',
              'ㅈ',
              'ㅊ',
              'ㅋ',
              'ㅌ',
              'ㅍ',
              'ㅎ',
              'ㅏ',
              'ㅗ',
              'ㅜ',
              'ㅡ',
              'ㅣ',
            ];

      for (final String option in fallback) {
        if (options.length >= 4) break;
        if (option != correct) {
          options.add(option);
        }
      }
    }

    final List<String> optionsList = options.toList();
    optionsList.shuffle();

    if (!optionsList.contains(correct)) {
      optionsList[0] = correct;
      optionsList.shuffle();
    }

    return optionsList.take(4).toList();
  }

  void _answerQuestion(String answer) {
    final question = _questions[_currentQuestionIndex];
    final isCorrect = answer == question.correctAnswer;

    // Enregistrer la réponse
    ref
        .read(hangulViewModelProvider.notifier)
        .recordTestAnswer(question.correctLetter.id, isCorrect);

    setState(() {
      _selectedAnswer = answer;
    });

    // Afficher le feedback et avancer
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedAnswer = null;
          });
        } else {
          // Test terminé
          ref.read(hangulViewModelProvider.notifier).endTest();
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const HangulTestResultScreen(),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final isAnswered = _selectedAnswer != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Test Hangul'), centerTitle: false),
      body: Column(
        children: <Widget>[
          // Barre de progression
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Question ${_currentQuestionIndex + 1} / ${_questions.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      _getQuestionTypeLabel(question.type),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _questions.length,
                ),
              ],
            ),
          ),
          // Contenu du test
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Question
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _getQuestionText(question.type),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 24),
                      _buildQuestionContent(question),
                    ],
                  ),
                ),
                // Options
                Expanded(
                  child: Padding(
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
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent(HangulTestQuestion question) {
    if (question.type == HangulTestType.recognitionToRomanization) {
      // Afficher la lettre, demander la prononciation
      return Text(
        question.correctLetter.character,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: 100,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      // Afficher la prononciation, demander la lettre
      return Text(
        question.correctLetter.romanization,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      );
    }
  }

  String _getQuestionText(HangulTestType type) {
    if (type == HangulTestType.recognitionToRomanization) {
      return 'Quelle est la prononciation ?';
    } else {
      return 'Quelle est la lettre ?';
    }
  }

  Widget _buildOptionButton(
    String option,
    HangulTestQuestion question,
    bool isAnswered,
  ) {
    final isSelected = _selectedAnswer == option;
    final isCorrect = option == question.correctAnswer;
    final shouldShowCorrect = isAnswered && isCorrect;
    final shouldShowIncorrect = isAnswered && isSelected && !isCorrect;

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

  String _getQuestionTypeLabel(HangulTestType type) {
    return type == HangulTestType.recognitionToRomanization
        ? 'Lettre → Prononciation'
        : 'Prononciation → Lettre';
  }
}

// Classe pour les questions de test
class HangulTestQuestion {
  const HangulTestQuestion({
    required this.id,
    required this.type,
    required this.correctLetter,
    required this.correctAnswer,
    required this.options,
  });

  final String id;
  final HangulTestType type;
  final HangulLetter correctLetter;
  final String correctAnswer;
  final List<String> options;
}

// Types de questions
enum HangulTestType {
  recognitionToRomanization, // Lettre → Prononciation
  romanizationToRecognition, // Prononciation → Lettre
}

// Écran de résultats
class HangulTestResultScreen extends ConsumerWidget {
  const HangulTestResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hangulViewModelProvider);
    final score = state.getTestScore();
    final percentage = (score * 100).toStringAsFixed(0);
    final total = state.testResults.length;
    final correct = state.testResults.values.where((bool v) => v).length;

    // Calcul des points: 10 points par bonne réponse
    final totalPoints = total * 10;
    final correctPoints = correct * 10;

    // Sauvegarder la progression
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.selectedCategory != null) {
        // Sauvegarder le score
        ref
            .read(hangulProgressViewModelProvider.notifier)
            .saveCategoryScore(state.selectedCategory!.id, score);

        // Sauvegarder les lettres apprises
        final letterIds = state.selectedLetters
            .map((HangulLetter l) => l.id)
            .toSet();
        ref
            .read(hangulProgressViewModelProvider.notifier)
            .addLearnedLetters(letterIds);

        // Marquer comme complétée si score >= 80%
        if (score >= 0.8) {
          ref
              .read(hangulProgressViewModelProvider.notifier)
              .markCategoryCompleted(state.selectedCategory!.id);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats du test'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Score circulaire
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: score >= 0.8
                    ? Colors.green.withOpacity(0.2)
                    : score >= 0.6
                    ? Colors.orange.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$percentage%',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: score >= 0.8
                                ? Colors.green
                                : score >= 0.6
                                ? Colors.orange
                                : Colors.red,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$correctPoints/$totalPoints',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: score >= 0.8
                                ? Colors.green
                                : score >= 0.6
                                ? Colors.orange
                                : Colors.red,
                          ),
                    ),
                    Text(
                      'points obtenus',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Feedback
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _getFeedback(score),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getDetailedFeedback(state),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Boutons d'action
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                  const SizedBox(height: 12),
                  if (score < 0.8)
                    OutlinedButton.icon(
                      onPressed: () {
                        ref
                            .read(hangulViewModelProvider.notifier)
                            .resetSession();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.repeat),
                      label: const Text('Réapprendre cette catégorie'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFeedback(double score) {
    if (score >= 0.9) {
      return '🎉 Excellent ! Vous maîtrisez parfaitement !';
    } else if (score >= 0.8) {
      return '✅ Très bien ! Continuez ainsi !';
    } else if (score >= 0.6) {
      return '👍 Pas mal ! Révisez et réessayez !';
    } else {
      return '📚 À revoir - Prenez le temps d\'apprendre !';
    }
  }

  String _getDetailedFeedback(HangulSessionState state) {
    final total = state.testResults.length;
    final correct = state.testResults.values.where((bool v) => v).length;
    final totalPoints = total * 10;
    final correctPoints = correct * 10;

    return 'Vous avez obtenu $correctPoints/$totalPoints points ($correct/$total réponses correctes).';
  }
}
