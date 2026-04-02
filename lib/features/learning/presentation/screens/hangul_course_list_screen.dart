import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/hangul_letter.dart';
import '../viewmodels/hangul_viewmodel.dart';
import 'hangul_learning_screen.dart';

class HangulCourseListScreen extends ConsumerWidget {
  const HangulCourseListScreen({super.key});

  static const List<_HangulCourseItem> _courses = <_HangulCourseItem>[
    _HangulCourseItem(
      title: '1. Structure des syllabes',
      subtitle: 'Bases de la structure',
      focus: HangulCourseFocus.structure,
      active: true,
    ),
    _HangulCourseItem(
      title: '2. Voyelles de base',
      subtitle: 'Voyelles seules et exemples associés',
      focus: HangulCourseFocus.vowels,
      active: true,
    ),
    _HangulCourseItem(
      title: '3. Consonnes de base',
      subtitle: 'Consonnes seules et exemples associés',
      focus: HangulCourseFocus.consonants,
      active: true,
    ),
    _HangulCourseItem(
      title: '4. Premières syllabes',
      subtitle: 'Construction immédiate',
      focus: HangulCourseFocus.mixed,
      active: false,
    ),
    _HangulCourseItem(
      title: '5. Premiers mots simples',
      subtitle: 'Lecture courte',
      focus: HangulCourseFocus.mixed,
      active: false,
    ),
    _HangulCourseItem(
      title: '6. Batchim (consonnes finales)',
      subtitle: 'Fin de syllabe',
      focus: HangulCourseFocus.consonantsAdvanced,
      active: false,
    ),
    _HangulCourseItem(
      title: '7. Batchim doubles',
      subtitle: 'Cas plus avancés',
      focus: HangulCourseFocus.consonantsAdvanced,
      active: false,
    ),
    _HangulCourseItem(
      title: '8. Règles de liaison',
      subtitle: 'Enchaînement des sons',
      focus: HangulCourseFocus.mixed,
      active: false,
    ),
    _HangulCourseItem(
      title: '9. Assimilations de prononciation',
      subtitle: 'Prononciation réelle',
      focus: HangulCourseFocus.mixed,
      active: false,
    ),
    _HangulCourseItem(
      title: '10. Voyelles composées',
      subtitle: 'ㅘ, ㅚ, ㅢ...',
      focus: HangulCourseFocus.vowelsAdvanced,
      active: false,
    ),
    _HangulCourseItem(
      title: '11. Consonnes doubles',
      subtitle: 'ㄲ, ㄸ, ㅃ...',
      focus: HangulCourseFocus.consonantsAdvanced,
      active: false,
    ),
    _HangulCourseItem(
      title: '12. Mots plus complexes',
      subtitle: 'Lecture plus longue',
      focus: HangulCourseFocus.mixed,
      active: false,
    ),
    _HangulCourseItem(
      title: '13. Phrases simples',
      subtitle: 'Compréhension de base',
      focus: HangulCourseFocus.mixed,
      active: false,
    ),
  ];

  Future<void> _openCourseSetup(
    BuildContext context,
    WidgetRef ref,
    _HangulCourseItem item,
  ) async {
    final _HangulCourseConfig? config =
        await showModalBottomSheet<_HangulCourseConfig>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _HangulCourseSetupSheet(
            courseTitle: item.title,
            courseSubtitle: item.subtitle,
            courseFocus: item.focus,
          ),
        );

    if (config == null || !context.mounted) {
      return;
    }

    ref
        .read(hangulViewModelProvider.notifier)
        .configureSession(
          letterCount: config.letterCount,
          trainingMode: false,
          selectedExerciseTypes: HangulExerciseType.values,
          courseFocus: item.focus,
        );

    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HangulLearningScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8EF),
      appBar: AppBar(title: const Text('Cours Hangul'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: <Widget>[
          Card(
            elevation: 0,
            color: Colors.white.withOpacity(0.75),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Alphabet Hangul',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Apprenez les bases du Hangul',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._courses.map(
            (_HangulCourseItem course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _HangulCourseCard(
                item: course,
                onTap: course.active
                    ? () => _openCourseSetup(context, ref, course)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HangulCourseItem {
  const _HangulCourseItem({
    required this.title,
    required this.subtitle,
    required this.focus,
    required this.active,
  });

  final String title;
  final String subtitle;
  final HangulCourseFocus focus;
  final bool active;
}

class _HangulCourseConfig {
  const _HangulCourseConfig({required this.letterCount});

  final int letterCount;
}

class _HangulCourseSetupSheet extends StatefulWidget {
  const _HangulCourseSetupSheet({
    required this.courseTitle,
    required this.courseSubtitle,
    required this.courseFocus,
  });

  final String courseTitle;
  final String courseSubtitle;
  final HangulCourseFocus courseFocus;

  @override
  State<_HangulCourseSetupSheet> createState() =>
      _HangulCourseSetupSheetState();
}

class _HangulCourseSetupSheetState extends State<_HangulCourseSetupSheet> {
  late int _selectedCount;

  @override
  void initState() {
    super.initState();
    final List<int> options = _countOptions(_relevantLetterCount());
    _selectedCount = options.isEmpty ? _relevantLetterCount() : options.first;
  }

  List<HangulLetter> _allConsonants() => hangulCategoriesData
      .expand((HangulCategory category) => category.letters)
      .where((HangulLetter letter) => letter.category.startsWith('consonant'))
      .toList(growable: false);

  List<HangulLetter> _allVowels() => hangulCategoriesData
      .expand((HangulCategory category) => category.letters)
      .where((HangulLetter letter) => letter.category.startsWith('vowel'))
      .toList(growable: false);

  List<HangulLetter> _relevantConsonants() {
    switch (widget.courseFocus) {
      case HangulCourseFocus.consonantsAdvanced:
        return _allConsonants()
            .where(
              (HangulLetter letter) => letter.category == 'consonant_advanced',
            )
            .toList(growable: false);
      case HangulCourseFocus.vowels:
      case HangulCourseFocus.vowelsAdvanced:
        return <HangulLetter>[];
      case HangulCourseFocus.structure:
      case HangulCourseFocus.consonants:
      case HangulCourseFocus.mixed:
        return _allConsonants();
    }
  }

  List<HangulLetter> _relevantVowels() {
    switch (widget.courseFocus) {
      case HangulCourseFocus.vowelsAdvanced:
        return _allVowels()
            .where((HangulLetter letter) => letter.category == 'vowel_advanced')
            .toList(growable: false);
      case HangulCourseFocus.consonants:
      case HangulCourseFocus.consonantsAdvanced:
        return <HangulLetter>[];
      case HangulCourseFocus.structure:
      case HangulCourseFocus.vowels:
      case HangulCourseFocus.mixed:
        return _allVowels();
    }
  }

  int _relevantLetterCount() =>
      _relevantConsonants().length + _relevantVowels().length;

  String _selectionUnitLabel({required bool plural}) {
    final String letter = plural ? 'lettres' : 'lettre';
    switch (widget.courseFocus) {
      case HangulCourseFocus.vowels:
      case HangulCourseFocus.vowelsAdvanced:
        return plural ? 'voyelles' : 'voyelle';
      case HangulCourseFocus.consonants:
      case HangulCourseFocus.consonantsAdvanced:
        return plural ? 'consonnes' : 'consonne';
      case HangulCourseFocus.structure:
      case HangulCourseFocus.mixed:
        return letter;
    }
  }

  String _moduleObjectiveText() {
    switch (widget.courseFocus) {
      case HangulCourseFocus.structure:
        return 'Ce module présente comment les blocs syllabiques se construisent et se lisent.';
      case HangulCourseFocus.vowels:
        return 'Ce module se concentre uniquement sur les voyelles de base avec des exemples simples.';
      case HangulCourseFocus.vowelsAdvanced:
        return 'Ce module travaille les voyelles composées et leurs sons.';
      case HangulCourseFocus.consonants:
        return 'Ce module se concentre uniquement sur les consonnes de base.';
      case HangulCourseFocus.consonantsAdvanced:
        return 'Ce module travaille les consonnes avancées (doubles et aspirées).';
      case HangulCourseFocus.mixed:
        return 'Ce module mélange consonnes et voyelles pour former des syllabes complètes.';
    }
  }

  List<int> _countOptions(int relevantTotal) {
    final List<int> base =
        widget.courseFocus == HangulCourseFocus.structure ||
            widget.courseFocus == HangulCourseFocus.mixed
        ? <int>[4, 6, 8]
        : <int>[4, 6, 8, 10, 12];

    final List<int> filtered = base
        .where((int value) => value <= relevantTotal)
        .toList(growable: false);

    if (filtered.isEmpty) {
      return <int>[relevantTotal];
    }

    return filtered;
  }

  List<HangulLetter> _selectedConsonantsForPreview() {
    final int takeCount =
        widget.courseFocus == HangulCourseFocus.structure ||
            widget.courseFocus == HangulCourseFocus.mixed
        ? _selectedCount ~/ 2
        : _selectedCount;
    return _relevantConsonants().take(takeCount).toList(growable: false);
  }

  List<HangulLetter> _selectedVowelsForPreview() {
    final int takeCount =
        widget.courseFocus == HangulCourseFocus.structure ||
            widget.courseFocus == HangulCourseFocus.mixed
        ? _selectedCount ~/ 2
        : _selectedCount;
    return _relevantVowels().take(takeCount).toList(growable: false);
  }

  String _normalizeRomanization(String value) {
    if (!value.contains('/')) {
      return value;
    }
    return value.split('/').first;
  }

  List<HangulSyllable> _previewSyllables(int count) {
    final List<HangulLetter> consonants = _relevantConsonants();
    final List<HangulLetter> vowels = _relevantVowels();

    if (widget.courseFocus == HangulCourseFocus.vowels ||
        widget.courseFocus == HangulCourseFocus.vowelsAdvanced) {
      final HangulLetter supportConsonant = _allConsonants().firstWhere(
        (HangulLetter letter) => letter.character == 'ㅇ',
        orElse: () => _allConsonants().first,
      );
      return vowels
          .take(count)
          .map(
            (HangulLetter vowel) => HangulSyllable(
              consonant: supportConsonant,
              vowel: vowel,
              character: composeHangulSyllable(
                supportConsonant.character,
                vowel.character,
              ),
              romanization:
                  _normalizeRomanization(supportConsonant.romanization) +
                  vowel.romanization,
            ),
          )
          .toList(growable: false);
    }

    if (widget.courseFocus == HangulCourseFocus.consonants ||
        widget.courseFocus == HangulCourseFocus.consonantsAdvanced) {
      final HangulLetter supportVowel = _allVowels().first;
      return consonants
          .take(count)
          .map(
            (HangulLetter consonant) => HangulSyllable(
              consonant: consonant,
              vowel: supportVowel,
              character: composeHangulSyllable(
                consonant.character,
                supportVowel.character,
              ),
              romanization:
                  _normalizeRomanization(consonant.romanization) +
                  supportVowel.romanization,
            ),
          )
          .toList(growable: false);
    }

    final int pairCount = count ~/ 2;
    final List<HangulLetter> selectedConsonants = consonants
        .take(pairCount)
        .toList(growable: false);
    final List<HangulLetter> selectedVowels = vowels
        .take(pairCount)
        .toList(growable: false);

    final List<HangulSyllable> preview = <HangulSyllable>[];
    for (final HangulLetter consonant in selectedConsonants) {
      for (final HangulLetter vowel in selectedVowels) {
        preview.add(
          HangulSyllable(
            consonant: consonant,
            vowel: vowel,
            character: composeHangulSyllable(
              consonant.character,
              vowel.character,
            ),
            romanization:
                _normalizeRomanization(consonant.romanization) +
                vowel.romanization,
          ),
        );
      }
    }
    return preview;
  }

  String _summaryText(int count) {
    final int relevantCount = _relevantLetterCount();
    if (count >= relevantCount) {
      if (widget.courseFocus == HangulCourseFocus.vowels ||
          widget.courseFocus == HangulCourseFocus.vowelsAdvanced) {
        return 'Toutes les voyelles du module : $relevantCount voyelles';
      }
      if (widget.courseFocus == HangulCourseFocus.consonants ||
          widget.courseFocus == HangulCourseFocus.consonantsAdvanced) {
        return 'Toutes les consonnes du module : $relevantCount consonnes';
      }
      return 'Tout le module : ${_allConsonants().length} consonnes + ${_allVowels().length} voyelles';
    }

    if (widget.courseFocus == HangulCourseFocus.vowels ||
        widget.courseFocus == HangulCourseFocus.vowelsAdvanced) {
      return '$count voyelles du module';
    }
    if (widget.courseFocus == HangulCourseFocus.consonants ||
        widget.courseFocus == HangulCourseFocus.consonantsAdvanced) {
      return '$count consonnes du module';
    }

    final int pairCount = count ~/ 2;
    return '$count lettres = $pairCount consonnes + $pairCount voyelles';
  }

  @override
  Widget build(BuildContext context) {
    final int relevantTotal = _relevantLetterCount();
    final List<int> countOptions = _countOptions(relevantTotal);
    if (_selectedCount > relevantTotal) {
      _selectedCount = relevantTotal;
    }
    final List<HangulSyllable> preview = _previewSyllables(_selectedCount);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FractionallySizedBox(
          heightFactor: 0.92,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.courseTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.courseSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 0,
                    color: const Color(0xFFF4F8FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(_moduleObjectiveText()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Choisissez le nombre de ${_selectionUnitLabel(plural: true)} à apprendre',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      ...countOptions.map((int count) {
                        return ChoiceChip(
                          label: Text(
                            '$count ${_selectionUnitLabel(plural: true)}',
                          ),
                          selected: _selectedCount == count,
                          onSelected: (_) {
                            setState(() {
                              _selectedCount = count;
                            });
                          },
                        );
                      }),
                      ChoiceChip(
                        label: Text(
                          widget.courseFocus == HangulCourseFocus.vowels ||
                                  widget.courseFocus ==
                                      HangulCourseFocus.vowelsAdvanced
                              ? 'Toutes les voyelles'
                              : widget.courseFocus ==
                                        HangulCourseFocus.consonants ||
                                    widget.courseFocus ==
                                        HangulCourseFocus.consonantsAdvanced
                              ? 'Toutes les consonnes du module'
                              : 'Tout l\'alphabet',
                        ),
                        selected: _selectedCount >= relevantTotal,
                        onSelected: (_) {
                          setState(() {
                            _selectedCount = relevantTotal;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 0,
                        color: const Color(0xFFF4F8FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Aperçu du cours',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _summaryText(_selectedCount),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.courseFocus ==
                                            HangulCourseFocus.vowels ||
                                        widget.courseFocus ==
                                            HangulCourseFocus.vowelsAdvanced
                                    ? 'Voyelles sélectionnées'
                                    : widget.courseFocus ==
                                              HangulCourseFocus.consonants ||
                                          widget.courseFocus ==
                                              HangulCourseFocus
                                                  .consonantsAdvanced
                                    ? 'Consonnes sélectionnées'
                                    : 'Consonnes / voyelles sélectionnées',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: <Widget>[
                                  ..._selectedConsonantsForPreview().map(
                                    (HangulLetter letter) =>
                                        Chip(label: Text(letter.character)),
                                  ),
                                  ..._selectedVowelsForPreview().map(
                                    (HangulLetter letter) =>
                                        Chip(label: Text(letter.character)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.courseFocus ==
                                            HangulCourseFocus.vowels ||
                                        widget.courseFocus ==
                                            HangulCourseFocus.vowelsAdvanced
                                    ? 'Exemples de voyelles en syllabes'
                                    : widget.courseFocus ==
                                              HangulCourseFocus.consonants ||
                                          widget.courseFocus ==
                                              HangulCourseFocus
                                                  .consonantsAdvanced
                                    ? 'Exemples de consonnes en syllabes'
                                    : 'Syllabes générées',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: preview
                                    .take(6)
                                    .map(
                                      (HangulSyllable syllable) => Chip(
                                        backgroundColor: const Color(
                                          0xFFE8F2FF,
                                        ),
                                        label: Text(
                                          '${syllable.character} (${syllable.romanization})',
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop(_HangulCourseConfig(letterCount: _selectedCount));
                    },
                    child: const Text('Commencer le cours'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HangulCourseCard extends StatelessWidget {
  const _HangulCourseCard({required this.item, required this.onTap});

  final _HangulCourseItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool active = item.active;
    final Color primary = const Color(0xFF2D95F2);
    final Color bg = active ? primary : Colors.white;
    final Color borderColor = active ? primary : const Color(0xFFBFDDFB);
    final Color textColor = active ? Colors.white : const Color(0xFF262626);
    final Color subtitleColor = active ? Colors.white70 : Colors.black54;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: borderColor, width: 1.4),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(active ? 0.08 : 0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: active
                      ? Colors.white.withOpacity(0.14)
                      : const Color(0xFFF2F7FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  active ? Icons.language_rounded : Icons.lock_outline_rounded,
                  color: active ? Colors.white : primary,
                  size: 38,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: subtitleColor),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: active
                                ? Colors.white.withOpacity(0.18)
                                : const Color(0xFFE8F2FF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            active ? 'Commencer' : 'À venir',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: active ? Colors.white : primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: active ? Colors.white : primary,
                          size: 28,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
