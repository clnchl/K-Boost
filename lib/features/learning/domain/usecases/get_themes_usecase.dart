import '../entities/theme.dart';
import '../repositories/theme_repository.dart';

class GetThemesUseCase {
  const GetThemesUseCase(this._repository);

  final ThemeRepository _repository;

  Future<List<ThemeEntity>> call() {
    return _repository.getThemes();
  }
}
