import '../../domain/entities/word.dart';

class WordModel extends Word {
  const WordModel({
    required super.id,
    required super.korean,
    required super.romanisation,
    required super.translation,
    required super.categoryId,
  });

  // Convertit JSON du backend → WordModel
  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'] as String,
      korean: json['korean'] as String,
      romanisation: json['romanisation'] as String,
      translation: json['translation'] as String,
      categoryId: json['categoryId'] as String,
    );
  }

  // Convertit WordModel → JSON pour le backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'korean': korean,
      'romanisation': romanisation,
      'translation': translation,
      'categoryId': categoryId,
    };
  }
}
