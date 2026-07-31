import 'package:dio/dio.dart';

/// API Exception handling
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final DioExceptionType? type;

  const ApiException(this.message, {this.statusCode, this.type});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';

  /// Create from DioException
  factory ApiException.fromDioException(DioException error) {
    String message;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Response timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? 'Server error';
        } else {
          message = 'Server error (${error.response?.statusCode})';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      default:
        message = 'Network error. Please check your connection.';
    }

    return ApiException(
      message,
      statusCode: error.response?.statusCode,
      type: error.type,
    );
  }
}
