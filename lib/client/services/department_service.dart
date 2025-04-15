import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/department_detail_model.dart';
import '../models/department_model.dart';
import 'dio_client.dart';

/// Service class to handle API requests related to departments
class DepartmentService {
  final Dio _dio = DioClient().dio;

  /// Fetches the list of departments from the API
  ///
  /// Returns a [Future] that completes with a list of [DepartmentModel]
  Future<List<DepartmentModel>> getDepartments() async {
    try {
      final response = await _dio.get('/mudurlukler');

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => DepartmentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      throw Exception('Error fetching department data: $e');
    }
  }

  /// Fetches the details of a specific department using its URL
  ///
  /// [url] is the API URL for the specific department
  /// Returns a [Future] that completes with a [DepartmentModel]
  Future<DepartmentDetailModel> getDepartmentDetail(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final Map<String, dynamic> data = jsonDecode(response.data);
        return DepartmentDetailModel.fromJson(data);
      } else {
        throw Exception('Failed to load department detail');
      }
    } catch (e) {
      throw Exception('Error fetching department detail data: $e');
    }
  }
}
