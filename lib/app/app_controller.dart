import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/app_pages.dart';

class AppController extends GetxController {
  RxString initialRoute = RxString(Routes.initial);
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _determineInitialRoute();
  }

  Future<void> _determineInitialRoute() async {
    try {
      final bool? isLogin = _storage.read<bool>(StorageKeys.isLogin);

      // Check if user session is valid
      final bool hasValidSession = isLogin != null && isLogin;

      await Future.delayed(const Duration(seconds: 2));
      initialRoute.value = hasValidSession ? Routes.dashboard : Routes.login;

      // Navigate to initial route after current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offNamedUntil(initialRoute.value, (route) => false);
      });
    } on Exception catch (e) {
      // TODO
      Get.offNamedUntil(Routes.login, (route) => false);
    }
  }
}
