import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/theme.dart';
import '../../domain/usecases/get_themes_usecase.dart';
import 'learning_providers.dart';

final themeViewModelProvider =
    StateNotifierProvider<ThemeViewModel, AsyncValue<List<ThemeEntity>>>((
      Ref ref,
    ) {
      final ThemeViewModel viewModel = ThemeViewModel(
        ref.watch(getThemesUseCaseProvider),
      );
      viewModel.loadThemes();
      return viewModel;
    });

class ThemeViewModel extends StateNotifier<AsyncValue<List<ThemeEntity>>> {
  ThemeViewModel(this._getThemesUseCase)
    : super(const AsyncValue<List<ThemeEntity>>.loading());

  final GetThemesUseCase _getThemesUseCase;

  Future<void> loadThemes() async {
    state = const AsyncValue<List<ThemeEntity>>.loading();

    try {
      final List<ThemeEntity> themes = await _getThemesUseCase();
      state = AsyncValue<List<ThemeEntity>>.data(themes);
    } catch (error, stackTrace) {
      state = AsyncValue<List<ThemeEntity>>.error(error, stackTrace);
    }
  }
}
