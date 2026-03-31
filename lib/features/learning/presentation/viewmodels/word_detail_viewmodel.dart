import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/example_sentence.dart';
import '../../domain/usecases/get_word_examples_usecase.dart';
import 'learning_providers.dart';

final wordDetailViewModelProvider = StateNotifierProvider.family<
    WordDetailViewModel, AsyncValue<List<ExampleSentenceEntity>>, String>(
  (Ref ref, String wordId) {
    final WordDetailViewModel viewModel =
        WordDetailViewModel(ref.watch(getWordExamplesUseCaseProvider), wordId);
    viewModel.loadExamples();
    return viewModel;
  },
);

class WordDetailViewModel
    extends StateNotifier<AsyncValue<List<ExampleSentenceEntity>>> {
  WordDetailViewModel(this._getWordExamplesUseCase, this._wordId)
      : super(const AsyncValue<List<ExampleSentenceEntity>>.loading());

  final GetWordExamplesUseCase _getWordExamplesUseCase;
  final String _wordId;

  Future<void> loadExamples() async {
    state = const AsyncValue<List<ExampleSentenceEntity>>.loading();

    try {
      final List<ExampleSentenceEntity> examples =
          await _getWordExamplesUseCase(_wordId);
      state = AsyncValue<List<ExampleSentenceEntity>>.data(examples);
    } catch (error, stackTrace) {
      state = AsyncValue<List<ExampleSentenceEntity>>.error(error, stackTrace);
    }
  }
}
