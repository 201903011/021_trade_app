import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/locale/locale_controller.dart';

/// Widget that provides directionality and locale context to the app
class LocalizationWrapper extends StatelessWidget {
  final Widget child;

  const LocalizationWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (localeController) {
        return Directionality(
          textDirection: localeController.textDirection,
          child: child,
        );
      },
    );
  }
}

/// Mixin to provide easy access to locale functionality
mixin LocaleMixin {
  LocaleController get localeController => Get.find<LocaleController>();

  String tr(String key, {Map<String, String>? args}) {
    return localeController.translate(key, args: args);
  }

  bool get isRTL => localeController.isRTL;
  TextDirection get textDirection => localeController.textDirection;
  Locale get currentLocale => localeController.currentLocale;
}
