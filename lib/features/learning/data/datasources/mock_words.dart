import '../models/word_model.dart';
import '../models/example_sentence_model.dart';

final List<WordModel> mockWords = <WordModel>[
  const WordModel(
    id: 'w1',
    word: '사람',
    translation: 'personne',
    romanization: 'saram',
    category: 'subject',
    particle: '은/는',
    definition: 'Un etre humain.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l1',
  ),
  const WordModel(
    id: 'w2',
    word: '밥',
    translation: 'riz / repas',
    romanization: 'bap',
    category: 'object',
    particle: '을/를',
    definition: 'Le riz ou un repas selon le contexte.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l1',
  ),
  const WordModel(
    id: 'w3',
    word: '먹다',
    translation: 'manger',
    romanization: 'meokda',
    category: 'action',
    particle: null,
    definition: 'Action de manger.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l1',
  ),
  const WordModel(
    id: 'w4',
    word: '학교',
    translation: 'ecole',
    romanization: 'hakgyo',
    category: 'place',
    particle: '에',
    definition: 'Lieu d etudes.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l2',
  ),
  const WordModel(
    id: 'w5',
    word: '오늘',
    translation: 'aujourd hui',
    romanization: 'oneul',
    category: 'time',
    particle: null,
    definition: 'Indique le temps present.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l2',
  ),
];

final Map<String, List<ExampleSentenceModel>> mockWordExamples =
    <String, List<ExampleSentenceModel>>{
  'w1': <ExampleSentenceModel>[
    const ExampleSentenceModel(
      sentence: '사람이 많아요.',
      romanization: 'sarami manayo.',
      translation: 'Il y a beaucoup de personnes.',
    ),
  ],
  'w2': <ExampleSentenceModel>[
    const ExampleSentenceModel(
      sentence: '나는 밥을 먹어요.',
      romanization: 'naneun babeul meogeoyo.',
      translation: 'Je mange du riz.',
    ),
  ],
  'w3': <ExampleSentenceModel>[
    const ExampleSentenceModel(
      sentence: '저는 지금 먹다를 배워요.',
      romanization: 'jeoneun jigeum meokdareul baewoyo.',
      translation: 'J apprends le verbe manger maintenant.',
    ),
  ],
  'w4': <ExampleSentenceModel>[
    const ExampleSentenceModel(
      sentence: '학교에 가요.',
      romanization: 'hakgyoe gayo.',
      translation: 'Je vais a l ecole.',
    ),
  ],
  'w5': <ExampleSentenceModel>[
    const ExampleSentenceModel(
      sentence: '오늘 날씨가 좋아요.',
      romanization: 'oneul nalssiga joayo.',
      translation: 'Le temps est beau aujourd hui.',
    ),
  ],
};
