import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/services/log_out_services.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:get/get.dart';

import '../constants/api_constants.dart';
import '../exceptions/api_exception.dart';

/// Header builder utility for API requests
class HeaderBuilder {
  final GetStorage _storage = GetStorage();

  /// Build default headers for requests
  Map<String, dynamic> buildDefaultHeaders({
    bool requiresAuth = true,
    bool isMultipart = false,
    Map<String, dynamic>? customHeaders,
  }) {
    final headers = <String, dynamic>{
      ApiConstants.sourceHeader: ApiConstants.mobileSource,
    };

    // Set content type
    headers['Content-Type'] = isMultipart ? ApiConstants.contentTypeMultipart : ApiConstants.contentTypeJson;

    // Add auth token if required
    if (requiresAuth) {
      final token = _storage.read<String>(StorageKeys.authToken);
      if (token != null && token.isNotEmpty) {
        headers[ApiConstants.apiTokenHeader] = token;
      }
    }

    // Add device information headers for specific endpoints
    if (customHeaders?['includeDeviceInfo'] == true) {
      headers.addAll(_buildDeviceHeaders());
    }

    // Add custom headers (excluding special flags)
    if (customHeaders != null) {
      final filteredHeaders = Map<String, dynamic>.from(customHeaders);
      filteredHeaders.remove('includeDeviceInfo');
      headers.addAll(filteredHeaders);
    }

    return headers;
  }

  /// Build device-specific headers
  Map<String, dynamic> _buildDeviceHeaders() {
    // Note: deviceService should be injected or passed as parameter
    // For now, returning empty map to avoid compile errors
    return {
      // ApiConstants.deviceIdHeader: deviceService.deviceId,
      // ApiConstants.appVersionHeader: deviceService.appVersion,
      // ApiConstants.buildNumberHeader: deviceService.buildNumber,
      // ApiConstants.osHeader: deviceService.os,
      // ApiConstants.packageNameHeader: deviceService.packageName,
    };
  }
}

/// Error handler utility for API responses
class ErrorHandler {
  final LogOutServices _logoutService = getIt<LogOutServices>();

  /// Handle unauthorized access
  Future<void> handleUnauthorized() async {
    try {
      if (Get.currentRoute != Routes.login) {
        await _logoutService.logOut(Get.context!, () {});
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  /// Extract error message from DioException
  String extractErrorMessage(dio.DioException error) {
    return ApiException.fromDioException(error).message;
  }

  /// Check if error is unauthorized
  bool isUnauthorizedError(dio.DioException error) {
    if (error.response?.statusCode == ApiConstants.unauthorizedCode) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        return data['message'] == ApiConstants.unauthorizedMessage;
      }
    }
    return false;
  }

  /// Check if response indicates session expiry
  bool isSessionExpired(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final code = responseData['code'];
      final error = responseData['error'];

      return code == ApiConstants.unauthorizedCode || error == ApiConstants.sessionExpiredError || error == ApiConstants.invalidTokenError || code == ApiConstants.unprocessableEntityCode;
    }
    return false;
  }
}

/// File utility for handling file operations
class FileUtil {
  /// Create FormData from file and additional data
  static Future<dio.FormData> createFormData(
    File file, {
    String fieldName = ApiConstants.defaultFileFieldName,
    Map<String, dynamic>? additionalData,
  }) async {
    final formData = dio.FormData();

    // Add file
    formData.files.add(MapEntry(
      fieldName,
      await dio.MultipartFile.fromFile(file.path),
    ));

    // Add additional data
    if (additionalData != null) {
      additionalData.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    return formData;
  }
}
