import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/constants/assets_path.dart';
import 'package:minimals/widget/bottom_tabs/botton_tabs_controller.dart';
import 'package:minimals/widget/bottom_tabs/widgets/tab_image.dart';

class AppBottomTabs extends StatelessWidget {
  const AppBottomTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomTabsController controller = Get.find();

    return Obx(() {
      return BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => {
          if (index != controller.currentIndex.value) {controller.changeTab(index)}
        },
        items: _buildBottomNavItems(controller.currentIndex.value),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // selectedItemColor: AppColors.primaryOrange,
        // unselectedItemColor: AppColors.blackExtra,
      );
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavItems(int currentIndex) {
    return [
      _buildBottomNavItem(AppAssets.dashboard, 'Dashboard', currentIndex == 0),
      _buildBottomNavItem(AppAssets.exchange, 'Holdings', currentIndex == 1),
      _buildBottomNavItem(AppAssets.watchlist, 'Watchlist', currentIndex == 2),
      _buildBottomNavItem(AppAssets.holdings, 'Funds', currentIndex == 3),
    ];
  }

  BottomNavigationBarItem _buildBottomNavItem(String imgPath, String label, bool isActive) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabImg(imgPath: imgPath, isActive: isActive),
          isActive
              ? Text(
                  label,
                  // style: ,
                )
              : Text(
                  label,
                )
        ],
      ),
      label: label,
    );
  }
}
