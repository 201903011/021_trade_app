import 'package:minimals/screens/dashboard/controller/dashboard_controller.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoldingMain extends StatelessWidget {
  HoldingMain({super.key});
  final holdingController = Get.put(HoldingMainController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {},
          child: Scaffold(
            appBar: AppHeaderBar(title: 'Holdings'),
            body: Stack(
              children: [],
            ),
            bottomNavigationBar: const AppBottomTabs(),
          ),
        ),
        AppLoader(isLoading: holdingController.isLoading),
      ],
    );
  }
}
