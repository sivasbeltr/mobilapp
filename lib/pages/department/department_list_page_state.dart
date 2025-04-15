import 'package:flutter/foundation.dart';

import '../../client/models/department_model.dart';
import '../../client/services/department_service.dart';

/// State management class for the Department List Page.
class DepartmentListPageState extends ChangeNotifier {
  /// Service for fetching department data.
  final DepartmentService service;

  /// Whether the data is currently being loaded.
  bool isLoading = false;

  /// Error message if data loading fails.
  String? error;

  /// List of all departments.
  List<DepartmentModel> _departments = [];

  /// Filtered list of departments based on search query.
  List<DepartmentModel> _filteredDepartments = [];

  /// Get the filtered departments list.
  List<DepartmentModel> get filteredDepartments => _filteredDepartments;

  /// Creates a [DepartmentListPageState] with the required service.
  DepartmentListPageState({
    required this.service,
  });

  /// Loads the list of departments from the service.
  Future<void> loadDepartments() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final departments = await service.getDepartments();
      _departments = departments;
      _filteredDepartments = List.from(_departments);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      if (kDebugMode) {
        print('Error loading departments: $e');
      }
    }
  }

  /// Filters the departments list based on the search query.
  void filterDepartments(String query) {
    if (query.isEmpty) {
      _filteredDepartments = List.from(_departments);
    } else {
      final normalizedQuery = _normalizeText(query);
      _filteredDepartments = _departments.where((department) {
        final normalizedTitle = _normalizeText(department.title);
        return normalizedTitle.contains(normalizedQuery);
      }).toList();
    }
    notifyListeners();
  }

  /// Normalizes text by removing diacritics and converting to lowercase
  /// for better Turkish language search.
  String _normalizeText(String text) {
    // Convert to lowercase
    String result = text.toLowerCase();

    // Replace Turkish characters with their non-diacritic equivalents
    final Map<String, String> turkishChars = {
      'ç': 'c',
      'ğ': 'g',
      'ı': 'i',
      'ö': 'o',
      'ş': 's',
      'ü': 'u',
      'Ç': 'c',
      'Ğ': 'g',
      'İ': 'i',
      'Ö': 'o',
      'Ş': 's',
      'Ü': 'u'
    };

    turkishChars.forEach((key, value) {
      result = result.replaceAll(key, value);
    });

    return result;
  }
}
