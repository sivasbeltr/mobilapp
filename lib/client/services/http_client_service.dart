import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/api_endpoints.dart';

/// A generic service class to handle HTTP requests using Dio.
class HttpClientService {
  /// Singleton instance of [HttpClientService].
  static final HttpClientService _instance = HttpClientService._internal();

  /// Factory constructor to return the singleton instance.
  factory HttpClientService() => _instance;

  /// Internal constructor for singleton pattern.
  HttpClientService._internal();

  /// The Dio HTTP client instance.
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );

  /// Initializes the HTTP client with SSL handling.
  void init() {
    // Configure SSL bypass for development
    HttpOverrides.global = _SivasMunicipalityHttpOverrides();

    // Add interceptors for logging, etc.
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) => print('DIO LOG: $log'),
      ),
    );
  }

  /// Makes a GET request to the specified [endpoint].
  ///
  /// If [endpoint] starts with 'http', it will be treated as a full URL.
  /// Otherwise, it will be appended to the base URL.
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    String url = _getFullUrl(endpoint);

    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Makes a POST request to the specified [endpoint].
  ///
  /// If [endpoint] starts with 'http', it will be treated as a full URL.
  /// Otherwise, it will be appended to the base URL.
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    String url = _getFullUrl(endpoint);

    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Returns the full URL for the given [endpoint].
  ///
  /// If [endpoint] starts with 'http', it will be returned as is.
  /// Otherwise, it will be appended to the base URL.
  String _getFullUrl(String endpoint) {
    if (endpoint.startsWith('http')) {
      return endpoint;
    }

    // Remove leading slash if present to avoid double slash
    if (endpoint.startsWith('/')) {
      return ApiEndpoints.baseUrl + endpoint;
    }

    return '${ApiEndpoints.baseUrl}/$endpoint';
  }

  /// Handles errors from Dio requests.
  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException();
      case DioExceptionType.badResponse:
        if (error.response != null) {
          throw ServerException(
            statusCode: error.response!.statusCode,
            message: error.response!.data?.toString() ?? 'Unknown error',
          );
        }
        throw ServerException(message: 'Bad response');
      case DioExceptionType.cancel:
        throw RequestCancelledException();
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException();
      case DioExceptionType.badCertificate:
        throw CertificateException();
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          throw NoInternetConnectionException();
        }
        throw UnknownException(error.message ?? 'Unknown error');
    }
  }
}

/// Custom HTTP Overrides class to handle SSL certification issues.
class _SivasMunicipalityHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// Exception thrown when a request times out.
class TimeoutException implements Exception {
  String get message => 'Request timed out. Please try again.';
}

/// Exception thrown when there is no internet connection.
class NoInternetConnectionException implements Exception {
  String get message => 'No internet connection. Please check your network.';
}

/// Exception thrown when a request is cancelled.
class RequestCancelledException implements Exception {
  String get message => 'Request was cancelled.';
}

/// Exception thrown when there is a server error.
class ServerException implements Exception {
  /// Status code of the server error.
  final int? statusCode;

  /// Error message.
  final String message;

  /// Creates a new [ServerException].
  ServerException({this.statusCode, required this.message});
}

/// Exception thrown when there is an SSL certificate error.
class CertificateException implements Exception {
  String get message => 'SSL certificate error.';
}

/// Exception thrown for unknown errors.
class UnknownException implements Exception {
  /// Error message.
  final String message;

  /// Creates a new [UnknownException].
  UnknownException(this.message);
}
