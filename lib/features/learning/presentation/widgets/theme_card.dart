import 'package:flutter/material.dart';

import '../../domain/entities/theme.dart';
import 'theme_ui_helpers.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.theme,
    required this.onTap,
    this.progress = 0,
    this.isCompleted = false,
  });

  final ThemeEntity theme;
  final VoidCallback onTap;
  final double progress;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = parseThemeColor(theme.color);
    final textTheme = Theme.of(context).textTheme;
    final double progressValue = progress.clamp(0, 1);
    final int progressPercent = (progressValue * 100).round();
    final Color titleColor = isCompleted ? Colors.black87 : Colors.white;
    final Color subtitleColor = isCompleted ? Colors.black54 : Colors.white70;
    final Color lightOnCard = isCompleted ? bgColor : Colors.white;
    final Color iconBgColor = isCompleted
        ? bgColor.withOpacity(0.16)
        : Colors.white.withOpacity(0.2);
    final Color progressBg = isCompleted
        ? bgColor.withOpacity(0.16)
        : Colors.white.withOpacity(0.35);
    final String actionLabel = isCompleted ? 'S\'entraîner' : 'Continuer';

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isCompleted ? Colors.white : null,
            gradient: isCompleted
                ? null
                : LinearGradient(
                    colors: <Color>[bgColor, bgColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        themeIconData(theme.icon),
                        color: lightOnCard,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            theme.name,
                            style: textTheme.titleMedium?.copyWith(
                              color: titleColor,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            theme.description,
                            style: textTheme.bodySmall?.copyWith(
                              color: subtitleColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (!isCompleted)
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white.withOpacity(0.7),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: progressValue,
                    backgroundColor: progressBg,
                    valueColor: AlwaysStoppedAnimation<Color>(lightOnCard),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$progressPercent%',
                  style: textTheme.bodySmall?.copyWith(color: subtitleColor),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onTap,
                    style: FilledButton.styleFrom(
                      backgroundColor: isCompleted
                          ? Colors.green.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                      foregroundColor: isCompleted
                          ? Colors.green[800]
                          : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(actionLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
