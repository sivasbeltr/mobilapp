import 'dart:io';
import 'package:dio/dio.dart';

/// Base API client for all network requests
class ApiClient {
  final Dio _dio = Dio();
  static const String _baseUrl =
      'https://www.sivas.bel.tr/servisler'; // Replace with actual API URL
  static const int _connectTimeout = 15000; // 15 seconds
  static const int _receiveTimeout = 15000; // 15 seconds
  static const int _maxRetries = 3;

  ApiClient() {
    _setupDio();
  }

  /// Configure Dio client with base URL, timeouts, and interceptors
  void _setupDio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: _connectTimeout);
    _dio.options.receiveTimeout = const Duration(milliseconds: _receiveTimeout);

    // Add request interceptor for headers, auth tokens, etc.
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Add common headers
          options.headers['Content-Type'] = 'application/json';
          // Add authorization token if available
          // options.headers['Authorization'] = 'Bearer YOUR_AUTH_TOKEN';
          return handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          // Implement retry logic
          if (_shouldRetry(error)) {
            return _retry(error, handler);
          }
          return handler.next(error);
        },
      ),
    );

    // Add logging interceptor for debugging
    if (true) {
      // Replace with environment check for debug mode
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  /// Check if the error is worth retrying (network errors, timeouts)
  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.badResponse &&
            (error.response?.statusCode == 500 ||
                error.response?.statusCode == 503);
  }

  /// Retry the request up to max retries
  Future<void> _retry(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final options = error.requestOptions;

    // Get retry count from extra data or set to 1 if not present
    final retryCount = options.extra['retryCount'] as int? ?? 0;

    if (retryCount < _maxRetries) {
      // Increment retry count
      options.extra['retryCount'] = retryCount + 1;

      // Retry after a delay (with exponential backoff)
      final delay = Duration(milliseconds: 300 * (retryCount + 1));
      await Future.delayed(delay);

      try {
        // Create new request with the same options
        final response = await _dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        // If retry fails, pass the error
        return handler.next(error);
      }
    }

    // Max retries reached, forward the error
    return handler.next(error);
  }

  /// GET request helper
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  /// POST request helper
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  /// PUT request helper
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  /// DELETE request helper
  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  /// Handle and format error responses
  void _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');
        case DioExceptionType.sendTimeout:
          throw Exception('Send timeout');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');
        case DioExceptionType.badCertificate:
          throw Exception('Bad certificate');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final errorMessage =
              error.response?.data?['message'] ?? 'Unknown error';
          throw Exception('Bad response: $statusCode - $errorMessage');
        case DioExceptionType.cancel:
          throw Exception('Request cancelled');
        case DioExceptionType.connectionError:
          throw Exception('Connection error');
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            throw Exception('No internet connection');
          }
          throw Exception('Unknown error: ${error.message}');
      }
    } else {
      throw Exception('Something went wrong: $error');
    }
  }
}
