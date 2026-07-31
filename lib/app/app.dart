import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:minimals/app/app_bindings.dart';
import 'package:minimals/app/app_controller.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/services/localization_service.dart';
import 'package:minimals/settings/settings_controller.dart';
import 'package:minimals/locale/index.dart';

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppController(), permanent: true);
    final settingsController = Get.put(SettingsController(), permanent: true);
    final localeController = Get.put(LocaleController(), permanent: true);

    return LocalizationWrapper(
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Minimals',
          initialRoute: appController.initialRoute.value,
          initialBinding: AppBindings(),
          theme: settingsController.getThemeData(isDark: false),
          darkTheme: settingsController.getThemeData(isDark: true),
          themeMode: settingsController.themeMode.value,
          getPages: AppPages.routes,
          translations: Get.find<LocalizationService>(),
          locale: localeController.currentLocale,
          fallbackLocale: defaultLang.locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return Directionality(
              textDirection: localeController.textDirection,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child!,
              ),
            );
          },
        ),
      ),
    );
  }
}
