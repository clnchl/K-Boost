import '../../domain/entities/theme.dart';

class ThemeModel {
  const ThemeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.color,
    required this.exerciseIds,
  });

  final String id;
  final String name;
  final String description;
  final String icon;
  final String? color;
  final List<String> exerciseIds;

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String?,
      exerciseIds: List<String>.from(
        json['exerciseIds'] as List<dynamic>? ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'color': color,
      'exerciseIds': exerciseIds,
    };
  }

  ThemeEntity toEntity() {
    return ThemeEntity(
      id: id,
      name: name,
      description: description,
      icon: icon,
      color: color,
      exerciseIds: exerciseIds,
    );
  }
}
