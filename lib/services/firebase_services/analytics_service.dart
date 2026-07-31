import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService extends GetxService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseAnalyticsObserver observer;

  FirebaseAnalytics get analytics => _analytics;

  AnalyticsService()
      : observer =
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);


  Future<void> setDefaultEventParameters(
      Map<String, dynamic> parameters) async {
    if (kIsWeb) {
      debugPrint(
          '"setDefaultEventParameters()" is not supported on the web platform');
    } else {
      await _analytics.setDefaultEventParameters(parameters);
    }
  }

  Future<void> logEvent(String name, Map<String, Object> parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserId(String id) async {
    await _analytics.setUserId(id: id);
  }

  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  Future<void> setSessionTimeoutDuration(Duration duration) async {
    await _analytics.setSessionTimeoutDuration(duration);
  }

  Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  Future<void> setConsent({
    required bool adStorageConsentGranted,
    required bool adUserDataConsentGranted,
    required bool adPersonalizationSignalsConsentGranted,
  }) async {
    await _analytics.setConsent(
      adStorageConsentGranted: adStorageConsentGranted,
      adUserDataConsentGranted: adUserDataConsentGranted,
      adPersonalizationSignalsConsentGranted:
          adPersonalizationSignalsConsentGranted,
    );
  }

  Future<void> getAppInstanceId() async {
    String? id = await _analytics.appInstanceId;
    if (id != null) {
      debugPrint('appInstanceId succeeded: $id');
    } else {
      debugPrint('appInstanceId failed, consent declined');
    }
  }

  Future<void> resetAnalyticsData() async {
    await _analytics.resetAnalyticsData();
  }

  Future<void> initiateOnDeviceConversionMeasurement(String email) async {
    await _analytics
        .initiateOnDeviceConversionMeasurementWithEmailAddress(email);
  }
}
