import 'package:flutter_test/flutter_test.dart';
import 'package:k_boost/features/apprentissage/theory/domain/entities/word.dart';

void main() {
  test('Word Entity stocke correctement les propriétés', () {
    const word = Word(
      id: '1',
      korean: '나',
      romanisation: 'na',
      translation: 'Je/Moi',
      categoryId: '1',
    );

    expect(word.korean, equals('나'));
    expect(word.translation, equals('Je/Moi'));
    expect(word.categoryId, equals('1'));
  });
}
