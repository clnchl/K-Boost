import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/example_sentence.dart';
import '../../domain/entities/particle_info.dart';
import '../../domain/entities/word.dart';
import '../constants/learning_ui_text.dart';
import '../utils/word_display_mapper.dart';
import '../viewmodels/learning_providers.dart';
import '../viewmodels/word_by_id_viewmodel.dart';
import '../viewmodels/word_detail_viewmodel.dart';
import 'course_screen.dart';

class WordDetailScreen extends ConsumerStatefulWidget {
  const WordDetailScreen({super.key, required this.wordId});

  final String wordId;

  @override
  ConsumerState<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends ConsumerState<WordDetailScreen> {
  WordTense _selectedTense = WordTense.present;
  PolitenessLevel _selectedPolitenessLevel = PolitenessLevel.polite;

  static const Color _koreaBlue = Color(0xFF0C4A8A);
  static const Color _koreaRed = Color(0xFFC51F3A);
  static const Set<String> _hangulInitialOnlyConsonants = <String>{
    'ㄸ',
    'ㅃ',
    'ㅉ',
  };
  static const Map<String, String> _hangulInitialSounds = <String, String>{
    'ㄱ': 'g/k',
    'ㄲ': 'kk',
    'ㄴ': 'n',
    'ㄷ': 'd/t',
    'ㄸ': 'tt',
    'ㄹ': 'r/l',
    'ㅁ': 'm',
    'ㅂ': 'b/p',
    'ㅃ': 'pp',
    'ㅅ': 's',
    'ㅆ': 'ss',
    'ㅇ': 'muet',
    'ㅈ': 'j',
    'ㅉ': 'jj',
    'ㅊ': 'ch',
    'ㅋ': 'k',
    'ㅌ': 't',
    'ㅍ': 'p',
    'ㅎ': 'h',
  };
  static const Map<String, String> _hangulFinalSounds = <String, String>{
    'ㄱ': 'k',
    'ㄲ': 'k',
    'ㄴ': 'n',
    'ㄷ': 't',
    'ㄹ': 'l',
    'ㅁ': 'm',
    'ㅂ': 'p',
    'ㅅ': 't',
    'ㅆ': 't',
    'ㅇ': 'ng',
    'ㅈ': 't',
    'ㅊ': 't',
    'ㅋ': 'k',
    'ㅌ': 't',
    'ㅍ': 'p',
    'ㅎ': 't',
  };
  static const Map<String, String> _hangulVowelSounds = <String, String>{
    'ㅏ': 'a',
    'ㅐ': 'ae',
    'ㅑ': 'ya',
    'ㅒ': 'yae',
    'ㅓ': 'eo',
    'ㅔ': 'e',
    'ㅕ': 'yeo',
    'ㅖ': 'ye',
    'ㅗ': 'o',
    'ㅘ': 'wa',
    'ㅙ': 'wae',
    'ㅚ': 'oe/we',
    'ㅛ': 'yo',
    'ㅜ': 'u',
    'ㅝ': 'wo',
    'ㅞ': 'we',
    'ㅟ': 'wi',
    'ㅠ': 'yu',
    'ㅡ': 'eu',
    'ㅢ': 'ui',
    'ㅣ': 'i',
  };
  static const Map<String, String> _hangulNotes = <String, String>{
    'ㅇ': 'Muet en debut de syllabe, prononce ng en fin.',
    'ㄹ': 'Le son varie entre r en debut et l en fin.',
    'ㅎ': 'En fin de syllabe, le son peut s\'affaiblir selon la liaison.',
    'ㅅ': 'En fin de syllabe, le son se realise souvent comme t.',
    'ㅆ': 'En fin de syllabe, le son se realise souvent comme t.',
    'ㅈ': 'En fin de syllabe, le son se realise souvent comme t.',
    'ㅊ': 'En fin de syllabe, le son se realise souvent comme t.',
  };

  @override
  Widget build(BuildContext context) {
    final AsyncValue<WordEntity?> wordState = ref.watch(
      wordByIdViewModelProvider(widget.wordId),
    );
    final AsyncValue<List<ExampleSentenceEntity>> examplesState = ref.watch(
      wordDetailViewModelProvider(widget.wordId),
    );
    final Map<String, ParticleInfoEntity> particleInfoByForm = ref.watch(
      particleInfoByFormProvider,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: wordState.when(
        data: (WordEntity? word) {
          if (word == null) {
            return _buildPopupShell(
              child: _buildStateMessage(
                context,
                message: LearningUiText.detailWordNotFound,
                onRetry: () => ref
                    .read(wordByIdViewModelProvider(widget.wordId).notifier)
                    .loadWord(),
              ),
            );
          }

          final bool isHangul = _isHangulWord(word);
          final bool showConjugationSections = _shouldShowConjugationSections(
            word,
          );

          return _buildPopupShell(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildHeroHeader(context, word),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _SectionTitle(
                                title: LearningUiText.detailSectionWordType,
                              ),
                              const SizedBox(height: 10),
                              _Pill(
                                label: WordDisplayMapper.categoryLabel(
                                  word.category,
                                ),
                                color: _koreaBlue,
                              ),
                              const SizedBox(height: 22),
                              if (isHangul) ...<Widget>[
                                _SectionTitle(
                                  title: LearningUiText.detailSectionHangul,
                                ),
                                const SizedBox(height: 10),
                                _buildHangulDetailsCard(context, word),
                                const SizedBox(height: 22),
                              ] else ...<Widget>[
                                _SectionTitle(
                                  title: LearningUiText.detailSectionParticles,
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _particlesFromWord(word.particle)
                                      .map(
                                        (String particle) => _buildParticlePill(
                                          context,
                                          particle,
                                          _resolveParticleInfo(
                                            particle,
                                            particleInfoByForm,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 22),
                                if (showConjugationSections) ...<Widget>[
                                  _SectionTitle(
                                    title: LearningUiText.detailSectionTense,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTenseSelector(context),
                                  const SizedBox(height: 16),
                                  _SectionTitle(
                                    title:
                                        LearningUiText.detailSectionPoliteness,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildPolitenessLevelSelector(context),
                                  const SizedBox(height: 10),
                                  _buildPolitenessCard(context, word),
                                  const SizedBox(height: 22),
                                ],
                              ],
                              _SectionTitle(
                                title: LearningUiText.detailSectionDefinition,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.blueGrey.withOpacity(0.12),
                                  ),
                                ),
                                child: Text(
                                  word.definition,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(height: 1.4),
                                ),
                              ),
                              const SizedBox(height: 22),
                              _SectionTitle(
                                title: LearningUiText.detailSectionExamples,
                              ),
                              const SizedBox(height: 10),
                              ..._buildExamplesSection(
                                context,
                                ref,
                                examplesState,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildBottomActions(context, word),
              ],
            ),
          );
        },
        loading: () => _buildPopupShell(
          child: const Center(child: CircularProgressIndicator()),
        ),
        error: (Object error, StackTrace stackTrace) {
          return _buildPopupShell(
            child: _buildStateMessage(
              context,
              message: LearningUiText.detailLoadError,
              onRetry: () => ref
                  .read(wordByIdViewModelProvider(widget.wordId).notifier)
                  .loadWord(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPolitenessLevelSelector(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: PolitenessLevel.values.map((PolitenessLevel politenessLevel) {
        final bool isSelected = politenessLevel == _selectedPolitenessLevel;
        final Color accentColor = WordDisplayMapper.politenessAccentColor(
          politenessLevel,
        );

        return ChoiceChip(
          label: Text(WordDisplayMapper.politenessLabel(politenessLevel)),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedPolitenessLevel = politenessLevel;
            });
          },
          selectedColor: accentColor.withOpacity(0.16),
          backgroundColor: Colors.white,
          labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected ? accentColor : Colors.blueGrey.shade700,
            fontWeight: FontWeight.w700,
          ),
          side: BorderSide(
            color: isSelected
                ? accentColor.withOpacity(0.52)
                : Colors.blueGrey.withOpacity(0.2),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopupShell({required Widget child}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xF2FAFCFF),
                    Color(0xEEF6F9FF),
                    Color(0xEDF7F8FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.72),
                  width: 1.4,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 44,
                    offset: const Offset(0, 18),
                    color: Colors.black.withOpacity(0.22),
                  ),
                  BoxShadow(
                    blurRadius: 14,
                    offset: const Offset(0, -2),
                    color: Colors.white.withOpacity(0.45),
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -120,
                    left: -80,
                    right: -40,
                    height: 280,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topLeft,
                            radius: 0.95,
                            colors: <Color>[
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateMessage(
    BuildContext context, {
    required String message,
    required VoidCallback onRetry,
  }) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x16000000),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(message),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: onRetry,
                        child: const Text(LearningUiText.retry),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroHeader(BuildContext context, WordEntity word) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: <double>[0, 0.34, 0.62, 0.82, 1],
          colors: <Color>[
            Color(0xFF0C4A8A),
            Color(0xFF1C5A9E),
            Color(0xFF3A66A8),
            Color(0xFF7A4D94),
            Color(0xFFC51F3A),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 22),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x2AFFFFFF),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                ),
              ),
              const Spacer(),
              DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x2AFFFFFF),
                ),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(LearningUiText.detailFavoritesSoon),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.star_border_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Hero(
            tag: 'word-${word.id}',
            child: Material(
              color: Colors.transparent,
              child: Text(
                word.word,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            word.romanization,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xE5FFFFFF),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            word.translation,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xF2FFFFFF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTenseSelector(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: WordTense.values.map((WordTense tense) {
        final bool isSelected = tense == _selectedTense;
        final Color accentColor = WordDisplayMapper.tenseAccentColor(tense);

        return ChoiceChip(
          label: Text(WordDisplayMapper.tenseLabel(tense)),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedTense = tense;
            });
          },
          selectedColor: accentColor.withOpacity(0.16),
          backgroundColor: Colors.white,
          labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected ? accentColor : Colors.blueGrey.shade700,
            fontWeight: FontWeight.w700,
          ),
          side: BorderSide(
            color: isSelected
                ? accentColor.withOpacity(0.52)
                : Colors.blueGrey.withOpacity(0.2),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPolitenessCard(BuildContext context, WordEntity word) {
    final Color accentColor = WordDisplayMapper.politenessAccentColor(
      _selectedPolitenessLevel,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.28)),
      ),
      child: Text(
        _politenessForSelectedTense(word),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          height: 1.35,
          color: Colors.blueGrey.shade800,
        ),
      ),
    );
  }

  bool _isHangulWord(WordEntity word) {
    return word.theme == 'hangul';
  }

  bool _shouldShowConjugationSections(WordEntity word) {
    return _isVerbWord(word) && _hasConjugationVariation(word);
  }

  bool _isVerbWord(WordEntity word) {
    final String normalized = word.word.trim();
    return word.category == 'action' && normalized.endsWith('다');
  }

  bool _hasConjugationVariation(WordEntity word) {
    final Set<String> forms = <String>{};

    for (final Map<PolitenessLevel, String> byLevel
        in word.politenessByTense.values) {
      for (final String value in byLevel.values) {
        final String normalized = value.trim();
        if (normalized.isNotEmpty) {
          forms.add(normalized);
        }
      }
    }

    return forms.length > 1;
  }

  Widget _buildHangulDetailsCard(BuildContext context, WordEntity word) {
    final String symbol = word.word.trim();
    final bool isConsonant = _hangulInitialSounds.containsKey(symbol);
    final bool isVowel = _hangulVowelSounds.containsKey(symbol);

    if (!isConsonant && !isVowel) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.12)),
        ),
        child: Text(
          LearningUiText.detailHangulUnknown,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.blueGrey.shade800),
        ),
      );
    }

    final String typeLabel = isConsonant ? 'Consonne (자음)' : 'Voyelle (모음)';
    final String positionLabel = _hangulPositionLabel(
      symbol,
      isConsonant: isConsonant,
    );
    final List<Widget> infoRows = <Widget>[
      _HangulInfoRow(label: LearningUiText.detailHangulType, value: typeLabel),
      _HangulInfoRow(
        label: LearningUiText.detailHangulPosition,
        value: positionLabel,
      ),
    ];

    if (isConsonant) {
      infoRows.add(
        _HangulInfoRow(
          label: LearningUiText.detailHangulInitialSound,
          value: _hangulInitialSounds[symbol]!,
        ),
      );

      if (_hangulInitialOnlyConsonants.contains(symbol)) {
        infoRows.add(
          const _HangulInfoRow(
            label: LearningUiText.detailHangulFinalSound,
            value: 'Non utilise en fin de syllabe.',
          ),
        );
      } else {
        final String? finalSound = _hangulFinalSounds[symbol];
        if (finalSound != null) {
          infoRows.add(
            _HangulInfoRow(
              label: LearningUiText.detailHangulFinalSound,
              value: finalSound,
            ),
          );
        }
      }
    }

    if (isVowel) {
      final String? medialSound = _hangulVowelSounds[symbol];
      if (medialSound != null) {
        infoRows.add(
          _HangulInfoRow(
            label: LearningUiText.detailHangulMedialSound,
            value: medialSound,
          ),
        );
      }
    }

    final String? note = _hangulNotes[symbol];
    if (note != null) {
      infoRows.add(
        _HangulInfoRow(label: LearningUiText.detailHangulNote, value: note),
      );
    }

    infoRows.add(
      _HangulInfoRow(label: 'Romanisation', value: word.romanization),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueGrey.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < infoRows.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: 10),
            infoRows[i],
          ],
        ],
      ),
    );
  }

  String _hangulPositionLabel(String symbol, {required bool isConsonant}) {
    if (!isConsonant) {
      return 'Milieu de syllabe (중성).';
    }

    if (symbol == 'ㅇ') {
      return 'Debut de syllabe (초성) et fin de syllabe (종성/받침).';
    }

    if (_hangulInitialOnlyConsonants.contains(symbol)) {
      return 'Debut de syllabe uniquement (초성).';
    }

    return 'Debut (초성) et fin (종성/받침) de syllabe.';
  }

  List<String> _particlesFromWord(String? particle) {
    if (particle == null || particle.trim().isEmpty) {
      return <String>['-'];
    }

    final Set<String> parsedParticles = particle
        .split(',')
        .map((String value) => value.trim())
        .where((String value) => value.isNotEmpty)
        .toSet();

    if (parsedParticles.isEmpty) {
      return <String>['-'];
    }

    return parsedParticles.toList();
  }

  ParticleInfoEntity? _resolveParticleInfo(
    String particle,
    Map<String, ParticleInfoEntity> particleInfoByForm,
  ) {
    final ParticleInfoEntity? exact = particleInfoByForm[particle];
    if (exact != null) {
      return exact;
    }

    final List<String> slashForms = particle
        .split('/')
        .map((String value) => value.trim())
        .where((String value) => value.isNotEmpty)
        .toList();

    for (final String form in slashForms) {
      final ParticleInfoEntity? found = particleInfoByForm[form];
      if (found != null) {
        return found;
      }
    }

    return null;
  }

  Widget _buildParticlePill(
    BuildContext context,
    String particle,
    ParticleInfoEntity? info,
  ) {
    final bool isTappable = particle != '-' && info != null;

    return _Pill(
      label: particle,
      color: const Color(0xFF2563EB),
      outlined: true,
      onTap: isTappable ? () => _showParticleInfoBubble(context, info) : null,
    );
  }

  void _showParticleInfoBubble(BuildContext context, ParticleInfoEntity info) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFFDFEFF), Color(0xFFF4F8FF)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.85)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 28,
                      offset: const Offset(0, 14),
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 620),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color(0xFF0C4A8A),
                              Color(0xFF315F9F),
                              Color(0xFFC51F3A),
                            ],
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Nom : ${info.name}',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: _koreaBlue.withOpacity(0.08),
                                  border: Border.all(
                                    color: _koreaBlue.withOpacity(0.2),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Particule : ${_formsSummary(info)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: _koreaBlue,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Description : ${info.description}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(height: 1.35),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Formes',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: info.forms.entries
                                    .map(
                                      (MapEntry<String, String> entry) =>
                                          _ParticleFormChip(
                                            label: _formLabel(entry.key),
                                            value: entry.value,
                                          ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Exemples',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 8),
                              ...info.examples.map(
                                (ParticleExampleEntity example) =>
                                    _ParticleExampleCard(example: example),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formsSummary(ParticleInfoEntity info) {
    final List<String> forms = info.forms.values.toSet().toList();
    return forms.join(' / ');
  }

  String _formLabel(String key) {
    switch (key) {
      case 'consonant':
        return 'Consonne';
      case 'vowel':
        return 'Voyelle';
      case 'universal':
        return 'Universelle';
      case 'honorific':
        return 'Honorifique';
      case 'formal':
        return 'Formel';
      case 'spoken':
        return 'Oral';
      case 'casual':
        return 'Familier';
      case 'exception_l':
        return 'Exception (final ㄹ)';
      default:
        return key;
    }
  }

  String _politenessForSelectedTense(WordEntity word) {
    final String? exactValue =
        word.politenessByTense[_selectedTense]?[_selectedPolitenessLevel];

    if (exactValue != null && exactValue.trim().isNotEmpty) {
      return exactValue;
    }

    return WordDisplayMapper.missingPolitenessMessage(
      tense: _selectedTense,
      level: _selectedPolitenessLevel,
    );
  }

  List<Widget> _buildExamplesSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<ExampleSentenceEntity>> examplesState,
  ) {
    return examplesState.when(
      data: (List<ExampleSentenceEntity> examples) {
        if (examples.isEmpty) {
          return <Widget>[
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(LearningUiText.detailNoExamples),
              ),
            ),
          ];
        }

        return examples
            .map(
              (ExampleSentenceEntity example) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blueGrey.withOpacity(0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      example.sentence,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      example.romanization,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(example.translation),
                  ],
                ),
              ),
            )
            .toList();
      },
      loading: () => <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
      error: (Object error, StackTrace stackTrace) => <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(LearningUiText.detailExamplesLoadError),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => ref
                      .read(wordDetailViewModelProvider(widget.wordId).notifier)
                      .loadExamples(),
                  child: const Text(LearningUiText.retry),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context, WordEntity word) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFAFFFFFF), Color(0xF5F6F8FB)],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0x66C4CBD5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 28,
              offset: const Offset(0, 10),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: <double>[0, 0.55, 1],
                      colors: <Color>[
                        Color(0xFFD11F49),
                        Color(0xFFC51F3A),
                        Color(0xFFA32A63),
                      ],
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                        color: _koreaRed.withOpacity(0.16),
                      ),
                    ],
                  ),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CourseScreen(
                            lessonIdFilter: word.lessonId,
                            sourceWord: word.word,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text(LearningUiText.detailPracticeWord),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: Colors.blueGrey.shade800,
      ),
    );
  }
}

class _HangulInfoRow extends StatelessWidget {
  const _HangulInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.blueGrey.shade900,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.color,
    this.outlined = false,
    this.onTap,
  });

  final String label;
  final Color color;
  final bool outlined;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: outlined ? Border.all(color: color.withOpacity(0.35)) : null,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    if (onTap == null) {
      return child;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class _ParticleFormChip extends StatelessWidget {
  const _ParticleFormChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF1F6FF),
        border: Border.all(color: const Color(0xFFCFDFF7)),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF1E3A5F)),
          children: <InlineSpan>[
            TextSpan(
              text: '$label : ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _ParticleExampleCard extends StatelessWidget {
  const _ParticleExampleCard({required this.example});

  final ParticleExampleEntity example;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF6F9FF)],
        ),
        border: Border.all(color: const Color(0xFFDDE6F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            example.korean,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F2745),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            example.translation,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey.shade800),
          ),
        ],
      ),
    );
  }
}
