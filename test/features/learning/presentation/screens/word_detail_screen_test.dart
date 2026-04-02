import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/example_sentence.dart';
import '../../../../../lib/features/learning/domain/entities/word.dart';
import '../../../../../lib/features/learning/domain/repositories/example_sentence_repository.dart';
import '../../../../../lib/features/learning/domain/repositories/word_repository.dart';
import '../../../../../lib/features/learning/domain/usecases/get_word_by_id_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_word_examples_usecase.dart';
import '../../../../../lib/features/learning/presentation/screens/word_detail_screen.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/learning_providers.dart';

class PendingExampleSentenceRepository implements ExampleSentenceRepository {
  @override
  Future<List<ExampleSentenceEntity>> getExamplesByWordId(String wordId) {
    final Completer<List<ExampleSentenceEntity>> completer =
        Completer<List<ExampleSentenceEntity>>();
    return completer.future;
  }
}

void main() {
  Widget buildTestApp({
    required GetWordExamplesUseCase examplesUseCase,
    required GetWordByIdUseCase wordByIdUseCase,
  }) {
    return ProviderScope(
      overrides: <Override>[
        getWordExamplesUseCaseProvider.overrideWithValue(examplesUseCase),
        getWordByIdUseCaseProvider.overrideWithValue(wordByIdUseCase),
      ],
      child: MaterialApp(home: const WordDetailScreen(wordId: 'w1')),
    );
  }

  GetWordByIdUseCase buildWordByIdUseCase() {
    final WordRepository wordRepository = FakeWordRepository(
      initialWords: <WordEntity>[sampleWord(id: 'w1')],
    );

    return GetWordByIdUseCase(wordRepository);
  }

  GetWordByIdUseCase buildWordByIdUseCaseNotFound() {
    final WordRepository wordRepository = FakeWordRepository(
      initialWords: <WordEntity>[],
    );

    return GetWordByIdUseCase(wordRepository);
  }

  group('WordDetailScreen', () {
    testWidgets('displays loading indicator while examples are loading', (
      WidgetTester tester,
    ) async {
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(
        PendingExampleSentenceRepository(),
      );

      await tester.pumpWidget(
        buildTestApp(
          examplesUseCase: useCase,
          wordByIdUseCase: buildWordByIdUseCase(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays examples when loading succeeds', (
      WidgetTester tester,
    ) async {
      final FakeExampleSentenceRepository repository =
          FakeExampleSentenceRepository(
            initialExamples: <String, List<ExampleSentenceEntity>>{
              'w1': <ExampleSentenceEntity>[sampleExampleSentence()],
            },
          );
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(repository);

      await tester.pumpWidget(
        buildTestApp(
          examplesUseCase: useCase,
          wordByIdUseCase: buildWordByIdUseCase(),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Exemples'), findsOneWidget);
      expect(find.text('나는 밥을 먹어요.'), findsOneWidget);
      expect(find.text('naneun babeul meogeoyo.'), findsOneWidget);
      expect(find.text('Je mange du riz.'), findsOneWidget);
    });

    testWidgets('opens particle info bubble on particle tap', (
      WidgetTester tester,
    ) async {
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(
        FakeExampleSentenceRepository(),
      );
      final GetWordByIdUseCase wordByIdUseCase = GetWordByIdUseCase(
        FakeWordRepository(
          initialWords: <WordEntity>[sampleWord(id: 'w1', particle: '은/는')],
        ),
      );

      await tester.pumpWidget(
        buildTestApp(
          examplesUseCase: useCase,
          wordByIdUseCase: wordByIdUseCase,
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('은/는'), findsOneWidget);
      expect(find.text('은'), findsNothing);
      expect(find.text('는'), findsNothing);

      final Finder particleChip = find.text('은/는').first;
      await tester.ensureVisible(particleChip);
      await tester.tap(particleChip, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.textContaining('Nom : Theme'), findsOneWidget);
      expect(find.textContaining('Particule : 은 / 는'), findsOneWidget);
      expect(
        find.textContaining('Description : Indique le theme'),
        findsOneWidget,
      );
      expect(find.text('저는 한국어를 배워요.'), findsOneWidget);
      expect(find.text('Moi, j\'apprends le coreen.'), findsOneWidget);
    });

    testWidgets(
      'hides tense and politeness for non-verb words but keeps particles',
      (WidgetTester tester) async {
        final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(
          FakeExampleSentenceRepository(),
        );
        final GetWordByIdUseCase wordByIdUseCase = GetWordByIdUseCase(
          FakeWordRepository(
            initialWords: <WordEntity>[
              sampleWord(
                id: 'w1',
                word: '사람',
                category: 'subject',
                particle: '은/는',
              ),
            ],
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            examplesUseCase: useCase,
            wordByIdUseCase: wordByIdUseCase,
          ),
        );
        await tester.pump();
        await tester.pump();

        expect(find.text('Particules'), findsOneWidget);
        expect(find.text('은/는'), findsOneWidget);
        expect(find.text('Temps'), findsNothing);
        expect(find.text('Niveau de politesse'), findsNothing);
      },
    );

    testWidgets('shows Hangul details and hides irrelevant grammar sections', (
      WidgetTester tester,
    ) async {
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(
        FakeExampleSentenceRepository(),
      );
      final GetWordByIdUseCase wordByIdUseCase = GetWordByIdUseCase(
        FakeWordRepository(
          initialWords: <WordEntity>[
            sampleWord(
              id: 'w1',
              word: 'ㄱ',
              translation: 'consonne giyeok',
              romanization: 'giyeok',
              category: 'symbol',
              theme: 'hangul',
              subTheme: 'hangul_consonants',
              particle: null,
              definition: 'Lettre consonne de l\'alphabet hangul.',
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        buildTestApp(
          examplesUseCase: useCase,
          wordByIdUseCase: wordByIdUseCase,
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Details hangul'), findsOneWidget);
      expect(find.text('Particules'), findsNothing);
      expect(find.text('Temps'), findsNothing);
      expect(find.text('Niveau de politesse'), findsNothing);

      expect(find.text('Position dans la syllabe'), findsOneWidget);
      expect(
        find.text('Debut (초성) et fin (종성/받침) de syllabe.'),
        findsOneWidget,
      );
      expect(find.text('Son en debut (초성)'), findsOneWidget);
      expect(find.text('g/k'), findsOneWidget);
      expect(find.text('Son en fin (종성/받침)'), findsOneWidget);
      expect(find.text('k'), findsOneWidget);
    });

    testWidgets(
      'switches between informelle, poli, formelle and keeps tense context',
      (WidgetTester tester) async {
        final FakeExampleSentenceRepository repository =
            FakeExampleSentenceRepository(
              initialExamples: <String, List<ExampleSentenceEntity>>{
                'w1': <ExampleSentenceEntity>[sampleExampleSentence()],
              },
            );
        final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(
          repository,
        );
        final GetWordByIdUseCase wordByIdUseCase = GetWordByIdUseCase(
          FakeWordRepository(
            initialWords: <WordEntity>[
              sampleWord(
                id: 'w1',
                word: '먹다',
                category: 'action',
                politenessByTense:
                    const <WordTense, Map<PolitenessLevel, String>>{
                      WordTense.present: <PolitenessLevel, String>{
                        PolitenessLevel.informal: 'Informelle present test.',
                        PolitenessLevel.polite: 'Poli present test.',
                        PolitenessLevel.formal: 'Formelle present test.',
                      },
                      WordTense.future: <PolitenessLevel, String>{
                        PolitenessLevel.formal: 'Formelle futur test.',
                      },
                    },
              ),
            ],
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            examplesUseCase: useCase,
            wordByIdUseCase: wordByIdUseCase,
          ),
        );
        await tester.pump();
        await tester.pump();

        expect(find.text('Niveau de politesse'), findsOneWidget);
        expect(find.text('Poli present test.'), findsOneWidget);

        final Finder informelleChip = find.widgetWithText(
          ChoiceChip,
          'Informelle',
        );
        await tester.ensureVisible(informelleChip);
        await tester.tap(informelleChip);
        await tester.pumpAndSettle();
        expect(find.text('Informelle present test.'), findsOneWidget);

        final Finder formelleChip = find.widgetWithText(ChoiceChip, 'Formelle');
        await tester.ensureVisible(formelleChip);
        await tester.tap(formelleChip);
        await tester.pumpAndSettle();
        expect(find.text('Formelle present test.'), findsOneWidget);

        final Finder futurChip = find.widgetWithText(ChoiceChip, 'Futur');
        await tester.ensureVisible(futurChip);
        await tester.tap(futurChip);
        await tester.pumpAndSettle();
        expect(find.text('Formelle futur test.'), findsOneWidget);

        await tester.tap(informelleChip);
        await tester.pumpAndSettle();
        expect(
          find.textContaining('Information indisponible pour futur'),
          findsOneWidget,
        );
      },
    );

    testWidgets('displays error state when loading fails', (
      WidgetTester tester,
    ) async {
      final FakeExampleSentenceRepository repository =
          FakeExampleSentenceRepository(error: Exception('failure'));
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(repository);

      await tester.pumpWidget(
        buildTestApp(
          examplesUseCase: useCase,
          wordByIdUseCase: buildWordByIdUseCase(),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Impossible de charger les exemples.'), findsOneWidget);
      expect(find.text('Reessayer'), findsOneWidget);
    });

    testWidgets('displays not found state when word does not exist', (
      WidgetTester tester,
    ) async {
      final GetWordExamplesUseCase useCase = GetWordExamplesUseCase(
        FakeExampleSentenceRepository(),
      );

      await tester.pumpWidget(
        buildTestApp(
          examplesUseCase: useCase,
          wordByIdUseCase: buildWordByIdUseCaseNotFound(),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Mot introuvable.'), findsOneWidget);
      expect(find.text('Reessayer'), findsOneWidget);
    });
  });
}
