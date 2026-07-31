// This file is deprecated. Use the modular API service structure instead.
// The API service has been separated into multiple files for better organization:
// - api_service.dart: Main API service class
// - models/: Configuration and response models
// - utils/: Helper utilities
// - interceptors/: Custom interceptors
// - constants/: API constants
// - exceptions/: Custom exceptions

export 'api_service.dart';
export 'enums/http_method.dart';
export 'models/api_config.dart';
export 'models/request_config.dart';
export 'models/api_response.dart';
export 'constants/api_constants.dart';
export 'exceptions/api_exception.dart';
export 'utils/api_utils.dart';
export 'interceptors/api_interceptor.dart';
