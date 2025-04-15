import 'package:flutter/foundation.dart';
import '../../client/models/encumen_model.dart';
import '../../client/services/encumen_service.dart';

/// State management for the Encumen page
class EncumenPageState extends ChangeNotifier {
  /// Service for fetching committee member data
  final EncumenService service;

  /// List of committee members
  List<EncumenModel> _encumenMembers = [];

  /// Loading state
  bool _isLoading = false;

  /// Error information if fetching fails
  String? _error;

  /// Creates a new [EncumenPageState] with the needed service
  EncumenPageState({required this.service});

  /// Getter for committee members list
  List<EncumenModel> get encumenMembers => _encumenMembers;

  /// Getter for loading state
  bool get isLoading => _isLoading;

  /// Getter for error information
  String? get error => _error;

  /// Loads committee members from the service
  Future<void> loadEncumen() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _encumenMembers = await service.getEncumenUyeleri();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
