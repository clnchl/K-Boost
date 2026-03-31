import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/example_sentence.dart';
import '../../../../../lib/features/learning/domain/usecases/get_word_examples_usecase.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/word_detail_viewmodel.dart';

void main() {
  group('WordDetailViewModel', () {
    test('loadExamples exposes AsyncData when successful', () async {
      final FakeExampleSentenceRepository repository =
          FakeExampleSentenceRepository(
        initialExamples: {
          'w1': [sampleExampleSentence()],
        },
      );
      final WordDetailViewModel viewModel = WordDetailViewModel(
        GetWordExamplesUseCase(repository),
        'w1',
      );

      await viewModel.loadExamples();

      expect(viewModel.state, isA<AsyncData<List<ExampleSentenceEntity>>>());
      final AsyncData<List<ExampleSentenceEntity>> state =
          viewModel.state as AsyncData<List<ExampleSentenceEntity>>;
      expect(state.value, hasLength(1));
      expect(state.value.first.sentence, '나는 밥을 먹어요.');
    });

    test('loadExamples exposes AsyncError when repository fails', () async {
      final FakeExampleSentenceRepository repository =
          FakeExampleSentenceRepository(
        error: Exception('load examples failed'),
      );
      final WordDetailViewModel viewModel = WordDetailViewModel(
        GetWordExamplesUseCase(repository),
        'w1',
      );

      await viewModel.loadExamples();

      expect(viewModel.state, isA<AsyncError<List<ExampleSentenceEntity>>>());
    });
  });
}
