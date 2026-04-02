import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/word.dart';
import '../../../../../lib/features/learning/presentation/widgets/word_card.dart';

void main() {
  Widget buildTestApp({required WordEntity word, required VoidCallback onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: WordCard(word: word, onTap: onTap),
        ),
      ),
    );
  }

  group('WordCard', () {
    testWidgets('shows key metadata and present polite preview', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      final WordEntity word = sampleWord(
        id: 'w10',
        word: '먹다',
        translation: 'manger',
        romanization: 'meokda',
        category: 'action',
        particle: '을/를',
        lessonId: 'l2',
        difficulty: 2,
        politenessByTense: const <WordTense, Map<PolitenessLevel, String>>{
          WordTense.present: <PolitenessLevel, String>{
            PolitenessLevel.polite: 'Poli: 먹어요.',
          },
        },
      );

      await tester.pumpWidget(
        buildTestApp(
          word: word,
          onTap: () {
            tapped = true;
          },
        ),
      );

      expect(find.text('먹다'), findsOneWidget);
      expect(find.text('manger'), findsOneWidget);
      expect(find.text('Particule 을/를'), findsOneWidget);
      expect(find.text('Leçon 2'), findsOneWidget);
      expect(find.text('Niveau 2'), findsOneWidget);
      expect(find.text('Poli: 먹어요.'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      expect(tapped, isTrue);
    });

    testWidgets('falls back to default present polite preview when missing', (
      WidgetTester tester,
    ) async {
      final WordEntity word = sampleWord(
        politenessByTense: const <WordTense, Map<PolitenessLevel, String>>{
          WordTense.present: <PolitenessLevel, String>{},
        },
      );

      await tester.pumpWidget(buildTestApp(word: word, onTap: () {}));

      expect(find.textContaining('Poli présent'), findsOneWidget);
    });
  });
}
