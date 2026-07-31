import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInputBoxController extends GetxController {
  var errorText = ''.obs;
  var isObscureText = true.obs;
  var focusedFocusNode = Rx<FocusNode?>(null);

  void setError(String? message) {
    errorText.value = message ?? '';
  }

  void toggleObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  void setFocus(FocusNode focusNode, bool focused) {
    if (focused) {
      focusedFocusNode.value = focusNode;
    } else if (focusedFocusNode.value == focusNode) {
      focusedFocusNode.value = null;
    }
  }
}
