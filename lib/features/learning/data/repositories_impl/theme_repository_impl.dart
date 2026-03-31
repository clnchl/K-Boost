import '../../domain/entities/theme.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/learning_local_datasource.dart';
import '../models/theme_model.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._datasource);

  final LearningLocalDatasource _datasource;

  @override
  Future<List<ThemeEntity>> getThemes() async {
    final List<ThemeModel> themes = await _datasource.fetchThemes();
    return themes.map((ThemeModel theme) => theme.toEntity()).toList();
  }
}
