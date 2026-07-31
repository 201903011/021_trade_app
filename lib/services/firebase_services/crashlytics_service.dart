import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    _initializeCrashlytics();
  }

  Future<void> _initializeCrashlytics() async {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  void logMessage(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  Future<void> setCustomKey(String key, String value) async {
    await FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  Future<void> crashApp() async {
    await Future.delayed(const Duration(seconds: 5));
    FirebaseCrashlytics.instance.crash();
  }

  Future<void> recordError(Object error, StackTrace stackTrace,
      {String? reason, bool fatal = false}) async {
    await FirebaseCrashlytics.instance
        .recordError(error, stackTrace, reason: reason, fatal: fatal);
  }
}
