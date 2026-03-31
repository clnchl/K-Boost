enum WordTense { past, present, future }

enum PolitenessLevel { informal, polite, formal }

extension WordTenseKey on WordTense {
  String get key {
    switch (this) {
      case WordTense.past:
        return 'past';
      case WordTense.present:
        return 'present';
      case WordTense.future:
        return 'future';
    }
  }
}

extension PolitenessLevelKey on PolitenessLevel {
  String get key {
    switch (this) {
      case PolitenessLevel.informal:
        return 'informal';
      case PolitenessLevel.polite:
        return 'polite';
      case PolitenessLevel.formal:
        return 'formal';
    }
  }
}

class WordEntity {
  static const Map<WordTense, Map<PolitenessLevel, String>>
  defaultPolitenessByTense = <WordTense, Map<PolitenessLevel, String>>{
    WordTense.present: <PolitenessLevel, String>{
      PolitenessLevel.informal: 'Informel présent (banmal).',
      PolitenessLevel.polite: 'Poli présent (아요/어요).',
      PolitenessLevel.formal: 'Formel présent (습니다/ㅂ니다).',
    },
    WordTense.past: <PolitenessLevel, String>{
      PolitenessLevel.informal: 'Informel passé (banmal).',
      PolitenessLevel.polite: 'Poli passé (았어요/었어요).',
      PolitenessLevel.formal: 'Formel passé (았습니다/었습니다).',
    },
    WordTense.future: <PolitenessLevel, String>{
      PolitenessLevel.informal: 'Informel futur.',
      PolitenessLevel.polite: 'Poli futur (을/ㄹ 거예요).',
      PolitenessLevel.formal: 'Formel futur (겠습니다).',
    },
  };

  const WordEntity({
    required this.id,
    required this.word,
    required this.translation,
    required this.romanization,
    required this.category,
    this.particle,
    required this.definition,
    required this.difficulty,
    this.audioUrl,
    required this.lessonId,
    this.politenessByTense = defaultPolitenessByTense,
  });

  final String id;
  final String word;
  final String translation;
  final String romanization;
  final String category;
  final String? particle;
  final String definition;
  final int difficulty;
  final String? audioUrl;
  final String lessonId;
  final Map<WordTense, Map<PolitenessLevel, String>> politenessByTense;
}
