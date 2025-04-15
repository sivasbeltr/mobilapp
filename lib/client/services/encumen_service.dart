import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/encumen_model.dart';
import 'dio_client.dart';

/// Service class to handle API requests related to municipal committee members
class EncumenService {
  final Dio _dio = DioClient().dio;

  /// Fetches the list of municipal committee members (encümen)
  ///
  /// Returns a [Future] that completes with a list of [EncumenModel]
  Future<List<EncumenModel>> getEncumenUyeleri() async {
    try {
      final response = await _dio.get('/encumen-uyeleri');

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => EncumenModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load committee members');
      }
    } catch (e) {
      throw Exception('Error fetching committee members data: $e');
    }
  }
}
