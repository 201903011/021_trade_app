import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/models/api_result_model.dart';
import 'package:minimals/models/file_response_model.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/utils/snackbar_util.dart';
import 'package:get/get.dart' hide Response;
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

import 'constants/api_constants.dart';
import 'enums/http_method.dart';
import 'interceptors/api_interceptor.dart';
import 'models/api_config.dart';
import 'models/api_response.dart';
import 'utils/api_utils.dart';

/// Enhanced Generic API Service
class ApiService {
  final Dio _dio = Dio();
  CancelToken _cancelToken = CancelToken();
  final GetStorage _storage = GetStorage();
  final HeaderBuilder _headerBuilder = HeaderBuilder();
  final ErrorHandler _errorHandler = ErrorHandler();

  ApiService([ApiConfig? config]) {
    _initializeDio(config);
  }

  /// Initialize Dio with configuration
  void _initializeDio(ApiConfig? config) {
    final apiConfig = config ??
        const ApiConfig(
          baseUrl: 'https://jsonplaceholder.typicode.com',
        );
    _dio.options.baseUrl = apiConfig.baseUrl;
    _dio.options.connectTimeout = apiConfig.connectTimeout;
    _dio.options.receiveTimeout = apiConfig.receiveTimeout;
    _dio.options.sendTimeout = apiConfig.sendTimeout;

    // Add custom interceptor
    _dio.interceptors.add(
      ApiInterceptor(
        onUnauthorized: () => _errorHandler.handleUnauthorized(),
      ),
    );
  }

  /// Download file method
  Future<Response> getDownload(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final token = _storage.read<String>(StorageKeys.authToken) ?? '';

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        cancelToken: _cancelToken,
        options: Options(
          method: 'GET',
          headers: headers ??
              {
                ApiConstants.apiTokenHeader: token,
              },
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      debugPrint("Download error: $e");
      if (_errorHandler.isUnauthorizedError(e)) {
        if (Get.currentRoute != Routes.login) {
          await _errorHandler.handleUnauthorized();
        }
      }
      rethrow;
    }
  }

  /// POST download method
  Future<Response> postDownload(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final token = _storage.read<String>(StorageKeys.authToken) ?? '';

      final response = await _dio.post(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        cancelToken: _cancelToken,
        options: Options(
          method: 'POST',
          headers: headers ??
              {
                ApiConstants.apiTokenHeader: 'Bearer $token',
              },
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      debugPrint("Post download error: $e");
      if (_errorHandler.isUnauthorizedError(e)) {
        if (Get.currentRoute != Routes.login) {
          await _errorHandler.handleUnauthorized();
        }
      }
      rethrow;
    }
  }

  /// Generic file upload method
  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint,
    File file, {
    String fieldName = ApiConstants.defaultFileFieldName,
    Map<String, dynamic>? additionalData,
    ProgressCallback? onProgress,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final formData = await FileUtil.createFormData(
        file,
        fieldName: fieldName,
        additionalData: additionalData,
      );

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onProgress,
        cancelToken: _cancelToken,
        options: Options(
          headers: {
            ApiConstants.apiTokenHeader: '${_storage.read<String>(StorageKeys.authToken)}',
            ApiConstants.sourceHeader: ApiConstants.mobileSource,
          },
        ),
      );

      final data = fromJson != null ? fromJson(response.data) : response.data as T;

      return ApiResponse.success(
        data,
        statusCode: response.statusCode,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      return ApiResponse.failure(
        'Upload failed: ${e.message}',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.failure('Upload failed: $e');
    }
  }

  /// Generic typed request method
  Future<ApiResponse<T>> request<T>(
    HttpMethod method,
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
    bool requiresAuth = true,
    bool showErrors = false,
  }) async {
    try {
      final requestHeaders = _headerBuilder.buildDefaultHeaders(
        requiresAuth: requiresAuth,
        customHeaders: headers,
      );

      final options = Options(
        method: method.value,
        headers: requestHeaders,
      );

      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );

      final responseData = fromJson != null ? fromJson(response.data) : response.data as T;

      return ApiResponse.success(
        responseData,
        statusCode: response.statusCode,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      final errorMessage = _errorHandler.extractErrorMessage(e);
      if (showErrors) {
        showSnackBar(errorMessage);
      }
      return ApiResponse.failure(errorMessage, statusCode: e.response?.statusCode);
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      if (showErrors) {
        showSnackBar(errorMessage);
      }
      return ApiResponse.failure(errorMessage);
    }
  }

  /// Load and check file type (legacy method)
  Future<Result<FileResponseModel>> loadAndCheckFileType(String url) async {
    try {
      Dio dio = Dio();

      // Get file name from URL
      String fileName = url.split('/').last;

      // Get temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String savePath = '${tempDir.path}/$fileName';

      // Download the file
      final response = await dio.download(url, savePath);

      // Get file MIME type
      String? mimeType = lookupMimeType(savePath);
      if (response.headers.map["content-type"]?.isNotEmpty == true) {
        mimeType = response.headers.map["content-type"]?[0];
      }

      return Result.success(FileResponseModel(localPath: savePath, mimeType: mimeType));
    } catch (e) {
      debugPrint("Error loading file: $e");
      return Result.failure("Error to load file");
    }
  }

  /// Cancel all requests
  void cancelRequests([String? reason]) {
    _cancelToken.cancel(reason ?? 'Cancelled by user');
    _cancelToken = CancelToken();
  }

  /// Dispose resources
  void dispose() {
    _dio.close();
  }
}
