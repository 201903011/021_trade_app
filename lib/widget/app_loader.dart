import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/components/index.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, required this.isLoading, this.color});
  final RxBool isLoading;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Visibility(
            visible: isLoading.value,
            replacement: Container(),
            child: Expanded(
              child: Container(
                color: Colors.black.withOpacity(0.14),
                child: Center(
                  child: LoadingScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
