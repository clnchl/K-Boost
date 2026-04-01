import '../../domain/entities/particle_info.dart';

final List<ParticleInfoEntity> mockKoreanParticles = <ParticleInfoEntity>[
  const ParticleInfoEntity(
    name: 'Sujet',
    forms: <String, String>{'consonant': '이', 'vowel': '가', 'honorific': '께서'},
    description: 'Indique le sujet qui realise l\'action.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '학생이 책을 읽어요.',
        translation: 'L\'etudiant lit un livre.',
      ),
      ParticleExampleEntity(
        korean: '선생님께서 말씀하세요.',
        translation: 'Le professeur parle (honorifique).',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Theme',
    forms: <String, String>{'consonant': '은', 'vowel': '는'},
    description: 'Indique le theme ou marque un contraste.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '저는 한국어를 배워요.',
        translation: 'Moi, j\'apprends le coreen.',
      ),
      ParticleExampleEntity(
        korean: '오늘은 날씨가 좋아요.',
        translation: 'Aujourd\'hui, le temps est beau.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Objet',
    forms: <String, String>{'consonant': '을', 'vowel': '를'},
    description: 'Indique l\'objet direct de l\'action.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '나는 밥을 먹는다.',
        translation: 'Je mange du riz.',
      ),
      ParticleExampleEntity(korean: '책을 읽어요.', translation: 'Je lis un livre.'),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Possession',
    forms: <String, String>{'universal': '의'},
    description: 'Indique la possession ou l\'appartenance.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '제 친구의 가방이에요.',
        translation: 'C\'est le sac de mon ami.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Lieu / Temps',
    forms: <String, String>{'universal': '에'},
    description:
        'Indique une destination, un lieu statique ou un moment precis.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '학교에 가요.',
        translation: 'Je vais a l\'ecole.',
      ),
      ParticleExampleEntity(
        korean: '세 시에 만나요.',
        translation: 'On se voit a 3 heures.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Lieu d\'action',
    forms: <String, String>{'universal': '에서'},
    description: 'Lieu ou se deroule une action.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '도서관에서 공부해요.',
        translation: 'J\'etudie a la bibliotheque.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Direction / Moyen',
    forms: <String, String>{
      'consonant': '으로',
      'vowel': '로',
      'exception_l': '로',
    },
    description: 'Indique une direction, un moyen ou une methode.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(korean: '버스로 가요.', translation: 'Je vais en bus.'),
      ParticleExampleEntity(
        korean: '오른쪽으로 가세요.',
        translation: 'Allez vers la droite.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Point de depart',
    forms: <String, String>{'universal': '부터'},
    description: 'Indique le debut d\'un intervalle (temps ou lieu).',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '아홉 시부터 수업이 있어요.',
        translation: 'Les cours commencent a 9 heures.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Point final',
    forms: <String, String>{'universal': '까지'},
    description: 'Indique la fin d\'un intervalle.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '다섯 시까지 일해요.',
        translation: 'Je travaille jusqu\'a 5 heures.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'A / Vers (Personne)',
    forms: <String, String>{'formal': '에게', 'spoken': '한테', 'honorific': '께'},
    description: 'Indique le destinataire d\'une action.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '친구에게 선물을 줘요.',
        translation: 'Je donne un cadeau a un ami.',
      ),
      ParticleExampleEntity(
        korean: '선생님께 질문해요.',
        translation: 'Je pose une question au professeur (honorifique).',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Provenance (Personne)',
    forms: <String, String>{'formal': '에게서', 'spoken': '한테서'},
    description: 'Indique la provenance depuis une personne.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '친구에게서 편지를 받았어요.',
        translation: 'J\'ai recu une lettre d\'un ami.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Avec / Et',
    forms: <String, String>{'formal': '과/와', 'spoken': '하고', 'casual': '이랑/랑'},
    description: 'Relie deux noms ou indique une compagnie.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '친구와 영화를 봐요.',
        translation: 'Je regarde un film avec un ami.',
      ),
      ParticleExampleEntity(
        korean: '동생이랑 놀아요.',
        translation: 'Je joue avec mon petit frere / ma petite soeur.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Aussi',
    forms: <String, String>{'universal': '도'},
    description: 'Indique l\'inclusion ou l\'addition.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '저도 가요.',
        translation: 'Moi aussi, j\'y vais.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Seulement',
    forms: <String, String>{'universal': '만'},
    description: 'Indique une restriction.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '물만 마셔요.',
        translation: 'Je ne bois que de l\'eau.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Meme',
    forms: <String, String>{'universal': '조차'},
    description: 'Signifie "meme" dans un sens emphatique.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '물조차 없어요.',
        translation: 'Il n\'y a meme pas d\'eau.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Jusqu\'a (emphase)',
    forms: <String, String>{'universal': '마저'},
    description: 'Signifie "meme jusqu\'a".',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '마지막 기회마저 놓쳤어요.',
        translation: 'J\'ai meme rate la derniere chance.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Comparaison',
    forms: <String, String>{'universal': '보다'},
    description: 'Utilise pour comparer deux elements.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '한국어가 영어보다 어려워요.',
        translation: 'Le coreen est plus difficile que l\'anglais.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Contraste',
    forms: <String, String>{'universal': '만큼'},
    description: 'Signifie "autant que" ou "dans la meme mesure".',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '너만큼 잘하고 싶어요.',
        translation: 'Je veux faire aussi bien que toi.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Concernant',
    forms: <String, String>{'universal': '에 대해서'},
    description: 'Signifie "a propos de".',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '한국 문화에 대해서 공부해요.',
        translation: 'J\'etudie a propos de la culture coreenne.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'But',
    forms: <String, String>{'universal': '위해'},
    description: 'Indique un objectif ou une intention.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '가족을 위해 일해요.',
        translation: 'Je travaille pour ma famille.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Cause',
    forms: <String, String>{'universal': '때문에'},
    description: 'Indique une cause ou une raison.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '비 때문에 늦었어요.',
        translation: 'Je suis en retard a cause de la pluie.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Citation directe',
    forms: <String, String>{'universal': '라고'},
    description: 'Utilise pour citer ou nommer.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '그는 자신을 학생이라고 소개했어요.',
        translation: 'Il s\'est presente comme etudiant.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Citation indirecte',
    forms: <String, String>{'universal': '고'},
    description: 'Utilise pour rapporter une parole ou une pensee.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '그는 간다고 말했어요.',
        translation: 'Il a dit qu\'il partait.',
      ),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Question informelle',
    forms: <String, String>{'universal': '냐'},
    description: 'Particule interrogative informelle.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(korean: '어디 가냐?', translation: 'Ou vas-tu ?'),
    ],
  ),
  const ParticleInfoEntity(
    name: 'Emphase conversationnelle',
    forms: <String, String>{'universal': '네'},
    description: 'Ajoute une nuance conversationnelle.',
    examples: <ParticleExampleEntity>[
      ParticleExampleEntity(
        korean: '오늘 날씨가 좋네.',
        translation: 'Le temps est vraiment beau aujourd\'hui.',
      ),
    ],
  ),
];

final Map<String, ParticleInfoEntity> mockKoreanParticlesByForm =
    _buildParticleMapByForm(mockKoreanParticles);

Map<String, ParticleInfoEntity> _buildParticleMapByForm(
  List<ParticleInfoEntity> particles,
) {
  final Map<String, ParticleInfoEntity> result = <String, ParticleInfoEntity>{};

  for (final ParticleInfoEntity particle in particles) {
    for (final String formValue in particle.forms.values) {
      for (final String key in _splitFormKeys(formValue)) {
        result[key] = particle;
      }
    }
  }

  return result;
}

List<String> _splitFormKeys(String rawForms) {
  final String normalized = rawForms.trim();
  if (normalized.isEmpty) {
    return <String>[];
  }

  final List<String> result = <String>[normalized];
  if (!normalized.contains('/')) {
    return result;
  }

  final List<String> splitForms = normalized
      .split('/')
      .map((String value) => value.trim())
      .where((String value) => value.isNotEmpty)
      .toList();

  for (final String form in splitForms) {
    if (!result.contains(form)) {
      result.add(form);
    }
  }

  return result;
}
