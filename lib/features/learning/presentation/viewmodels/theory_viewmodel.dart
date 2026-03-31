import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/word.dart';
import '../../domain/usecases/get_words_usecase.dart';
import 'learning_providers.dart';

final theoryViewModelProvider =
    StateNotifierProvider<TheoryViewModel, AsyncValue<List<WordEntity>>>(
  (Ref ref) {
    final TheoryViewModel viewModel =
        TheoryViewModel(ref.watch(getWordsUseCaseProvider));
    viewModel.loadWords();
    return viewModel;
  },
);

class TheoryViewModel extends StateNotifier<AsyncValue<List<WordEntity>>> {
  TheoryViewModel(this._getWordsUseCase)
      : super(const AsyncValue<List<WordEntity>>.loading());

  final GetWordsUseCase _getWordsUseCase;

  Future<void> loadWords() async {
    state = const AsyncValue<List<WordEntity>>.loading();

    try {
      final List<WordEntity> words = await _getWordsUseCase();
      state = AsyncValue<List<WordEntity>>.data(words);
    } catch (error, stackTrace) {
      state = AsyncValue<List<WordEntity>>.error(error, stackTrace);
    }
  }
}
