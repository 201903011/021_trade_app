import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      _buildBottomNavItem(Icons.dashboard_rounded, 'Dashboard', currentIndex == 0),
      _buildBottomNavItem(Icons.swap_horiz_rounded, 'Holdings', currentIndex == 1),
      _buildBottomNavItem(Icons.favorite_rounded, 'Watchlist', currentIndex == 2),
      _buildBottomNavItem(Icons.receipt_long_rounded, 'Orders', currentIndex == 3),
    ];
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label, bool isActive) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabImg(icon: icon, isActive: isActive),
          isActive
              ? Text(
                  label,
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
