import '../models/word_model.dart';
import '../models/example_sentence_model.dart';
import '../../domain/entities/word.dart';

final List<WordModel> mockWords = <WordModel>[
  const WordModel(
    id: 'w1',
    word: '사람',
    translation: 'personne',
    romanization: 'saram',
    category: 'subject',
    particle: '은/는',
    definition: 'Un être humain.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l1',
    politenessByTense: <WordTense, Map<PolitenessLevel, String>>{
      WordTense.present: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 사람이야.',
        PolitenessLevel.polite: 'Poli: 사람이에요.',
        PolitenessLevel.formal: 'Formel: 사람입니다.',
      },
      WordTense.past: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 사람이었어.',
        PolitenessLevel.polite: 'Poli: 사람이었어요.',
        PolitenessLevel.formal: 'Formel: 사람이었습니다.',
      },
      WordTense.future: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 사람일 거야.',
        PolitenessLevel.polite: 'Poli: 사람일 거예요.',
        PolitenessLevel.formal: 'Formel: 사람이겠습니다.',
      },
    },
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
    politenessByTense: <WordTense, Map<PolitenessLevel, String>>{
      WordTense.present: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 밥이야.',
        PolitenessLevel.polite: 'Poli: 밥이에요.',
        PolitenessLevel.formal: 'Formel: 밥입니다.',
      },
      WordTense.past: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 밥이었어.',
        PolitenessLevel.polite: 'Poli: 밥이었어요.',
        PolitenessLevel.formal: 'Formel: 밥이었습니다.',
      },
      WordTense.future: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 밥일 거야.',
        PolitenessLevel.polite: 'Poli: 밥일 거예요.',
        PolitenessLevel.formal: 'Formel: 밥이겠습니다.',
      },
    },
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
    politenessByTense: <WordTense, Map<PolitenessLevel, String>>{
      WordTense.present: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 먹어.',
        PolitenessLevel.polite: 'Poli: 먹어요.',
        PolitenessLevel.formal: 'Formel: 먹습니다.',
      },
      WordTense.past: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 먹었어.',
        PolitenessLevel.polite: 'Poli: 먹었어요.',
        PolitenessLevel.formal: 'Formel: 먹었습니다.',
      },
      WordTense.future: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 먹을 거야.',
        PolitenessLevel.polite: 'Poli: 먹을 거예요.',
        PolitenessLevel.formal: 'Formel: 먹겠습니다.',
      },
    },
  ),
  const WordModel(
    id: 'w4',
    word: '학교',
    translation: 'école',
    romanization: 'hakgyo',
    category: 'place',
    particle: '에',
    definition: 'Lieu d\'études.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l2',
    politenessByTense: <WordTense, Map<PolitenessLevel, String>>{
      WordTense.present: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 학교야.',
        PolitenessLevel.polite: 'Poli: 학교예요.',
        PolitenessLevel.formal: 'Formel: 학교입니다.',
      },
      WordTense.past: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 학교였어.',
        PolitenessLevel.polite: 'Poli: 학교였어요.',
        PolitenessLevel.formal: 'Formel: 학교였습니다.',
      },
      WordTense.future: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 학교일 거야.',
        PolitenessLevel.polite: 'Poli: 학교일 거예요.',
        PolitenessLevel.formal: 'Formel: 학교이겠습니다.',
      },
    },
  ),
  const WordModel(
    id: 'w5',
    word: '오늘',
    translation: 'aujourd\'hui',
    romanization: 'oneul',
    category: 'time',
    particle: null,
    definition: 'Indique le temps présent.',
    difficulty: 1,
    audioUrl: null,
    lessonId: 'l2',
    politenessByTense: <WordTense, Map<PolitenessLevel, String>>{
      WordTense.present: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 오늘이야.',
        PolitenessLevel.polite: 'Poli: 오늘이에요.',
        PolitenessLevel.formal: 'Formel: 오늘입니다.',
      },
      WordTense.past: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 오늘이었어.',
        PolitenessLevel.polite: 'Poli: 오늘이었어요.',
        PolitenessLevel.formal: 'Formel: 오늘이었습니다.',
      },
      WordTense.future: <PolitenessLevel, String>{
        PolitenessLevel.informal: 'Informel: 오늘일 거야.',
        PolitenessLevel.polite: 'Poli: 오늘일 거예요.',
        PolitenessLevel.formal: 'Formel: 오늘이겠습니다.',
      },
    },
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
          translation: 'J\'apprends le verbe manger maintenant.',
        ),
      ],
      'w4': <ExampleSentenceModel>[
        const ExampleSentenceModel(
          sentence: '학교에 가요.',
          romanization: 'hakgyoe gayo.',
          translation: 'Je vais à l\'école.',
        ),
      ],
      'w5': <ExampleSentenceModel>[
        const ExampleSentenceModel(
          sentence: '오늘 날씨가 좋아요.',
          romanization: 'oneul nalssiga joayo.',
          translation: 'Le temps est beau aujourd\'hui.',
        ),
      ],
    };
