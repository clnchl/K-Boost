import 'dart:convert';

import '../../domain/entities/note.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  factory NoteModel.fromJson(String source) {
    return NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
