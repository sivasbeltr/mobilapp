import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/mayor_selection_model.dart';
import 'dio_client.dart';

/// Service class to handle API requests related to the mayor
class MayorService {
  final Dio _dio = DioClient().dio;

  /// Fetches the selections (photos) from the mayor
  ///
  /// Returns a [Future] that completes with a [MayorSelectionModel]
  Future<MayorSelectionModel> getMayorSelections() async {
    try {
      final response = await _dio.get('/sayfa/baskan-dan-secmeler');

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final Map<String, dynamic> data = jsonDecode(response.data);
        return MayorSelectionModel.fromJson(data);
      } else {
        throw Exception('Failed to load mayor selections');
      }
    } catch (e) {
      throw Exception('Error fetching mayor selections data: $e');
    }
  }
}
