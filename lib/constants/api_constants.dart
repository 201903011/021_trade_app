import 'package:minimals/utils/global_utils.dart';

class ApiConstants {
  // Use getters for dynamic access to global config
  String get loginBaseUrl => appConfig.baseUrl;
  String get s3Url => appConfig.s3Url;

  //login
  String get sendOtp => '$loginBaseUrl/api/admin/send-otp';
  String get verifyOtp => '$loginBaseUrl/api/admin/varify-otp';
}

final apiConstants = ApiConstants();
