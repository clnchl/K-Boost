import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';
import '../viewmodels/hangul_viewmodel.dart';
import 'hangul_test_screen.dart';

class HangulLearningScreen extends ConsumerStatefulWidget {
  const HangulLearningScreen({super.key});

  @override
  ConsumerState<HangulLearningScreen> createState() =>
      _HangulLearningScreenState();
}

class _HangulLearningScreenState extends ConsumerState<HangulLearningScreen> {
  static const List<_StructureLessonPage>
  _structurePages = <_StructureLessonPage>[
    _StructureLessonPage(
      title: 'Principe général',
      content:
          'En Hangul, les lettres se regroupent en blocs syllabiques carrés, au lieu d\'être écrites simplement à la suite.',
    ),
    _StructureLessonPage(
      title: 'Structure de base',
      content: 'Dans ce premier module, une syllabe suit : Consonne + Voyelle.',
      examples: <String>['가 = ㄱ + ㅏ → ga', '나 = ㄴ + ㅏ → na'],
    ),
    _StructureLessonPage(
      title: 'Consonne initiale',
      content:
          'La consonne initiale est obligatoire. Elle commence toujours le bloc syllabique.',
      examples: <String>['Exemples : ㄱ, ㄴ, ㄷ, ㅁ'],
    ),
    _StructureLessonPage(
      title: 'Voyelle et forme du bloc',
      content:
          'La voyelle est obligatoire et détermine l\'organisation visuelle du bloc.',
      examples: <String>[
        'Voyelles verticales (ㅏ, ㅓ, ㅣ) : écriture gauche → droite (가)',
        'Voyelles horizontales (ㅗ, ㅜ, ㅡ) : écriture haut → bas (고)',
      ],
    ),
    _StructureLessonPage(
      title: 'Exemple complet',
      content: 'Voici deux blocs simples sans consonne finale.',
      examples: <String>[
        '가 = ㄱ + ㅏ',
        '고 = ㄱ + ㅗ',
        'Résumé : 1 consonne + 1 voyelle = 1 bloc',
      ],
    ),
  ];

  final List<int> _sectionIndices = <int>[0, 0, 0, 0, 0];

  bool _isVowelModule(HangulSessionState state) {
    return state.courseFocus == HangulCourseFocus.vowels ||
        state.courseFocus == HangulCourseFocus.vowelsAdvanced;
  }

  bool _isConsonantModule(HangulSessionState state) {
    return state.courseFocus == HangulCourseFocus.consonants ||
        state.courseFocus == HangulCourseFocus.consonantsAdvanced;
  }

  bool _shouldShowTest(HangulSessionState state) {
    return state.courseFocus != HangulCourseFocus.structure;
  }

  int _maxStep(HangulSessionState state) {
    return _shouldShowTest(state) ? 4 : 3;
  }

  List<String> _titles(HangulSessionState state) {
    if (_isVowelModule(state)) {
      return <String>[
        '1. Voyelles du module',
        '2. Construction avec ㅇ',
        '3. Lecture des syllabes',
        '4. Récap voyelles',
        '5. Test',
      ];
    }

    if (_isConsonantModule(state)) {
      return <String>[
        '1. Consonnes du module',
        '2. Construction avec voyelle de support',
        '3. Lecture des syllabes',
        '4. Récap consonnes',
        '5. Test',
      ];
    }

    final List<String> base = <String>[
      '1. Structure des syllabes',
      '2. Voyelles',
      '3. Construction',
      '4. Lecture',
    ];
    if (_shouldShowTest(state)) {
      return <String>[...base, '5. Test'];
    }
    return base;
  }

  int _currentSectionItemCount(HangulSessionState state, int step) {
    if (_isVowelModule(state)) {
      switch (step) {
        case 0:
          return state.selectedVowels.isEmpty ? 1 : state.selectedVowels.length;
        case 1:
          return state.generatedSyllables.isEmpty
              ? 1
              : state.generatedSyllables.length;
        case 2:
          return state.generatedSyllables.isEmpty
              ? 1
              : state.generatedSyllables.length < 5
              ? state.generatedSyllables.length
              : 5;
        case 3:
        case 4:
          return 1;
        default:
          return 1;
      }
    }

    if (_isConsonantModule(state)) {
      switch (step) {
        case 0:
          return state.selectedConsonants.isEmpty
              ? 1
              : state.selectedConsonants.length;
        case 1:
          return state.generatedSyllables.isEmpty
              ? 1
              : state.generatedSyllables.length;
        case 2:
          return state.generatedSyllables.isEmpty
              ? 1
              : state.generatedSyllables.length < 5
              ? state.generatedSyllables.length
              : 5;
        case 3:
        case 4:
          return 1;
        default:
          return 1;
      }
    }

    switch (step) {
      case 0:
        return _structurePages.length;
      case 1:
        return state.selectedVowels.isEmpty ? 1 : state.selectedVowels.length;
      case 2:
        return state.generatedSyllables.isEmpty
            ? 1
            : state.generatedSyllables.length;
      case 3:
        return state.generatedSyllables.isEmpty
            ? 1
            : state.generatedSyllables.length < 5
            ? state.generatedSyllables.length
            : 5;
      case 4:
        return 1;
      default:
        return 1;
    }
  }

  int _itemIndexForStep(HangulSessionState state, int step) {
    final int count = _currentSectionItemCount(state, step);
    final int index = _sectionIndices[step];
    return index.clamp(0, count - 1).toInt();
  }

  void _setItemIndex(int step, int value, HangulSessionState state) {
    final int count = _currentSectionItemCount(state, step);
    setState(() {
      _sectionIndices[step] = value.clamp(0, count - 1).toInt();
    });
  }

  void _previous(HangulSessionState state) {
    final int step = state.currentIndex.clamp(0, _maxStep(state)).toInt();
    final int itemIndex = _itemIndexForStep(state, step);

    if (itemIndex > 0) {
      _setItemIndex(step, itemIndex - 1, state);
      return;
    }

    if (step > 0) {
      final int previousStep = step - 1;
      ref.read(hangulViewModelProvider.notifier).previousLessonStep();
      _setItemIndex(
        previousStep,
        _currentSectionItemCount(state, previousStep) - 1,
        state,
      );
    }
  }

  void _next(HangulSessionState state) {
    final int maxStep = _maxStep(state);
    final int step = state.currentIndex.clamp(0, maxStep).toInt();
    final int itemIndex = _itemIndexForStep(state, step);
    final int itemCount = _currentSectionItemCount(state, step);

    if (itemIndex < itemCount - 1) {
      _setItemIndex(step, itemIndex + 1, state);
      return;
    }

    if (step < maxStep) {
      ref.read(hangulViewModelProvider.notifier).nextLessonStep();
      final int nextStep = step + 1;
      if (_sectionIndices[nextStep] >=
          _currentSectionItemCount(state, nextStep)) {
        _setItemIndex(nextStep, 0, state);
      }
      return;
    }

    if (_shouldShowTest(state)) {
      ref.read(hangulViewModelProvider.notifier).startTest();
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => const HangulTestScreen()));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Cours terminé. Bravo !')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hangulViewModelProvider);

    if (state.selectedLetters.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Module Hangul')),
        body: const Center(child: Text('Aucune session active')),
      );
    }

    final int maxStep = _maxStep(state);
    final int step = state.currentIndex.clamp(0, maxStep).toInt();
    final List<String> titles = _titles(state);
    final int itemIndex = _itemIndexForStep(state, step);
    final int itemCount = _currentSectionItemCount(state, step);

    return Scaffold(
      appBar: AppBar(title: const Text('Leçon Hangul')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(titles[step], style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (step + 1) / titles.length),
            const SizedBox(height: 8),
            Text(
              'Étape ${step + 1}/${titles.length} • Élément ${itemIndex + 1}/$itemCount',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildStepContent(context, state, step)),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: step > 0 || itemIndex > 0
                        ? () => _previous(state)
                        : null,
                    child: const Text('Précédent'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => _next(state),
                    child: Text(
                      step < maxStep || itemIndex < itemCount - 1
                          ? 'Suivant'
                          : _shouldShowTest(state)
                          ? 'Lancer le test'
                          : 'Terminer',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    HangulSessionState state,
    int step,
  ) {
    if (_isVowelModule(state)) {
      switch (step) {
        case 0:
          final HangulLetter vowel =
              state.selectedVowels[_itemIndexForStep(state, 0)];
          return _LessonCard(
            headline: vowel.character,
            subtitle: vowel.romanization,
            description:
                'Concentrez-vous sur le son de cette voyelle avant de passer à la suivante.',
            chips: <Widget>[Chip(label: Text(vowel.character))],
          );
        case 1:
          final HangulSyllable syllable =
              state.generatedSyllables[_itemIndexForStep(state, 1)];
          return _LessonCard(
            headline: syllable.character,
            subtitle: syllable.romanization,
            description:
                'Ici ㅇ sert de support pour prononcer la voyelle : ${syllable.character} = ㅇ + ${syllable.vowel.character}.',
            chips: <Widget>[
              Chip(label: Text('ㅇ')),
              Chip(label: Text(syllable.vowel.character)),
            ],
          );
        case 2:
          final HangulSyllable syllable =
              state.generatedSyllables[_itemIndexForStep(state, 2)];
          return _LessonCard(
            headline: syllable.character,
            subtitle: syllable.romanization,
            description:
                'Lisez cette syllabe à voix haute pour automatiser la lecture des voyelles.',
            chips: <Widget>[Chip(label: Text(syllable.character))],
          );
        case 3:
          return _LessonCard(
            headline: '${state.selectedVowels.length}',
            subtitle: 'voyelles vues',
            description:
                'Vous avez vu les voyelles du module avec leurs formes syllabiques.',
            chips: state.selectedVowels
                .take(6)
                .map(
                  (HangulLetter letter) => Chip(label: Text(letter.character)),
                )
                .toList(growable: false),
          );
        case 4:
          return _LessonCard(
            headline: state.trainingMode ? '50' : '5',
            subtitle: state.trainingMode ? 'entraînement' : 'questions',
            description: 'Test de fin du module voyelles.',
            chips: const <Widget>[],
          );
        default:
          return const SizedBox.shrink();
      }
    }

    if (_isConsonantModule(state)) {
      switch (step) {
        case 0:
          final HangulLetter consonant =
              state.selectedConsonants[_itemIndexForStep(state, 0)];
          return _LessonCard(
            headline: consonant.character,
            subtitle: consonant.romanization,
            description:
                'Concentrez-vous sur cette consonne et sa romanisation avant de continuer.',
            chips: <Widget>[Chip(label: Text(consonant.character))],
          );
        case 1:
          final HangulSyllable syllable =
              state.generatedSyllables[_itemIndexForStep(state, 1)];
          return _LessonCard(
            headline: syllable.character,
            subtitle: syllable.romanization,
            description:
                'La consonne est placée avec une voyelle de support : ${syllable.character} = ${syllable.consonant.character} + ${syllable.vowel.character}.',
            chips: <Widget>[
              Chip(label: Text(syllable.consonant.character)),
              Chip(label: Text(syllable.vowel.character)),
            ],
          );
        case 2:
          final HangulSyllable syllable =
              state.generatedSyllables[_itemIndexForStep(state, 2)];
          return _LessonCard(
            headline: syllable.character,
            subtitle: syllable.romanization,
            description:
                'Lisez cette syllabe pour renforcer la lecture des consonnes du module.',
            chips: <Widget>[Chip(label: Text(syllable.character))],
          );
        case 3:
          return _LessonCard(
            headline: '${state.selectedConsonants.length}',
            subtitle: 'consonnes vues',
            description:
                'Vous avez vu les consonnes du module avec une voyelle de support.',
            chips: state.selectedConsonants
                .take(6)
                .map(
                  (HangulLetter letter) => Chip(label: Text(letter.character)),
                )
                .toList(growable: false),
          );
        case 4:
          return _LessonCard(
            headline: state.trainingMode ? '50' : '5',
            subtitle: state.trainingMode ? 'entraînement' : 'questions',
            description: 'Test de fin du module consonnes.',
            chips: const <Widget>[],
          );
        default:
          return const SizedBox.shrink();
      }
    }

    switch (step) {
      case 0:
        final _StructureLessonPage page =
            _structurePages[_itemIndexForStep(state, 0)];
        return _StructureLessonCard(
          title: page.title,
          content: page.content,
          examples: page.examples,
        );
      case 1:
        final HangulLetter vowel =
            state.selectedVowels[_itemIndexForStep(state, 1)];
        return _LessonCard(
          headline: vowel.character,
          subtitle: vowel.romanization,
          description:
              'Prenez chaque voyelle séparément pour mieux la mémoriser.',
          chips: <Widget>[Chip(label: Text(vowel.character))],
        );
      case 2:
        final HangulSyllable syllable =
            state.generatedSyllables[_itemIndexForStep(state, 2)];
        return _LessonCard(
          headline: syllable.character,
          subtitle: syllable.romanization,
          description:
              '${syllable.consonant.character} + ${syllable.vowel.character} → ${syllable.character}',
          chips: <Widget>[
            Chip(label: Text(syllable.consonant.character)),
            Chip(label: Text(syllable.vowel.character)),
          ],
        );
      case 3:
        final HangulSyllable syllable =
            state.generatedSyllables[_itemIndexForStep(state, 3)];
        return _LessonCard(
          headline: syllable.character,
          subtitle: syllable.romanization,
          description:
              'Lisez cette syllabe à voix haute avant de passer à la suivante.',
          chips: <Widget>[Chip(label: Text(syllable.character))],
        );
      case 4:
        return _LessonCard(
          headline: state.trainingMode ? '50' : '5',
          subtitle: state.trainingMode ? 'entraînement' : 'questions',
          description: state.trainingMode
              ? 'Test d\'entraînement avec feedback immédiat.'
              : 'Test de fin de module avec feedback immédiat.',
          chips: const <Widget>[],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _StructureLessonPage {
  const _StructureLessonPage({
    required this.title,
    required this.content,
    this.examples = const <String>[],
  });

  final String title;
  final String content;
  final List<String> examples;
}

class _StructureLessonCard extends StatelessWidget {
  const _StructureLessonCard({
    required this.title,
    required this.content,
    required this.examples,
  });

  final String title;
  final String content;
  final List<String> examples;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF4F8FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
            if (examples.isNotEmpty) ...<Widget>[
              const SizedBox(height: 12),
              ...examples.map(
                (String example) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('• $example'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.headline,
    required this.subtitle,
    required this.description,
    required this.chips,
  });

  final String headline;
  final String subtitle;
  final String description;
  final List<Widget> chips;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF4F8FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    headline,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
            if (chips.isNotEmpty) ...<Widget>[
              const SizedBox(height: 16),
              Wrap(spacing: 8, runSpacing: 8, children: chips),
            ],
          ],
        ),
      ),
    );
  }
}
