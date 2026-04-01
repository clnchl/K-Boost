// Modèle pour une lettre Hangul
class HangulLetter {
  const HangulLetter({
    required this.id,
    required this.character,
    required this.romanization,
    required this.category,
  });

  final String id;
  final String character; // ex: 'ㄱ', 'ㄴ', 'ㅏ', etc.
  final String romanization; // ex: 'ga', 'na', 'a', etc.
  final String
  category; // 'vowel', 'consonant', 'vowel_advanced', 'consonant_advanced'

  @override
  String toString() => character;
}

// Catégories Hangul
class HangulCategory {
  const HangulCategory({
    required this.id,
    required this.name,
    required this.letters,
    required this.description,
  });

  final String id;
  final String name;
  final List<HangulLetter> letters;
  final String description;
}

// Données de toutes les lettres Hangul organisées par catégorie
final List<HangulCategory> hangulCategoriesData = <HangulCategory>[
  // Voyelles de base (10)
  HangulCategory(
    id: 'vowels_basic',
    name: 'Voyelles',
    description: 'Apprenez les voyelles de base du Hangul',
    letters: <HangulLetter>[
      const HangulLetter(
        id: 'v1',
        character: 'ㅏ',
        romanization: 'a',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v2',
        character: 'ㅑ',
        romanization: 'ya',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v3',
        character: 'ㅓ',
        romanization: 'eo',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v4',
        character: 'ㅕ',
        romanization: 'yeo',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v5',
        character: 'ㅗ',
        romanization: 'o',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v6',
        character: 'ㅛ',
        romanization: 'yo',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v7',
        character: 'ㅜ',
        romanization: 'u',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v8',
        character: 'ㅠ',
        romanization: 'yu',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v9',
        character: 'ㅡ',
        romanization: 'eu',
        category: 'vowel',
      ),
      const HangulLetter(
        id: 'v10',
        character: 'ㅣ',
        romanization: 'i',
        category: 'vowel',
      ),
    ],
  ),

  // Consonnes de base (14)
  HangulCategory(
    id: 'consonants_basic',
    name: 'Consonnes',
    description: 'Apprenez les consonnes de base du Hangul',
    letters: <HangulLetter>[
      const HangulLetter(
        id: 'c1',
        character: 'ㄱ',
        romanization: 'g/k',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c2',
        character: 'ㄴ',
        romanization: 'n',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c3',
        character: 'ㄷ',
        romanization: 'd/t',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c4',
        character: 'ㄹ',
        romanization: 'r/l',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c5',
        character: 'ㅁ',
        romanization: 'm',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c6',
        character: 'ㅂ',
        romanization: 'b/p',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c7',
        character: 'ㅅ',
        romanization: 's',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c8',
        character: 'ㅇ',
        romanization: 'ng',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c9',
        character: 'ㅈ',
        romanization: 'j',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c10',
        character: 'ㅉ',
        romanization: 'jj',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c11',
        character: 'ㅊ',
        romanization: 'ch',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c12',
        character: 'ㅋ',
        romanization: 'kh',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c13',
        character: 'ㅌ',
        romanization: 'th',
        category: 'consonant',
      ),
      const HangulLetter(
        id: 'c14',
        character: 'ㅍ',
        romanization: 'ph/f',
        category: 'consonant',
      ),
    ],
  ),

  // Voyelles avancées (11)
  HangulCategory(
    id: 'vowels_advanced',
    name: 'Voyelles avancées',
    description: 'Diphtongues et voyelles composées',
    letters: <HangulLetter>[
      const HangulLetter(
        id: 'va1',
        character: 'ㅐ',
        romanization: 'ae',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va2',
        character: 'ㅔ',
        romanization: 'e',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va3',
        character: 'ㅒ',
        romanization: 'yae',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va4',
        character: 'ㅖ',
        romanization: 'oe',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va5',
        character: 'ㅘ',
        romanization: 'wa',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va6',
        character: 'ㅙ',
        romanization: 'wae',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va7',
        character: 'ㅚ',
        romanization: 'oe',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va8',
        character: 'ㅝ',
        romanization: 'wo',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va9',
        character: 'ㅞ',
        romanization: 'we',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va10',
        character: 'ㅟ',
        romanization: 'wi',
        category: 'vowel_advanced',
      ),
      const HangulLetter(
        id: 'va11',
        character: 'ㅢ',
        romanization: 'ui',
        category: 'vowel_advanced',
      ),
    ],
  ),

  // Consonnes doubles (5)
  HangulCategory(
    id: 'consonants_advanced',
    name: 'Consonnes avancées',
    description: 'Consonnes doubles et spirantes',
    letters: <HangulLetter>[
      const HangulLetter(
        id: 'ca1',
        character: 'ㄲ',
        romanization: 'kk',
        category: 'consonant_advanced',
      ),
      const HangulLetter(
        id: 'ca2',
        character: 'ㄸ',
        romanization: 'tt',
        category: 'consonant_advanced',
      ),
      const HangulLetter(
        id: 'ca3',
        character: 'ㅃ',
        romanization: 'pp',
        category: 'consonant_advanced',
      ),
      const HangulLetter(
        id: 'ca4',
        character: 'ㅆ',
        romanization: 'ss',
        category: 'consonant_advanced',
      ),
      const HangulLetter(
        id: 'ca5',
        character: 'ㅎ',
        romanization: 'h',
        category: 'consonant_advanced',
      ),
    ],
  ),
];
