import '../entities/theme.dart';

abstract class ThemeRepository {
  Future<List<ThemeEntity>> getThemes();
}
