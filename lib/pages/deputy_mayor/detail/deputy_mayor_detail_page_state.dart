import 'package:flutter/foundation.dart';
import '../../../client/models/deputy_mayor_detail_model.dart';
import '../../../client/services/deputy_mayor_service.dart';

/// State management for DeputyMayorDetailPage.
class DeputyMayorDetailPageState extends ChangeNotifier {
  final DeputyMayorService service;
  final String apiUrl;

  DeputyMayorDetailModel? _detail;
  bool _isLoading = false;
  String? _error;

  /// Creates a [DeputyMayorDetailPageState].
  DeputyMayorDetailPageState({required this.service, required this.apiUrl});

  /// The loaded detail model.
  DeputyMayorDetailModel? get detail => _detail;

  /// Whether the page is loading.
  bool get isLoading => _isLoading;

  /// Error message, if any.
  String? get error => _error;

  /// Loads the deputy mayor detail from the service.
  Future<void> loadDetail() async {
    _setLoading(true);
    _error = null;
    try {
      final result = await service.getDeputyMayorDetail(apiUrl);
      _detail = result;
      _setLoading(false);
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
