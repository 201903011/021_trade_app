import 'package:minimals/screens/dashboard/controller/dashboard_controller.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMain extends StatelessWidget {
  DashboardMain({super.key});
  final dashBoardController = Get.put(DashboardMainController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {},
          child: Scaffold(
            appBar: AppHeaderBar(title: 'Dashboard'),
            body: Stack(
              children: [],
            ),
            bottomNavigationBar: const AppBottomTabs(),
          ),
        ),
        AppLoader(isLoading: dashBoardController.isLoading),
      ],
    );
  }
}
