import 'package:flutter/foundation.dart';

import '../../client/models/deputy_mayor_model.dart';
import '../../client/services/deputy_mayor_service.dart';

/// State management for the DeputyMayorListPage.
class DeputyMayorListPageState extends ChangeNotifier {
  /// Service to fetch deputy mayor data
  final DeputyMayorService service;

  /// List of deputy mayors
  List<DeputyMayor> _deputyMayors = [];

  /// Loading state flag
  bool _isLoading = false;

  /// Error message if any
  String? _error;

  /// Creates a [DeputyMayorListPageState].
  DeputyMayorListPageState({
    required this.service,
  });

  /// Gets the current list of deputy mayors.
  List<DeputyMayor> get deputyMayors => _deputyMayors;

  /// Gets the current loading state.
  bool get isLoading => _isLoading;

  /// Gets the current error message, if any.
  String? get error => _error;

  /// Loads the deputy mayors from the service.
  Future<void> loadDeputyMayors() async {
    _setLoading(true);
    _error = null;

    try {
      final deputyMayors = await service.getDeputyMayors();
      _deputyMayors = deputyMayors;
      _setLoading(false);
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
    }
  }

  /// Updates the loading state and notifies listeners.
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
