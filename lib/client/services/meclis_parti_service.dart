import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/meclis_parti_model.dart';
import 'dio_client.dart';

/// Service class to handle API requests related to political parties in the municipal council
class MeclisPartiService {
  final Dio _dio = DioClient().dio;

  /// Fetches the list of political parties represented in the municipal council
  ///
  /// Returns a [Future] that completes with a list of [MeclisPartiModel]
  Future<List<MeclisPartiModel>> getMeclisPartiler() async {
    try {
      final response = await _dio.get('/meclis-uyeleri');

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => MeclisPartiModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load council parties');
      }
    } catch (e) {
      throw Exception('Error fetching council parties data: $e');
    }
  }
}
