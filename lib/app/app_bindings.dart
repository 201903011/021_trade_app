import 'package:get/get.dart';
import 'package:minimals/app/app_controller.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/services/localization_service.dart';
import 'package:minimals/settings/settings_controller.dart';
import 'package:minimals/widget/bottom_tabs/botton_tabs_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize core services
    Get.put<LocalizationService>(LocalizationService(), permanent: true);
    Get.put<BottomTabsController>(BottomTabsController(), permanent: true);
    // Initialize controllers
    Get.put<SettingsController>(SettingsController(), permanent: true);
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<FundsMainController>(FundsMainController(), permanent: true);
  }
}
