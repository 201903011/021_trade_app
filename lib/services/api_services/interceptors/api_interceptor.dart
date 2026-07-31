import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'dart:developer' as d;

/// Custom Dio interceptor for handling requests, responses, and errors
class ApiInterceptor extends Interceptor {
  final Function()? onUnauthorized;

  ApiInterceptor({this.onUnauthorized});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (foundation.kDebugMode) {
      d.log('Request: ${options.method} ${options.path} ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (foundation.kDebugMode) {
      d.log('Error: ${err.response} ${err.message} ${err.requestOptions.data}');
    }

    if (err.response != null) {
      var response = err.response?.data;
      if (response is Map<String, dynamic> && response['code'] != null) {
        if (response['code'] == 401 || response['error'] == 'Sessions Expired' || response['error'] == 'Invalid authorization token' || response['code'] == 422) {
          if (foundation.kDebugMode) {
            d.log('Unauthorized access - Session expired');
          }
          onUnauthorized?.call();
        }
      }
    }

    super.onError(err, handler);
  }
}
