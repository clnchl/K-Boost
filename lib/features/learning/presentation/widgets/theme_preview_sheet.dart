import 'package:flutter/material.dart';

import '../../domain/entities/exercise.dart';
import '../../domain/entities/theme.dart';
import 'theme_ui_helpers.dart';

class ThemePreviewSheet extends StatelessWidget {
  const ThemePreviewSheet({
    super.key,
    required this.theme,
    required this.exercises,
    required this.progress,
  });

  final ThemeEntity theme;
  final List<ExerciseEntity> exercises;
  final double progress;

  Widget _sectionTitle({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color accentColor,
  }) {
    return Row(
      children: <Widget>[
        Icon(icon, color: accentColor),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = parseThemeColor(theme.color);
    final textTheme = Theme.of(context).textTheme;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final double progressValue = progress.clamp(0, 1);
    final int progressPercent = (progressValue * 100).round();
    final int rewardPoints = exercises.isEmpty ? 0 : exercises.length * 25;
    final int rewardXp = exercises.isEmpty ? 0 : 2 + (exercises.length * 2);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.84,
          ),
          decoration: BoxDecoration(
            color: scaffoldColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 14),
                        _ThemePreviewHeader(
                          theme: theme,
                          accentColor: accentColor,
                          onClose: () => Navigator.of(context).pop(false),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: <Widget>[
                            Text('Progression', style: textTheme.titleLarge),
                            const Spacer(),
                            Text(
                              '$progressPercent%',
                              style: textTheme.titleLarge?.copyWith(
                                color: accentColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            minHeight: 14,
                            value: progressValue,
                            backgroundColor: accentColor.withOpacity(0.16),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const SizedBox(height: 4),
                        _sectionTitle(
                          context: context,
                          icon: Icons.workspace_premium_outlined,
                          title: 'Récompenses',
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 12),
                        _ThemePreviewRewards(
                          accentColor: accentColor,
                          points: rewardPoints,
                          xp: rewardXp,
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(
                          context: context,
                          icon: Icons.menu_book_outlined,
                          title: 'Exercices inclus',
                          accentColor: accentColor,
                        ),
                        const SizedBox(height: 10),
                        _ThemePreviewExerciseList(
                          exercises: exercises,
                          theme: theme,
                          accentColor: accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Continuer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemePreviewHeader extends StatelessWidget {
  const _ThemePreviewHeader({
    required this.theme,
    required this.accentColor,
    required this.onClose,
  });

  final ThemeEntity theme;
  final Color accentColor;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitleColor = textTheme.bodyMedium?.color?.withOpacity(0.65);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: <Color>[accentColor, accentColor.withOpacity(0.72)],
            ),
          ),
          child: Icon(themeIconData(theme.icon), color: Colors.white, size: 36),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(theme.name, style: textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                theme.description,
                style: textTheme.titleMedium?.copyWith(color: subtitleColor),
              ),
            ],
          ),
        ),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
          ),
        ),
      ],
    );
  }
}

class _ThemePreviewRewards extends StatelessWidget {
  const _ThemePreviewRewards({
    required this.accentColor,
    required this.points,
    required this.xp,
  });

  final Color accentColor;
  final int points;
  final int xp;

  Widget _reward({
    required BuildContext context,
    required IconData icon,
    required String text,
    required double opacity,
    required double borderOpacity,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: accentColor.withOpacity(opacity),
          border: Border.all(color: accentColor.withOpacity(borderOpacity)),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: accentColor),
            const SizedBox(width: 8),
            Text(text, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _reward(
          context: context,
          icon: Icons.star_rounded,
          text: '$points points',
          opacity: 0.12,
          borderOpacity: 0.4,
        ),
        const SizedBox(width: 10),
        _reward(
          context: context,
          icon: Icons.track_changes_rounded,
          text: '+$xp XP',
          opacity: 0.08,
          borderOpacity: 0.26,
        ),
      ],
    );
  }
}

class _ThemePreviewExerciseList extends StatelessWidget {
  const _ThemePreviewExerciseList({
    required this.exercises,
    required this.theme,
    required this.accentColor,
  });

  final List<ExerciseEntity> exercises;
  final ThemeEntity theme;
  final Color accentColor;

  bool get _isHangulTheme =>
      theme.id == 't1' || theme.icon.toLowerCase() == 'hangul';

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withOpacity(0.25)),
      ),
      child: const Text(
        'Les exercices de ce thème sont en cours de chargement.',
      ),
    );
  }

  Widget _exerciseItem(BuildContext context, ExerciseEntity exercise) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: accentColor.withOpacity(0.08),
        border: Border.all(color: accentColor.withOpacity(0.24)),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.circle, size: 10, color: accentColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  exerciseTypeLabel(exercise.type),
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  exerciseStageLabel(exercise.type),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hangulExerciseItem(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: accentColor.withOpacity(0.08),
        border: Border.all(color: accentColor.withOpacity(0.24)),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.circle, size: 10, color: accentColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return _emptyState();
    }

    if (_isHangulTheme) {
      return Column(
        children: <Widget>[
          _hangulExerciseItem(
            context,
            title: 'QCM de lecture',
            subtitle: '가 → ga',
          ),
          _hangulExerciseItem(
            context,
            title: 'Construire une syllabe',
            subtitle: 'ㄱ + ㅏ → 가',
          ),
          _hangulExerciseItem(
            context,
            title: 'Reconnaissance audio',
            subtitle: 'audio → choisir la syllabe',
          ),
          _hangulExerciseItem(
            context,
            title: 'Romanisation → Hangul',
            subtitle: 'ga → 가',
          ),
          _hangulExerciseItem(
            context,
            title: 'Hangul → Romanisation',
            subtitle: '가 → ga',
          ),
          _hangulExerciseItem(
            context,
            title: 'Écriture clavier Hangul',
            subtitle: 'saisir la bonne syllabe',
          ),
          _hangulExerciseItem(
            context,
            title: 'Drag & drop',
            subtitle: 'assembler consonnes et voyelles',
          ),
        ],
      );
    }

    final List<ExerciseEntity> uniqueExercises = <ExerciseEntity>[];
    final Set<String> seenLabels = <String>{};
    for (final ExerciseEntity exercise in exercises) {
      final String signature = '${exercise.type}|${exercise.questionText}';
      if (seenLabels.add(signature)) {
        uniqueExercises.add(exercise);
      }
      if (uniqueExercises.length >= 6) {
        break;
      }
    }

    return Column(
      children: uniqueExercises
          .map((ExerciseEntity exercise) => _exerciseItem(context, exercise))
          .toList(),
    );
  }
}
