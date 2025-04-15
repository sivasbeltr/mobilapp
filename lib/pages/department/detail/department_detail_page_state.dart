import 'package:flutter/foundation.dart';

import '../../../client/models/department_detail_model.dart';
import '../../../client/services/department_service.dart';

/// State management class for the Department Detail Page.
class DepartmentDetailPageState extends ChangeNotifier {
  /// Service for fetching department detail data.
  final DepartmentService service;

  /// The API URL to fetch the department details.
  final String apiUrl;

  /// Whether the data is currently being loaded.
  bool isLoading = false;

  /// Error message if data loading fails.
  String? error;

  /// The department detail data.
  DepartmentDetailModel? _departmentDetail;

  /// Get the department detail data.
  DepartmentDetailModel? get departmentDetail => _departmentDetail;

  /// Creates a [DepartmentDetailPageState] with the required service and API URL.
  DepartmentDetailPageState({
    required this.service,
    required this.apiUrl,
  });

  /// Loads the department detail from the service.
  Future<void> loadDepartmentDetail() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final detail = await service.getDepartmentDetail(apiUrl);
      _departmentDetail = detail;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      if (kDebugMode) {
        print('Error loading department detail: $e');
      }
    }
  }
}
