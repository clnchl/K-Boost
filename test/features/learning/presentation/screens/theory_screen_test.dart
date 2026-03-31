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
            ),
            sampleWord(
              id: 'w2',
              word: '먹다',
              translation: 'manger',
              romanization: 'meokda',
              category: 'action',
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

    testWidgets('filters words by category chip', (WidgetTester tester) async {
      final GetWordsUseCase wordsUseCase = GetWordsUseCase(
        FakeWordRepository(
          initialWords: <WordEntity>[
            sampleWord(id: 'w1', word: '사람', category: 'subject'),
            sampleWord(
              id: 'w2',
              word: '먹다',
              translation: 'manger',
              romanization: 'meokda',
              category: 'action',
              particle: null,
            ),
          ],
        ),
      );

      await tester.pumpWidget(buildTestApp(wordsUseCase: wordsUseCase));
      await tester.pump();
      await tester.pump();

      final Finder actionChip = find.widgetWithText(ChoiceChip, 'Action');
      await tester.ensureVisible(actionChip);
      await tester.tap(actionChip);
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
  });
}
