import 'models/app_config.dart';

/// Development environment configuration
const AppConfig devDefaultConfig = AppConfig(
  baseUrl: "https://api.v1.in",
  s3Url: "https://dummy.s3.ap-south-1.amazonaws.com",
  isLive: false,
  environment: Environment.development,
  connectionTimeout: Duration(seconds: 30),
  receiveTimeout: Duration(seconds: 30),
  maxRetries: 10,
  retryDelay: Duration(seconds: 2),
  customProperties: {
    'enableDebugLogging': true,
    'enableAnalytics': false,
    'enableCrashlytics': false,
    'features': {
      'darkMode': true,
      'betaFeatures': true,
    },
  },
);

/// UAT/Staging environment configuration
const AppConfig uatDefaultConfig = AppConfig(
  baseUrl: "https://api.v1.in",
  s3Url: "https://dummy.s3.ap-south-1.amazonaws.com",
  isLive: false,
  environment: Environment.staging,
  connectionTimeout: Duration(seconds: 45),
  receiveTimeout: Duration(seconds: 45),
  maxRetries: 8,
  retryDelay: Duration(seconds: 3),
  customProperties: {
    'enableDebugLogging': true,
    'enableAnalytics': true,
    'enableCrashlytics': true,
    'features': {
      'darkMode': true,
      'betaFeatures': true,
    },
  },
);

/// Production environment configuration
const AppConfig prodDefaultConfig = AppConfig(
  baseUrl: "https://api.v1.in",
  s3Url: "https://bfjprod.s3.ap-south-1.amazonaws.com", // Updated for production
  isLive: true,
  environment: Environment.production,
  connectionTimeout: Duration(seconds: 60),
  receiveTimeout: Duration(seconds: 60),
  maxRetries: 5,
  retryDelay: Duration(seconds: 5),
  customProperties: {
    'enableDebugLogging': false,
    'enableAnalytics': true,
    'enableCrashlytics': true,
    'features': {
      'darkMode': true,
      'betaFeatures': false,
    },
  },
);

/// Map of all default configurations by environment
const Map<Environment, AppConfig> defaultConfigs = {
  Environment.development: devDefaultConfig,
  Environment.staging: uatDefaultConfig,
  Environment.production: prodDefaultConfig,
};

/// Helper function to get configuration by environment
AppConfig getConfigByEnvironment(Environment environment) {
  return defaultConfigs[environment] ?? devDefaultConfig;
}

/// Helper function to get configuration by environment string
AppConfig getConfigByEnvironmentString(String environmentString) {
  switch (environmentString.toLowerCase()) {
    case 'dev':
    case 'development':
      return devDefaultConfig;
    case 'uat':
    case 'staging':
      return uatDefaultConfig;
    case 'prod':
    case 'production':
      return prodDefaultConfig;
    default:
      return devDefaultConfig;
  }
}
