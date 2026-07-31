import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AppDropdownController extends GetxController {
  final RxString selectedValue = ''.obs;

  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        debugPrint("Dropdown Focused");
      } else {
        debugPrint("Dropdown Unfocused");
      }
    });
  }


  void setDefaultValue(String? value) {
    if (value?.isNotEmpty == true) {
      selectedValue.value = value!;
    }
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
}



