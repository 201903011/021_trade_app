import 'dart:async';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Enhanced Remote Config Service with security, performance, and reliability improvements
class RemoteConfigService extends GetxService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Cache management
  final Map<String, dynamic> _cache = <String, dynamic>{};
  DateTime? _lastFetchTime;
  bool _isInitialized = false;
  bool _isInitializing = false;

  // Configuration constants
  static const Duration _fetchTimeout = Duration(seconds: 15);
  static const Duration _minimumFetchInterval = Duration(minutes: 5);
  static const Duration _cacheExpiry = Duration(hours: 12);
  static const int _maxRetryAttempts = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  // Default values for security
  static const Map<String, dynamic> _defaultValues = {
    'feature_enabled': false,
    'api_timeout': 30,
    'max_retry_attempts': 3,
    'app_version_required': '1.0.0',
    'maintenance_mode': false,
  };

  @override
  void onInit() {
    super.onInit();
    _initializeRemoteConfigSafely();
  }

  /// Safe initialization with comprehensive error handling
  Future<void> _initializeRemoteConfigSafely() async {
    if (_isInitializing || _isInitialized) return;

    _isInitializing = true;

    try {
      await _initializeWithRetry();
      _isInitialized = true;
      debugPrint('Remote Config initialized successfully');
    } catch (e) {
      debugPrint('Remote Config initialization failed: $e');
      _setDefaultValues();
    } finally {
      _isInitializing = false;
    }
  }

  /// Initialize with retry logic and exponential backoff
  Future<void> _initializeWithRetry() async {
    for (int attempt = 1; attempt <= _maxRetryAttempts; attempt++) {
      try {
        await _initializeRemoteConfig();
        return; // Success
      } catch (e) {
        debugPrint('Remote Config init attempt $attempt failed: $e');

        if (attempt == _maxRetryAttempts) {
          rethrow; // Final attempt failed
        }

        // Exponential backoff
        await Future.delayed(_retryDelay * attempt);
      }
    }
  }

  /// Core initialization logic
  Future<void> _initializeRemoteConfig() async {
    // Set default values for fallback
    await _remoteConfig.setDefaults(_defaultValues);

    // Configure settings with environment-appropriate values
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: _fetchTimeout,
      minimumFetchInterval: kDebugMode ? const Duration(seconds: 30) : _minimumFetchInterval,
    ));

    // Initial fetch
    await _fetchRemoteConfigInternal();
  }

  /// Enhanced fetch method with caching and validation
  Future<void> fetchRemoteConfig({bool forceRefresh = false}) async {
    if (!_isInitialized && !_isInitializing) {
      await _initializeRemoteConfigSafely();
    }

    // Check if we need to fetch based on cache expiry
    if (!forceRefresh && _isCacheValid()) {
      debugPrint('Using cached Remote Config data');
      return;
    }

    await _fetchRemoteConfigInternal();
  }

  /// Internal fetch method with comprehensive error handling
  Future<void> _fetchRemoteConfigInternal() async {
    try {
      final bool success = await _remoteConfig.fetchAndActivate();

      if (success) {
        _lastFetchTime = DateTime.now();
        _updateCache();
        debugPrint('Remote Config fetched and activated successfully');
      } else {
        debugPrint('Remote Config fetch returned false - using cached values');
      }
    } catch (e) {
      debugPrint(' Remote Config error: $e');
      _setDefaultValues();
    }
  }

  /// Check if cached data is still valid
  bool _isCacheValid() {
    if (_lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < _cacheExpiry;
  }

  /// Update internal cache
  void _updateCache() {
    _cache.clear();
    final keys = _remoteConfig.getAll();
    for (final entry in keys.entries) {
      _cache[entry.key] = entry.value.asString();
    }
  }

  /// Set default values as fallback
  void _setDefaultValues() {
    _cache.clear();
    _cache.addAll(_defaultValues);
    debugPrint('Using default Remote Config values');
  }

  /// Enhanced getter methods with validation and fallbacks

  /// Get string value with validation and fallback
  String getString(String key, {String? defaultValue}) {
    if (!_validateKey(key)) return defaultValue ?? '';

    try {
      final value = _remoteConfig.getString(key);
      return value.isNotEmpty ? value : defaultValue ?? _getDefaultValue(key, '');
    } catch (e) {
      debugPrint('Error getting string for key $key: $e');
      return defaultValue ?? _getDefaultValue(key, '');
    }
  }

  /// Get boolean value with validation and fallback
  bool getBool(String key, {bool? defaultValue}) {
    if (!_validateKey(key)) return defaultValue ?? false;

    try {
      return _remoteConfig.getBool(key);
    } catch (e) {
      debugPrint('Error getting bool for key $key: $e');
      return defaultValue ?? _getDefaultValue(key, false);
    }
  }

  /// Get integer value with validation and fallback
  int getInt(String key, {int? defaultValue}) {
    if (!_validateKey(key)) return defaultValue ?? 0;

    try {
      return _remoteConfig.getInt(key);
    } catch (e) {
      debugPrint('Error getting int for key $key: $e');
      return defaultValue ?? _getDefaultValue(key, 0);
    }
  }

  /// Get double value with validation and fallback
  double getDouble(String key, {double? defaultValue}) {
    if (!_validateKey(key)) return defaultValue ?? 0.0;

    try {
      return _remoteConfig.getDouble(key);
    } catch (e) {
      debugPrint('Error getting double for key $key: $e');
      return defaultValue ?? _getDefaultValue(key, 0.0);
    }
  }

  /// Get JSON object (parsed from string)
  Map<String, dynamic>? getJson(String key) {
    try {
      final jsonString = getString(key);
      if (jsonString.isEmpty) return null;

      // Basic JSON validation
      if (!jsonString.startsWith('{') && !jsonString.startsWith('[')) {
        return null;
      }

      return jsonDecode(jsonString) as Map<String, dynamic>?;
    } catch (e) {
      debugPrint('Error parsing JSON for key $key: $e');
      return null;
    }
  }

  /// Validate key for security
  bool _validateKey(String key) {
    if (key.isEmpty) {
      debugPrint('⚠️ Empty key provided to Remote Config');
      return false;
    }

    // Basic key validation - prevent injection
    if (key.contains('<') || key.contains('>') || key.contains('"') || key.contains("'")) {
      debugPrint('⚠️ Invalid characters in Remote Config key: $key');
      return false;
    }

    return true;
  }

  /// Get default value by type
  T _getDefaultValue<T>(String key, T fallback) {
    final defaultValue = _defaultValues[key];
    return defaultValue is T ? defaultValue : fallback;
  }

  /// Check if a key exists
  bool hasKey(String key) {
    if (!_validateKey(key)) return false;
    return _remoteConfig.getAll().containsKey(key);
  }

  /// Get all keys (for debugging)
  Set<String> getAllKeys() {
    return _remoteConfig.getAll().keys.toSet();
  }

  /// Force refresh from server
  Future<void> forceRefresh() async {
    debugPrint('🔄 Forcing Remote Config refresh');
    await fetchRemoteConfig(forceRefresh: true);
  }

  /// Get service status
  Map<String, dynamic> getStatus() {
    return {
      'initialized': _isInitialized,
      'initializing': _isInitializing,
      'lastFetchTime': _lastFetchTime?.toIso8601String(),
      'cacheValid': _isCacheValid(),
      'keysCount': _remoteConfig.getAll().length,
    };
  }

  @override
  void onClose() {
    _cache.clear();
    super.onClose();
  }
}

/// Usage examples:
/// 
/// ```dart
/// // Basic usage with fallbacks
/// final isFeatureEnabled = remoteConfig.getBool('new_feature', defaultValue: false);
/// final apiTimeout = remoteConfig.getInt('api_timeout', defaultValue: 30);
/// 
/// // Force refresh when needed
/// await remoteConfig.forceRefresh();
/// 
/// // Check service status
/// final status = remoteConfig.getStatus();
/// 
/// // Get JSON configuration
/// final config = remoteConfig.getJson('app_config');
/// ```
