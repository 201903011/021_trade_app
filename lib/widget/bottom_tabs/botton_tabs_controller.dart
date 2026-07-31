import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomTabsController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    changeValue(0);
    final GetStorage _storage = GetStorage();
    bool isLogin = _storage.read(StorageKeys.isLogin) ?? false;
    print("isLogin:>>${isLogin}");
  }

  void changeValue(int index) {
    currentIndex.value = index;
  }

  void changeTab(int index, {String? navigateTo}) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamedUntil(Routes.dashboard, (route) => false);
        break;
      case 1:
        Get.offNamedUntil(Routes.holdings, (route) => false);
        break;
      case 2:
        Get.offNamedUntil(Routes.watchlist, (route) => false);
        break;
      case 3:
        Get.offNamedUntil(Routes.funds, (route) => false);
        break;
    }
    // Navigate to additional route if needed
    if (navigateTo != null) {
      Get.toNamed(navigateTo);
    }
  }
}




// class BottomTabsController extends GetxController {
//   var currentIndex = 2.obs;
//
//   void changeTab(int index) {
//     currentIndex.value = index;
//     switch (index) {
//       case 0:
//         Get.offNamedUntil(Routes.dashboardMain, (route) => false);
//         break;
//       case 1:
//         Get.offNamedUntil(Routes.exchangeMain, (route) => false);
//         break;
//       case 2:
//         Get.offNamedUntil(Routes.rfqMain, (route) => false);
//         break;
//       case 3:
//         Get.offNamedUntil(Routes.portfolioMain, (route) => false);
//         break;
//       case 4:
//         Get.offNamedUntil(Routes.moreMain, (route) => false);
//         break;
//     }
//   }
// }


