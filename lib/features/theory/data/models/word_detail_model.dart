import '../../domain/entities/word_detail.dart';

class WordDetailModel extends WordDetail {
  const WordDetailModel({
    required super.id,
    required super.korean,
    required super.translation,
    required super.definition,
    super.example,
  });

  factory WordDetailModel.fromJson(Map<String, dynamic> json) {
    return WordDetailModel(
      id: (json['id'] ?? '').toString(),
      korean: (json['korean'] ?? json['name'] ?? '').toString(),
      translation: (json['translation'] ?? '').toString(),
      definition: (json['definition'] ?? '').toString(),
      example: json['example']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'korean': korean,
      'translation': translation,
      'definition': definition,
      if (example != null) 'example': example,
    };
  }
}
