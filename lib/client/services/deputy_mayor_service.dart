import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/deputy_mayor_detail_model.dart';
import '../models/deputy_mayor_model.dart';
import 'dio_client.dart';

class DeputyMayorService {
  final Dio _dio = DioClient().dio;

  Future<List<DeputyMayor>> getDeputyMayors() async {
    try {
      final response = await _dio.get('/baskan-yardimcilari');

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => DeputyMayor.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load deputy mayors');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<DeputyMayorDetailModel> getDeputyMayorDetail(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final Map<String, dynamic> data = jsonDecode(response.data);
        return DeputyMayorDetailModel.fromJson(data);
      } else {
        throw Exception('Failed to load deputy mayor detail');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
