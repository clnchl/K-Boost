import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/word.dart';
import '../../../../../lib/features/learning/domain/usecases/get_words_usecase.dart';
import '../../../../../lib/features/learning/presentation/screens/theory_screen.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/learning_providers.dart';

void main() {
  Widget buildTestApp({required GetWordsUseCase wordsUseCase}) {
    return ProviderScope(
      overrides: <Override>[
        getWordsUseCaseProvider.overrideWithValue(wordsUseCase),
      ],
      child: const MaterialApp(home: TheoryScreen()),
    );
  }

  group('TheoryScreen', () {
    testWidgets('filters words by search query', (WidgetTester tester) async {
      final GetWordsUseCase wordsUseCase = GetWordsUseCase(
        FakeWordRepository(
          initialWords: <WordEntity>[
            sampleWord(
              id: 'w1',
              word: '사람',
              translation: 'personne',
              romanization: 'saram',
              category: 'subject',
              theme: 'education',
            ),
            sampleWord(
              id: 'w2',
              word: '먹다',
              translation: 'manger',
              romanization: 'meokda',
              category: 'action',
              theme: 'restaurant',
              particle: null,
            ),
          ],
        ),
      );

      await tester.pumpWidget(buildTestApp(wordsUseCase: wordsUseCase));
      await tester.pump();
      await tester.pump();

      expect(find.text('사람'), findsOneWidget);
      expect(find.text('먹다'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'manger');
      await tester.pumpAndSettle();

      expect(find.text('먹다'), findsOneWidget);
      expect(find.text('사람'), findsNothing);
    });

    testWidgets('filters words by theme chip', (WidgetTester tester) async {
      final GetWordsUseCase wordsUseCase = GetWordsUseCase(
        FakeWordRepository(
          initialWords: <WordEntity>[
            sampleWord(
              id: 'w1',
              word: '사람',
              category: 'subject',
              theme: 'education',
            ),
            sampleWord(
              id: 'w2',
              word: '먹다',
              translation: 'manger',
              romanization: 'meokda',
              category: 'action',
              theme: 'restaurant',
              particle: null,
            ),
          ],
        ),
      );

      await tester.pumpWidget(buildTestApp(wordsUseCase: wordsUseCase));
      await tester.pump();
      await tester.pump();

      final Finder restaurantChip = find.widgetWithText(
        ChoiceChip,
        'Restaurant',
      );
      await tester.ensureVisible(restaurantChip);
      await tester.tap(restaurantChip);
      await tester.pumpAndSettle();

      expect(find.text('먹다'), findsOneWidget);
      expect(find.text('사람'), findsNothing);

      final Finder allChip = find.widgetWithText(ChoiceChip, 'Tous');
      await tester.ensureVisible(allChip);
      await tester.tap(allChip);
      await tester.pumpAndSettle();

      expect(find.text('먹다'), findsOneWidget);
      expect(find.text('사람'), findsOneWidget);
    });

    testWidgets('filters words by sub-theme chip', (WidgetTester tester) async {
      final GetWordsUseCase wordsUseCase = GetWordsUseCase(
        FakeWordRepository(
          initialWords: <WordEntity>[
            sampleWord(
              id: 'w1',
              word: '엄마',
              category: 'subject',
              theme: 'family',
              subTheme: 'family_core',
            ),
            sampleWord(
              id: 'w2',
              word: '아빠',
              category: 'subject',
              theme: 'family',
              subTheme: 'family_core',
            ),
            sampleWord(
              id: 'w3',
              word: '할머니',
              category: 'subject',
              theme: 'family',
              subTheme: 'family_extended',
            ),
            sampleWord(
              id: 'w4',
              word: '학교',
              category: 'place',
              theme: 'education',
            ),
          ],
        ),
      );

      await tester.pumpWidget(buildTestApp(wordsUseCase: wordsUseCase));
      await tester.pump();
      await tester.pump();

      final Finder familyChip = find.widgetWithText(ChoiceChip, 'Famille');
      await tester.ensureVisible(familyChip);
      await tester.tap(familyChip);
      await tester.pumpAndSettle();

      expect(find.text('엄마'), findsOneWidget);
      expect(find.text('아빠'), findsOneWidget);
      expect(find.text('학교'), findsNothing);
      expect(find.text('Noyau familial'), findsOneWidget);
      expect(find.text('Famille elargie'), findsOneWidget);

      final Finder coreChip = find.widgetWithText(ChoiceChip, 'Noyau familial');
      await tester.ensureVisible(coreChip);
      await tester.tap(coreChip);
      await tester.pumpAndSettle();

      expect(find.text('엄마'), findsOneWidget);
      expect(find.text('아빠'), findsOneWidget);
      expect(find.text('할머니'), findsNothing);

      final Finder extendedChip = find.widgetWithText(
        ChoiceChip,
        'Famille elargie',
      );
      await tester.ensureVisible(extendedChip);
      await tester.tap(extendedChip);
      await tester.pumpAndSettle();

      expect(find.text('엄마'), findsNothing);
      expect(find.text('아빠'), findsNothing);
      expect(find.text('할머니'), findsOneWidget);
    });
  });
}
