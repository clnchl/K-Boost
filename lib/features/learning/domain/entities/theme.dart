class ThemeEntity {
  const ThemeEntity({
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
}
