import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/word.dart';
import '../../domain/usecases/get_word_by_id_usecase.dart';
import 'learning_providers.dart';

final wordByIdViewModelProvider = StateNotifierProvider.family<
    WordByIdViewModel, AsyncValue<WordEntity?>, String>(
  (Ref ref, String wordId) {
    final WordByIdViewModel viewModel =
        WordByIdViewModel(ref.watch(getWordByIdUseCaseProvider), wordId);
    viewModel.loadWord();
    return viewModel;
  },
);

class WordByIdViewModel extends StateNotifier<AsyncValue<WordEntity?>> {
  WordByIdViewModel(this._getWordByIdUseCase, this._wordId)
      : super(const AsyncValue<WordEntity?>.loading());

  final GetWordByIdUseCase _getWordByIdUseCase;
  final String _wordId;

  Future<void> loadWord() async {
    state = const AsyncValue<WordEntity?>.loading();

    try {
      final WordEntity? word = await _getWordByIdUseCase(_wordId);
      state = AsyncValue<WordEntity?>.data(word);
    } catch (error, stackTrace) {
      state = AsyncValue<WordEntity?>.error(error, stackTrace);
    }
  }
}
