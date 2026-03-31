import '../models/theme_model.dart';

final List<ThemeModel> mockThemes = <ThemeModel>[
  const ThemeModel(
    id: 't1',
    name: 'Alphabet Hangul',
    description: 'Apprenez les bases du Hangul',
    icon: 'hangul',
    color: '#2196F3',
    exerciseIds: <String>['e1', 'e2'],
  ),
  const ThemeModel(
    id: 't2',
    name: 'Salutations quotidiennes',
    description: 'Phrases essentielles',
    icon: 'chat',
    color: '#E91E63',
    exerciseIds: <String>['e3', 'e4'],
  ),
  const ThemeModel(
    id: 't3',
    name: 'Vocabulaire de base',
    description: '50 mots essentiels',
    icon: 'brain',
    color: '#9C27B0',
    exerciseIds: <String>['e5', 'e6'],
  ),
  const ThemeModel(
    id: 't4',
    name: 'Nombres et comptage',
    description: 'Apprenez les chiffres coréens',
    icon: 'calculator',
    color: '#FF9800',
    exerciseIds: <String>['e7', 'e8'],
  ),
];
