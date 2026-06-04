import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({required super.id, required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json['id'] ?? json['uuid'] ?? '').toString(),
      name: (json['name'] ?? json['title'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
