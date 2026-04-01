import '../models/theme_model.dart';

final List<ThemeModel> mockThemes = <ThemeModel>[
  const ThemeModel(
    id: 't1',
    name: 'Alphabet Hangul',
    description: 'Apprenez les bases du Hangul',
    icon: 'hangul',
    color: '#2196F3',
    exerciseIds: <String>['h1', 'h2', 'h3', 'h4'],
  ),
];
