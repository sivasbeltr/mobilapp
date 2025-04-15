import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/meclis_model.dart';
import '../models/meclis_parti_model.dart';
import 'dio_client.dart';
import 'meclis_parti_service.dart';

/// Service class to handle API requests related to council members
class MeclisService {
  final Dio _dio = DioClient().dio;
  final MeclisPartiService _partiService = MeclisPartiService();

  /// Fetches council members for a specific political party using its API URL
  ///
  /// [apiUrl] is the API URL for the specific party's members
  /// Returns a [Future] that completes with a list of [MeclisModel]
  Future<List<MeclisModel>> getMeclisUyeleriByParti(String apiUrl) async {
    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        // Decode the JSON string into a Dart object
        final List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => MeclisModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load council members for this party');
      }
    } catch (e) {
      throw Exception('Error fetching council members data: $e');
    }
  }

  /// Fetches all council members from all parties
  ///
  /// This method fetches all parties first, then fetches the members of each party
  /// and combines them into a single list
  /// Returns a [Future] that completes with a list of [MeclisModel]
  Future<List<MeclisModel>> getAllMeclisUyeleri() async {
    try {
      // First, get all political parties
      final List<MeclisPartiModel> partiler =
          await _partiService.getMeclisPartiler();

      // Create a list to hold all council members
      final List<MeclisModel> allMembers = [];

      // For each party, fetch its members and add them to the allMembers list
      for (final parti in partiler) {
        if (parti.apiUrl != null) {
          final members = await getMeclisUyeleriByParti(parti.apiUrl!);
          allMembers.addAll(members);
        }
      }

      return allMembers;
    } catch (e) {
      throw Exception('Error fetching all council members: $e');
    }
  }
}
