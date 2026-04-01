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
  const ThemeModel(
    id: 't2',
    name: 'Salutations basiques',
    description: 'Theme de base (bientot disponible)',
    icon: 'chat',
    color: '#26A69A',
    exerciseIds: <String>[],
  ),
  const ThemeModel(
    id: 't3',
    name: 'Nombres basiques',
    description: 'Theme de base (bientot disponible)',
    icon: 'calculator',
    color: '#FFB300',
    exerciseIds: <String>[],
  ),
  const ThemeModel(
    id: 't4',
    name: 'Verbes basiques',
    description: 'Theme de base (bientot disponible)',
    icon: 'brain',
    color: '#AB47BC',
    exerciseIds: <String>[],
  ),
  const ThemeModel(
    id: 't5',
    name: 'Phrases simples',
    description: 'Theme de base (bientot disponible)',
    icon: 'book',
    color: '#5C6BC0',
    exerciseIds: <String>[],
  ),
];
