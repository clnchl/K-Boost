import '../../domain/entities/word.dart';

class WordModel extends Word {
  const WordModel({
    required super.id,
    required super.korean,
    required super.translation,
    required super.categoryId,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: (json['id'] ?? '').toString(),
      korean: (json['korean'] ?? json['word'] ?? '').toString(),
      translation: (json['translation'] ?? '').toString(),
      categoryId: (json['categoryId'] ?? json['category_id'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'korean': korean,
      'translation': translation,
      'categoryId': categoryId,
    };
  }
}
