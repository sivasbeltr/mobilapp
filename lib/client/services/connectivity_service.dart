import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Service to check and monitor network connectivity
class ConnectivityService extends ChangeNotifier {
  bool _isConnected = true;
  final Connectivity _connectivity = Connectivity();

  ConnectivityService() {
    _initConnectivity();
    _setupConnectivityListener();
  }

  bool get isConnected => _isConnected;

  /// Initialize connectivity status on service creation
  Future<void> _initConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.isNotEmpty) {
      _updateConnectionStatus(connectivityResult.first);
    } else {
      _updateConnectionStatus(ConnectivityResult.none);
    }
  }

  /// Setup listener for connectivity changes
  void _setupConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);
      } else {
        _updateConnectionStatus(ConnectivityResult.none);
      }
    });
  }

  /// Update connection status based on connectivity result
  void _updateConnectionStatus(ConnectivityResult result) {
    _isConnected = result != ConnectivityResult.none;
    notifyListeners();
  }

  /// Check current connectivity status
  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if (result.isNotEmpty) {
      _updateConnectionStatus(result.first);
    } else {
      _updateConnectionStatus(ConnectivityResult.none);
    }
    return _isConnected;
  }
}
