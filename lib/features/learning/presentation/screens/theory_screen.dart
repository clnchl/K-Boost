import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/word.dart';
import '../constants/learning_ui_text.dart';
import '../utils/word_display_mapper.dart';
import '../viewmodels/theory_viewmodel.dart';
import '../widgets/word_card.dart';
import 'word_detail_screen.dart';

class TheoryScreen extends ConsumerStatefulWidget {
  const TheoryScreen({super.key});

  @override
  ConsumerState<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends ConsumerState<TheoryScreen> {
  static const String _allTheme = 'all';
  static const String _allSubTheme = 'all';
  static const Color _koreaBlue = WordDisplayMapper.koreaBlue;
  static const Color _koreaRed = WordDisplayMapper.koreaRed;

  late final TextEditingController _searchController;
  String _searchQuery = '';
  String _selectedTheme = _allTheme;
  String _selectedSubTheme = _allSubTheme;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WidgetRef ref = this.ref;
    final AsyncValue<List<WordEntity>> wordsState = ref.watch(
      theoryViewModelProvider,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: wordsState.when(
        data: (List<WordEntity> words) {
          final List<String> sortedThemes = <String>{
            ...words.map((WordEntity word) => word.theme),
          }.toList()..sort();

          final List<String> themes = <String>[_allTheme, ...sortedThemes];
          final List<String> sortedSubThemes = _sortedSubThemesForSelectedTheme(
            words,
          );
          final List<String> subThemes = sortedSubThemes.isEmpty
              ? <String>[]
              : <String>[_allSubTheme, ...sortedSubThemes];

          final List<WordEntity> filteredWords = words
              .where(
                (WordEntity word) =>
                    _matchesTheme(word) &&
                    _matchesSubTheme(word) &&
                    _matchesSearch(word),
              )
              .toList();

          if (words.isEmpty) {
            return const SafeArea(
              child: Center(child: Text(LearningUiText.theoryNoWordsAvailable)),
            );
          }

          return SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -120,
                  left: -100,
                  width: 300,
                  height: 300,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[
                            _koreaBlue.withOpacity(0.14),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -140,
                  right: -120,
                  width: 320,
                  height: 320,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[
                            _koreaRed.withOpacity(0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    _buildTopHeader(context),
                    _buildThemeFilters(context, themes),
                    if (subThemes.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 8),
                      _buildSubThemeFilters(context, subThemes),
                    ],
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            LearningUiText.theoryWordsAvailable,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            child: Text(
                              '${filteredWords.length}',
                              key: ValueKey<String>(
                                '${filteredWords.length}-$_selectedTheme-$_searchQuery',
                              ),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: _koreaBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        child: filteredWords.isEmpty
                            ? _buildEmptyFilteredState(context)
                            : RefreshIndicator(
                                onRefresh: () => ref
                                    .read(theoryViewModelProvider.notifier)
                                    .loadWords(),
                                child: ListView.separated(
                                  key: ValueKey<String>(
                                    'list-$_selectedTheme-$_searchQuery',
                                  ),
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    16,
                                    16,
                                  ),
                                  itemCount: filteredWords.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (BuildContext context, int index) {
                                    final WordEntity word =
                                        filteredWords[index];

                                    return WordCard(
                                      word: word,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder<void>(
                                            opaque: false,
                                            barrierDismissible: true,
                                            barrierColor: Colors.black
                                                .withOpacity(0.28),
                                            transitionDuration: const Duration(
                                              milliseconds: 380,
                                            ),
                                            reverseTransitionDuration:
                                                const Duration(
                                                  milliseconds: 300,
                                                ),
                                            pageBuilder:
                                                (
                                                  BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                  secondaryAnimation,
                                                ) => WordDetailScreen(
                                                  wordId: word.id,
                                                ),
                                            transitionsBuilder:
                                                (
                                                  BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                  secondaryAnimation,
                                                  Widget child,
                                                ) {
                                                  final Animation<double> fade =
                                                      CurvedAnimation(
                                                        parent: animation,
                                                        curve:
                                                            Curves.easeOutCubic,
                                                        reverseCurve:
                                                            Curves.easeInCubic,
                                                      );
                                                  final Animation<Offset>
                                                  slide =
                                                      Tween<Offset>(
                                                        begin: const Offset(
                                                          0,
                                                          0.08,
                                                        ),
                                                        end: Offset.zero,
                                                      ).animate(
                                                        CurvedAnimation(
                                                          parent: animation,
                                                          curve: Curves
                                                              .easeOutCubic,
                                                          reverseCurve: Curves
                                                              .easeInCubic,
                                                        ),
                                                      );
                                                  final Animation<double>
                                                  scale =
                                                      Tween<double>(
                                                        begin: 0.94,
                                                        end: 1,
                                                      ).animate(
                                                        CurvedAnimation(
                                                          parent: animation,
                                                          curve: Curves
                                                              .easeOutBack,
                                                          reverseCurve:
                                                              Curves.easeInBack,
                                                        ),
                                                      );

                                                  return FadeTransition(
                                                    opacity: fade,
                                                    child: SlideTransition(
                                                      position: slide,
                                                      child: ScaleTransition(
                                                        scale: scale,
                                                        child: child,
                                                      ),
                                                    ),
                                                  );
                                                },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () =>
            const SafeArea(child: Center(child: CircularProgressIndicator())),
        error: (Object error, StackTrace stackTrace) {
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(LearningUiText.theoryLoadError),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: () => ref
                              .read(theoryViewModelProvider.notifier)
                              .loadWords(),
                          child: const Text(LearningUiText.retryAccented),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: <double>[0, 0.34, 0.62, 0.82, 1],
          colors: <Color>[
            _koreaBlue,
            Color(0xFF1C5A9E),
            Color(0xFF3A66A8),
            Color(0xFF7A4D94),
            _koreaRed,
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x33FFFFFF),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  LearningUiText.theoryTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            onChanged: (String value) {
              setState(() {
                _searchQuery = value.trim();
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: LearningUiText.theorySearchHint,
              hintStyle: const TextStyle(color: Color(0xC5FFFFFF)),
              prefixIcon: const Icon(Icons.search_rounded, color: Colors.white),
              suffixIcon: _searchQuery.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
              filled: true,
              fillColor: const Color(0x2EFFFFFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeFilters(BuildContext context, List<String> themes) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: themes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final String theme = themes[index];
          final bool isSelected = theme == _selectedTheme;
          final Color accentColor = WordDisplayMapper.themeFilterAccentColor(
            theme,
            allThemeKey: _allTheme,
          );

          return ChoiceChip(
            avatar: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(isSelected ? 0.95 : 0.55),
              ),
            ),
            label: Text(
              WordDisplayMapper.themeLabel(theme, allThemeKey: _allTheme),
            ),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                _selectedTheme = theme;
                _selectedSubTheme = _allSubTheme;
              });
            },
            selectedColor: accentColor.withOpacity(0.16),
            backgroundColor: Colors.white.withOpacity(0.92),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isSelected ? accentColor : Colors.blueGrey.shade700,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: isSelected
                  ? accentColor.withOpacity(0.62)
                  : accentColor.withOpacity(0.22),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubThemeFilters(BuildContext context, List<String> subThemes) {
    final Color accentColor = WordDisplayMapper.themeFilterAccentColor(
      _selectedTheme,
      allThemeKey: _allTheme,
    );

    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: subThemes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final String subTheme = subThemes[index];
          final bool isSelected = subTheme == _selectedSubTheme;

          return ChoiceChip(
            label: Text(
              WordDisplayMapper.subThemeLabel(
                subTheme,
                allSubThemeKey: _allSubTheme,
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                _selectedSubTheme = subTheme;
              });
            },
            selectedColor: accentColor.withOpacity(0.16),
            backgroundColor: Colors.white.withOpacity(0.92),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isSelected ? accentColor : Colors.blueGrey.shade700,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: isSelected
                  ? accentColor.withOpacity(0.62)
                  : accentColor.withOpacity(0.22),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyFilteredState(BuildContext context) {
    return Center(
      key: const ValueKey<String>('empty-filtered-words'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.menu_book_rounded,
              size: 42,
              color: Colors.blueGrey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              LearningUiText.theoryNoFilteredWords,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              LearningUiText.theoryNoFilteredWordsHint,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  bool _matchesTheme(WordEntity word) {
    if (_selectedTheme == _allTheme) {
      return true;
    }
    return word.theme == _selectedTheme;
  }

  bool _matchesSubTheme(WordEntity word) {
    if (_selectedTheme == _allTheme || _selectedSubTheme == _allSubTheme) {
      return true;
    }
    return word.subTheme == _selectedSubTheme;
  }

  List<String> _sortedSubThemesForSelectedTheme(List<WordEntity> words) {
    if (_selectedTheme == _allTheme) {
      return <String>[];
    }

    final List<String> subThemes =
        <String>{
              ...words
                  .where((WordEntity word) => word.theme == _selectedTheme)
                  .map((WordEntity word) => word.subTheme),
            }
            .where(
              (String subTheme) => subTheme.isNotEmpty && subTheme != 'general',
            )
            .toList()
          ..sort();

    return subThemes;
  }

  bool _matchesSearch(WordEntity word) {
    if (_searchQuery.isEmpty) {
      return true;
    }

    final String query = _searchQuery.toLowerCase();
    final String haystack = <String>[
      word.word,
      word.translation,
      word.romanization,
      word.definition,
      word.theme,
      word.subTheme,
      word.category,
    ].join(' ').toLowerCase();

    return haystack.contains(query);
  }
}
