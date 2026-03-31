import '../models/exercise_model.dart';

final List<ExerciseModel> mockExercises = <ExerciseModel>[
  const ExerciseModel(
    id: 'e1',
    type: 'multiple_choice',
    difficulty: 1,
    lessonId: 'l1',
    questionText: 'Que signifie 먹다 ?',
    options: <String>['manger', 'boire', 'aller', 'lire'],
    correctAnswer: 'manger',
  ),
  const ExerciseModel(
    id: 'e2',
    type: 'translation',
    difficulty: 1,
    lessonId: 'l1',
    questionText: 'Traduire: 나는 밥을 먹는다',
    options: <String>[
      'Je mange du riz.',
      'Je vais a l ecole.',
      'Je lis un livre.',
      'Je bois de l eau.',
    ],
    correctAnswer: 'Je mange du riz.',
  ),
  const ExerciseModel(
    id: 'e3',
    type: 'sentence_order',
    difficulty: 2,
    lessonId: 'l2',
    questionText: 'Remets dans l ordre: 먹는다 / 밥을 / 나는',
    options: <String>[
      '나는 밥을 먹는다',
      '밥을 나는 먹는다',
      '먹는다 나는 밥을',
      '나는 먹는다 밥을',
    ],
    correctAnswer: '나는 밥을 먹는다',
  ),
];
