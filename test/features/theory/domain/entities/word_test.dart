import 'package:flutter_test/flutter_test.dart';
import 'package:k_boost/features/theory/domain/entities/word.dart';

void main() {
  group('Word Entity', () {
    test('crée une instance avec les bonnes propriétés', () {
      // Crée un Word
      const word = Word(
        id: '1',
        korean: '나',
        romanisation: 'na',
        translation: 'Je/Moi',
        categoryId: '1',
      );

      // Vérifie toutes les propriétés
      expect(word.id, equals('1'));
      expect(word.korean, equals('나'));
      expect(word.romanisation, equals('na'));
      expect(word.translation, equals('Je/Moi'));
      expect(word.categoryId, equals('1'));
    });

    test('deux Words identiques sont égaux', () {
      const word1 = Word(
        id: '1',
        korean: '나',
        romanisation: 'na',
        translation: 'Je/Moi',
        categoryId: '1',
      );

      const word2 = Word(
        id: '1',
        korean: '나',
        romanisation: 'na',
        translation: 'Je/Moi',
        categoryId: '1',
      );

      expect(word1, equals(word2));
    });
  });
}
