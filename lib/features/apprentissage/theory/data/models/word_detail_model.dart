import '../../domain/entities/word_detail.dart';

// Model: Word Detail avec sérialisation JSON
class WordDetailModel extends WordDetail {
  const WordDetailModel({
    required super.id,
    required super.korean,
    required super.romanisation,
    required super.translation,
    required super.grammaticalType,
    required super.exampleSentence,
  });

  // JSON du backend → WordDetailModel
  factory WordDetailModel.fromJson(Map<String, dynamic> json) {
    return WordDetailModel(
      id: json['id'] as String,
      korean: json['korean'] as String,
      romanisation: json['romanisation'] as String,
      translation: json['translation'] as String,
      grammaticalType: json['grammaticalType'] as String,
      exampleSentence: json['exampleSentence'] as String,
    );
  }

  // WordDetailModel → JSON pour le backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'korean': korean,
      'romanisation': romanisation,
      'translation': translation,
      'grammaticalType': grammaticalType,
      'exampleSentence': exampleSentence,
    };
  }
}
