import 'dart:async';
import 'dart:ui';
import 'package:minimals/firebase_options.dart';
import 'package:minimals/services/device_service.dart';
import 'package:minimals/services/firebase_services/notification_service.dart';
import 'package:minimals/services/firebase_services/remote_config_service.dart';
import 'package:minimals/utils/global_utils.dart';
// import 'package:minimals/widgets/app_error.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/app/app.dart';
import 'package:minimals/enum/environment.dart' as env;
import 'package:minimals/services/localization_service.dart';
import 'package:minimals/locale/config_lang.dart';
import 'package:minimals/locale/locale_controller.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

/// Main application entry point with security improvements
Future<void> main() async {
  // Global error handler to catch all uncaught errors
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize storage with error handling
    try {
      await GetStorage.init();
    } catch (e) {
      debugPrint('Storage initialization failed: $e');
      // Continue execution - app can work without storage
    }

    // Enhanced error widget for development
    if (kDebugMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('An error occurred', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      details.exception.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      };
    }

    // Secure environment determination with validation
    const String envString = String.fromEnvironment('ENV', defaultValue: 'dev');
    const allowedEnvs = ['dev', 'uat', 'prod'];

    final env.AppEnvironment environment;
    if (!allowedEnvs.contains(envString)) {
      debugPrint('Invalid environment: $envString, defaulting to dev');
      environment = env.AppEnvironment.dev;
    } else {
      switch (envString) {
        case 'prod':
          environment = env.AppEnvironment.prod;
          break;
        case 'uat':
          environment = env.AppEnvironment.uat;
          break;
        case 'dev':
        default:
          environment = env.AppEnvironment.dev;
          break;
      }
    }

    // Initialize Firebase with improved error handling
    try {
      final firebaseOptions = getFirebaseOptions(environment);
      // Secure app name generation to prevent injection
      final appName = 'minimals_${environment.toString().split('.').last}_${DateTime.now().millisecondsSinceEpoch}'.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');

      await Firebase.initializeApp(
        name: appName,
        options: firebaseOptions,
      );

      // Configure Crashlytics based on environment
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    } catch (e) {
      debugPrint('Firebase initialization failed: $e');
      // Don't crash the app - continue with offline functionality
      if (kDebugMode) {
        rethrow; // In debug mode, show the error
      }
    }

    // Initialize device service with error handling
    try {
      await DeviceService.instance.init();
    } catch (e) {
      debugPrint('Device service initialization failed: $e');
      // Continue - not critical for app functionality
    }

    // Setup error handlers
    FlutterError.onError = (errorDetails) {
      if (kDebugMode) {
        FlutterError.presentError(errorDetails);
      } else {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (kDebugMode) {
        debugPrint('Platform error: $error');
      } else {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
      return true;
    }; // Initialize services with error handling
    try {
      // Initialize global app configuration based on environment
      switch (environment) {
        case env.AppEnvironment.dev:
          setAppConfigForEnvironment(Environment.development);
          break;
        case env.AppEnvironment.uat:
          setAppConfigForEnvironment(Environment.staging);
          break;
        case env.AppEnvironment.prod:
          setAppConfigForEnvironment(Environment.production);
          break;
      }

      Get.put(RemoteConfigService(), permanent: true);
      Get.put(NotificationService(), permanent: true); // Fixed: removed duplicate

      await configureDependencies(environment);

      final localizationService = Get.put(LocalizationService(), permanent: true);
      await localizationService.loadTranslations();

      // Use the new locale system to get initial locale
      Locale savedLocale;
      try {
        savedLocale = LocaleController.getInitialLocale();
      } catch (e) {
        debugPrint('Error getting initial locale: $e');
        savedLocale = defaultLang.locale;
      }

      // Set device orientations to allow both portrait and landscape
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      runApp(
        DevicePreview(
          enabled: false,
          builder: (context) => MyApp(initialLocale: savedLocale),
        ),
      );
    } catch (e, stack) {
      debugPrint('Service initialization failed: $e');

      if (kDebugMode) {
        rethrow;
      } else {
        // Log error and start app with minimal functionality
        FirebaseCrashlytics.instance.recordError(e, stack, reason: 'Service init failed');
        runApp(
          DevicePreview(
            enabled: kDebugMode,
            builder: (context) => MyApp(initialLocale: const Locale('en', 'US')),
          ),
        );
      }
    }
  }, (error, stack) {
    // Global error handler - logs all uncaught errors
    debugPrint('Uncaught error: $error');
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true, reason: 'Uncaught global error');
    }
  });
}

/// Secure Firebase options getter with validation
FirebaseOptions getFirebaseOptions(env.AppEnvironment environment) {
  switch (environment) {
    case env.AppEnvironment.prod:
      return DefaultFirebaseOptions.prod;
    case env.AppEnvironment.uat:
      return DefaultFirebaseOptions.uat;
    case env.AppEnvironment.dev:
      return DefaultFirebaseOptions.dev;
  }
}
