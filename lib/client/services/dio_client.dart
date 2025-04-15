import 'dart:io';
import 'package:dio/dio.dart';

/// Base configuration for API endpoints
class ApiConfig {
  static const String baseUrl = 'https://www.sivas.bel.tr/api';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}

/// DioClient singleton for HTTP operations
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  /// Factory constructor to return the same instance
  factory DioClient() {
    return _instance;
  }

  /// Private constructor for singleton pattern
  DioClient._internal() {
    dio = Dio();
    _initialize();
  }

  /// Initializes the Dio instance with proper configuration
  void _initialize() {
    dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      responseType: ResponseType.json,
    );

    // Configure SSL bypass
    _configureSslBypass();

    // Add logging interceptor
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) => print('DIO LOG: $log'),
      ),
    );

    // Add URL handler interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.path = _getFullUrl(options.path);
          return handler.next(options);
        },
      ),
    );
  }

  /// Configures SSL bypass for development
  void _configureSslBypass() {
    HttpOverrides.global = _CustomHttpOverrides();
  }

  /// Constructs the full URL for the request
  String _getFullUrl(String endpoint) {
    if (endpoint.startsWith('http')) {
      return endpoint;
    }
    return endpoint.startsWith('/')
        ? ApiConfig.baseUrl + endpoint
        : '${ApiConfig.baseUrl}/$endpoint';
  }
}

/// Custom HTTP overrides for SSL handling
class _CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
