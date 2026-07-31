/// Environment configuration enum
enum Environment {
  development('dev'),
  staging('uat'),
  production('prod');

  const Environment(this.value);
  final String value;

  @override
  String toString() => value;
}

/// Base configuration model
class AppConfig {
  final String baseUrl;
  final String s3Url;
  final bool isLive;
  final Environment environment;
  final Duration connectionTimeout;
  final Duration receiveTimeout;
  final int maxRetries;
  final Duration retryDelay;
  final Map<String, dynamic> customProperties;

  const AppConfig({
    required this.baseUrl,
    required this.s3Url,
    required this.isLive,
    required this.environment,
    this.connectionTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.maxRetries = 2,
    this.retryDelay = const Duration(seconds: 2),
    this.customProperties = const {},
  });

  /// Create from JSON map
  factory AppConfig.fromMap(Map<String, dynamic> json, Environment environment) {
    return AppConfig(
      baseUrl: json['baseUrl'] as String? ?? '',
      s3Url: json['s3Url'] as String? ?? '',
      isLive: json['isLive'] as bool? ?? false,
      environment: environment,
      connectionTimeout: Duration(
        seconds: json['connectionTimeout'] as int? ?? 30,
      ),
      receiveTimeout: Duration(
        seconds: json['receiveTimeout'] as int? ?? 30,
      ),
      maxRetries: json['maxRetries'] as int? ?? 10,
      retryDelay: Duration(
        seconds: json['retryDelay'] as int? ?? 2,
      ),
      customProperties: Map<String, dynamic>.from(
        json['customProperties'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toMap() {
    return {
      'baseUrl': baseUrl,
      's3Url': s3Url,
      'isLive': isLive,
      'environment': environment.value,
      'connectionTimeout': connectionTimeout.inSeconds,
      'receiveTimeout': receiveTimeout.inSeconds,
      'maxRetries': maxRetries,
      'retryDelay': retryDelay.inSeconds,
      'customProperties': customProperties,
    };
  }
}
