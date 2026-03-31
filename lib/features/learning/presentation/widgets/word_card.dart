import 'package:flutter/material.dart';

import '../../domain/entities/word.dart';
import '../constants/learning_ui_text.dart';
import '../utils/word_display_mapper.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.word, required this.onTap});

  final WordEntity word;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = WordDisplayMapper.categoryAccentColor(
      word.category,
    );
    final String presentPoliteness = WordDisplayMapper.presentPolitenessPreview(
      word,
    );

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blueGrey.withOpacity(0.15)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF7FAFF)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            tag: 'word-${word.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                word.word,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: WordDisplayMapper.koreaBlue,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            word.romanization,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.blueGrey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: WordDisplayMapper.koreaRed.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: WordDisplayMapper.koreaRed,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  word.translation,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.78),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _TagChip(
                      label: WordDisplayMapper.categoryLabel(word.category),
                      color: categoryColor,
                    ),
                    _TagChip(
                      label:
                          '${LearningUiText.wordCardParticlePrefix} ${_particleLabel(word.particle)}',
                      color: const Color(0xFF2563EB),
                    ),
                    _TagChip(
                      label:
                          '${LearningUiText.wordCardLessonPrefix} ${word.lessonId.replaceFirst('l', '')}',
                      color: WordDisplayMapper.koreaBlue,
                    ),
                    _TagChip(
                      label:
                          '${LearningUiText.wordCardLevelPrefix} ${word.difficulty}',
                      color: WordDisplayMapper.koreaRed,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: WordDisplayMapper.koreaBlue.withOpacity(0.06),
                    border: Border.all(
                      color: WordDisplayMapper.koreaBlue.withOpacity(0.16),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.forum_outlined,
                        size: 18,
                        color: WordDisplayMapper.koreaBlue.withOpacity(0.9),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          presentPoliteness,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.blueGrey.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _particleLabel(String? particle) {
    if (particle == null || particle.trim().isEmpty) {
      return '-';
    }

    return particle;
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
