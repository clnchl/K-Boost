import '../../domain/entities/category.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_detail.dart';
import '../../domain/repositories/theory_repository.dart';

// Repository avec données mockées - sera remplacé par des appels API plus tard
class TheoryRepositoryImpl implements TheoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const Category(id: '0', name: 'Tous les mots'),
      const Category(id: '1', name: 'Pronoms'),
      const Category(id: '2', name: 'Verbes'),
      const Category(id: '3', name: 'Adjectifs'),
      const Category(id: '4', name: 'Particules'),
      const Category(id: '5', name: 'Nombres'),
      const Category(id: '6', name: 'Famille'),
    ];
  }

  @override
  Future<List<Word>> getWordsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final wordsByCategory = {
      '0': [
        // Tous les mots
        const Word(
          id: '1',
          korean: '나',
          romanisation: 'na',
          translation: 'Je/Moi',
          categoryId: '1',
        ),
        const Word(
          id: '2',
          korean: '너',
          romanisation: 'neo',
          translation: 'Tu/Toi',
          categoryId: '1',
        ),
        const Word(
          id: '4',
          korean: '먹다',
          romanisation: 'meokda',
          translation: 'Manger',
          categoryId: '2',
        ),
        const Word(
          id: '5',
          korean: '가다',
          romanisation: 'gada',
          translation: 'Aller',
          categoryId: '2',
        ),
        const Word(
          id: '7',
          korean: '크다',
          romanisation: 'keuda',
          translation: 'Grand',
          categoryId: '3',
        ),
        const Word(
          id: '8',
          korean: '작다',
          romanisation: 'jakda',
          translation: 'Petit',
          categoryId: '3',
        ),
        const Word(
          id: '15',
          korean: '은/는',
          romanisation: 'eun/neun',
          translation: 'Particule de sujet',
          categoryId: '4',
        ),
        const Word(
          id: '16',
          korean: '을/를',
          romanisation: 'eul/reul',
          translation: 'Particule d\'objet',
          categoryId: '4',
        ),
        const Word(
          id: '18',
          korean: '하나',
          romanisation: 'hana',
          translation: 'Un',
          categoryId: '5',
        ),
        const Word(
          id: '19',
          korean: '둘',
          romanisation: 'dul',
          translation: 'Deux',
          categoryId: '5',
        ),
        const Word(
          id: '23',
          korean: '아버지',
          romanisation: 'abeoji',
          translation: 'Père',
          categoryId: '6',
        ),
        const Word(
          id: '24',
          korean: '어머니',
          romanisation: 'eomeoni',
          translation: 'Mère',
          categoryId: '6',
        ),
      ],
      '1': [
        // Pronoms
        const Word(
          id: '1',
          korean: '나',
          romanisation: 'na',
          translation: 'Je/Moi',
          categoryId: '1',
        ),
        const Word(
          id: '2',
          korean: '너',
          romanisation: 'neo',
          translation: 'Tu/Toi',
          categoryId: '1',
        ),
      ],
      '2': [
        // Verbes
        const Word(
          id: '4',
          korean: '먹다',
          romanisation: 'meokda',
          translation: 'Manger',
          categoryId: '2',
        ),
        const Word(
          id: '5',
          korean: '가다',
          romanisation: 'gada',
          translation: 'Aller',
          categoryId: '2',
        ),
      ],
      '3': [
        // Adjectifs
        const Word(
          id: '7',
          korean: '크다',
          romanisation: 'keuda',
          translation: 'Grand',
          categoryId: '3',
        ),
        const Word(
          id: '8',
          korean: '작다',
          romanisation: 'jakda',
          translation: 'Petit',
          categoryId: '3',
        ),
      ],
      '4': [
        // Particules
        const Word(
          id: '15',
          korean: '은/는',
          romanisation: 'eun/neun',
          translation: 'Particule de sujet',
          categoryId: '4',
        ),
        const Word(
          id: '16',
          korean: '을/를',
          romanisation: 'eul/reul',
          translation: 'Particule d\'objet',
          categoryId: '4',
        ),
      ],
      '5': [
        // Nombres
        const Word(
          id: '18',
          korean: '하나',
          romanisation: 'hana',
          translation: 'Un',
          categoryId: '5',
        ),
        const Word(
          id: '19',
          korean: '둘',
          romanisation: 'dul',
          translation: 'Deux',
          categoryId: '5',
        ),
      ],
      '6': [
        // Famille
        const Word(
          id: '23',
          korean: '아버지',
          romanisation: 'abeoji',
          translation: 'Père',
          categoryId: '6',
        ),
        const Word(
          id: '24',
          korean: '어머니',
          romanisation: 'eomeoni',
          translation: 'Mère',
          categoryId: '6',
        ),
      ],
    };

    return wordsByCategory[categoryId] ?? [];
  }

  @override
  Future<WordDetail> getWordDetail(String wordId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final wordDetails = {
      '1': const WordDetail(
        id: '1',
        korean: '나',
        romanisation: 'na',
        translation: 'Je/Moi',
        grammaticalType: 'Pronom',
        exampleSentence:
            '나는 학생입니다 (na-neun haksaeng-imnida) - Je suis un étudiant',
      ),
      '2': const WordDetail(
        id: '2',
        korean: '너',
        romanisation: 'neo',
        translation: 'Tu/Toi',
        grammaticalType: 'Pronom',
        exampleSentence: '너는 누구니? (neoneun nuguní?) - Qui es-tu?',
      ),
      '4': const WordDetail(
        id: '4',
        korean: '먹다',
        romanisation: 'meokda',
        translation: 'Manger',
        grammaticalType: 'Verbe',
        exampleSentence:
            '나는 밥을 먹습니다 (na-neun bab-eul meok-sseumnida) - Je mange du riz',
      ),
      '5': const WordDetail(
        id: '5',
        korean: '가다',
        romanisation: 'gada',
        translation: 'Aller',
        grammaticalType: 'Verbe',
        exampleSentence: '학교에 가요 (hakgyo-e gayo) - Je vais à l\'école',
      ),
      '7': const WordDetail(
        id: '7',
        korean: '크다',
        romanisation: 'keuda',
        translation: 'Grand',
        grammaticalType: 'Adjectif',
        exampleSentence: '이 집은 크다 (i jib-eun keuda) - Cette maison est grande',
      ),
      '8': const WordDetail(
        id: '8',
        korean: '작다',
        romanisation: 'jakda',
        translation: 'Petit',
        grammaticalType: 'Adjectif',
        exampleSentence:
            '그 고양이는 작다 (geu goyang-i-neun jakda) - Ce chat est petit',
      ),
      '15': const WordDetail(
        id: '15',
        korean: '은/는',
        romanisation: 'eun/neun',
        translation: 'Particule de sujet',
        grammaticalType: 'Particule',
        exampleSentence:
            '나는 학생입니다 (na-neun haksaeng-imnida) - Je suis un étudiant',
      ),
      '16': const WordDetail(
        id: '16',
        korean: '을/를',
        romanisation: 'eul/reul',
        translation: 'Particule d\'objet',
        grammaticalType: 'Particule',
        exampleSentence: '밥을 먹습니다 (bab-eul meok-sseumnida) - Manger du riz',
      ),
      '18': const WordDetail(
        id: '18',
        korean: '하나',
        romanisation: 'hana',
        translation: 'Un',
        grammaticalType: 'Nombre',
        exampleSentence: '하나, 둘, 셋 (hana, dul, set) - Un, deux, trois',
      ),
      '19': const WordDetail(
        id: '19',
        korean: '둘',
        romanisation: 'dul',
        translation: 'Deux',
        grammaticalType: 'Nombre',
        exampleSentence: '그들은 둘입니다 (geudel-eun dul-imnida) - Ils sont deux',
      ),
      '23': const WordDetail(
        id: '23',
        korean: '아버지',
        romanisation: 'abeoji',
        translation: 'Père',
        grammaticalType: 'Nom',
        exampleSentence:
            '내 아버지는 의사입니다 (nae abeoji-neun uisa-imnida) - Mon père est médecin',
      ),
      '24': const WordDetail(
        id: '24',
        korean: '어머니',
        romanisation: 'eomeoni',
        translation: 'Mère',
        grammaticalType: 'Nom',
        exampleSentence:
            '어머니는 선생님입니다 (eomeoni-neun seongsaengnim-imnida) - Ma mère est professeur',
      ),
    };

    return wordDetails[wordId] ??
        const WordDetail(
          id: 'unknown',
          korean: '?',
          romanisation: '?',
          translation: 'Inconnu',
          grammaticalType: 'N/A',
          exampleSentence: 'N/A',
        );
  }
}
