/// API constants used throughout the API service
class ApiConstants {
  // Headers
  static const String contentTypeJson = 'application/json';
  static const String contentTypeMultipart = 'multipart/form-data; boundary=<calculated when request is sent>';
  static const String apiTokenHeader = 'X-Biofuel-Token';
  static const String sourceHeader = 'source';
  static const String deviceIdHeader = 'deviceId';
  static const String appVersionHeader = 'appVersion';
  static const String buildNumberHeader = 'buildNumber';
  static const String osHeader = 'os';
  static const String packageNameHeader = 'packageName';

  // Source values
  static const String mobileSource = 'm';

  // Error messages
  static const String unauthorizedMessage = 'Unauthorized';
  static const String sessionExpiredError = 'Sessions Expired';
  static const String invalidTokenError = 'Invalid authorization token';

  // File upload
  static const String defaultFileFieldName = 'file';

  // Response codes
  static const int unauthorizedCode = 401;
  static const int unprocessableEntityCode = 422;

  ApiConstants._();
}
