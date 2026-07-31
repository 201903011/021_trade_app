/// HTTP request configuration
class RequestConfig {
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final bool requiresAuth;
  final bool showErrorSnackBar;
  final bool isMultipart;
  final Duration? timeout;
  final bool enableRetry;

  const RequestConfig({
    this.headers,
    this.queryParameters,
    this.requiresAuth = true,
    this.showErrorSnackBar = false,
    this.isMultipart = false,
    this.timeout,
    this.enableRetry = true,
  });

  /// Create a copy of this config with updated values
  RequestConfig copyWith({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool? requiresAuth,
    bool? showErrorSnackBar,
    bool? isMultipart,
    Duration? timeout,
    bool? enableRetry,
  }) {
    return RequestConfig(
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      requiresAuth: requiresAuth ?? this.requiresAuth,
      showErrorSnackBar: showErrorSnackBar ?? this.showErrorSnackBar,
      isMultipart: isMultipart ?? this.isMultipart,
      timeout: timeout ?? this.timeout,
      enableRetry: enableRetry ?? this.enableRetry,
    );
  }

  /// Merge this config with another config
  RequestConfig merge(RequestConfig? other) {
    if (other == null) return this;

    return RequestConfig(
      headers: {...?headers, ...?other.headers},
      queryParameters: {...?queryParameters, ...?other.queryParameters},
      requiresAuth: other.requiresAuth,
      showErrorSnackBar: other.showErrorSnackBar,
      isMultipart: other.isMultipart,
      timeout: other.timeout ?? timeout,
      enableRetry: other.enableRetry,
    );
  }

  @override
  String toString() {
    return 'RequestConfig('
        'requiresAuth: $requiresAuth, '
        'showErrorSnackBar: $showErrorSnackBar, '
        'isMultipart: $isMultipart, '
        'enableRetry: $enableRetry, '
        'timeout: $timeout'
        ')';
  }
}
