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
      child: MaterialApp(
        home: const WordDetailScreen(wordId: 'w1'),
      ),
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
    testWidgets('displays loading indicator while examples are loading',
        (WidgetTester tester) async {
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

    testWidgets('displays examples when loading succeeds',
        (WidgetTester tester) async {
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

    testWidgets('displays error state when loading fails',
        (WidgetTester tester) async {
      final FakeExampleSentenceRepository repository =
          FakeExampleSentenceRepository(
        error: Exception('failure'),
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

      expect(find.text('Impossible de charger les exemples.'), findsOneWidget);
      expect(find.text('Reessayer'), findsOneWidget);
    });

    testWidgets('displays not found state when word does not exist',
        (WidgetTester tester) async {
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
