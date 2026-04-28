import 'dart:convert';
import 'package:http/http.dart' as http;

import 'theory_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/word_detail_model.dart';
import '../models/word_model.dart';

class TheoryRemoteDataSourceImpl implements TheoryRemoteDataSource {
  const TheoryRemoteDataSourceImpl({required this.baseUrl});

  final String baseUrl;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final uri = Uri.parse('$baseUrl/theory/categories');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erreur API: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<WordModel>> getWordsByCategory(String categoryId) async {
    final uri = Uri.parse('$baseUrl/theory/categories/$categoryId/words');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erreur API: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => WordModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WordDetailModel> getWordDetail(String wordId) async {
    final uri = Uri.parse('$baseUrl/theory/words/$wordId');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erreur API: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return WordDetailModel.fromJson(data);
  }
}