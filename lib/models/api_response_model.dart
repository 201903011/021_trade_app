/// Generic API response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;
  final Map<String, dynamic>? headers;

  const ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
    this.headers,
  });

  factory ApiResponse.success(T data, {int? statusCode, Map<String, dynamic>? headers}) {
    return ApiResponse(
      success: true,
      data: data,
      statusCode: statusCode,
      headers: headers,
    );
  }

  factory ApiResponse.failure(String error, {int? statusCode}) {
    return ApiResponse(
      success: false,
      error: error,
      statusCode: statusCode,
    );
  }
}
