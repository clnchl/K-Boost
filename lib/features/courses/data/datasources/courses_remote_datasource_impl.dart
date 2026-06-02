import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/api_config.dart';
import '../models/hangul_exercise_model.dart';
import 'courses_remote_datasource.dart';

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  CoursesRemoteDataSourceImpl({String? baseUrl})
      : baseUrl = baseUrl ?? ApiConfig.baseUrl;

  final String baseUrl;

  @override
  Future<List<HangulExerciseModel>> getHangulExercises() async {
    final uri = Uri.parse('$baseUrl/courses/hangul/exercises');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erreur API: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => HangulExerciseModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<HangulExerciseModel>> getHangulQuizSession({int count = 10}) async {
    final uri = Uri.parse(
      '$baseUrl/courses/hangul/exercises/session?count=$count',
    );
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erreur API: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => HangulExerciseModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
