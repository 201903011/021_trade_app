import 'package:minimals/screens/dashboard/controller/dashboard_controller.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundsMain extends StatelessWidget {
  FundsMain({super.key});
  final fundsMainController = Get.put(FundsMainController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {},
          child: Scaffold(
            appBar: AppHeaderBar(title: 'Funds'),
            body: Stack(
              children: [],
            ),
            bottomNavigationBar: const AppBottomTabs(),
          ),
        ),
        AppLoader(isLoading: fundsMainController.isLoading),
      ],
    );
  }
}
