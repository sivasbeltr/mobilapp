import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for checking device connectivity status
class ConnectivityService {
  /// Singleton instance
  static final ConnectivityService _instance = ConnectivityService._internal();

  /// Internal constructor
  ConnectivityService._internal();

  /// Factory constructor to return the singleton instance
  factory ConnectivityService() => _instance;

  /// Checks if the device has an active internet connection
  ///
  /// First checks if the device is connected to a network, then tests
  /// if the device can actually reach the internet by making a request
  /// to a reliable domain.
  Future<bool> hasInternetConnection() async {
    // Check if the device is connected to a network
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // If connected to a network, check if we can actually reach the internet
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Stream of connectivity status changes
  Stream<ConnectivityResult> get onConnectivityChanged =>
      Connectivity().onConnectivityChanged.map((result) => result.first);
}
