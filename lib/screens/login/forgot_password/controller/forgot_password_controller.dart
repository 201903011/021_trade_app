import 'package:minimals/components/index.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/routes/auth_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/utils/snackbar_util.dart';

class ForgotPasswordController extends GetxController {
  final String title = Get.arguments['title'];
  final String type = Get.arguments['type'];
  final String userID = Get.arguments['userID'];
  final bool isChangePassword = Get.arguments['isChangePassword'] ?? false;
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final changeFormKey = GlobalKey<FormState>();
  final panController = TextEditingController();
  final userIDController = TextEditingController();
  final RxString dob = ''.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxBool isReset = false.obs;
  final tempPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GetStorage storage = GetStorage();
  final RxBool isDisableButton = true.obs;
  final RxBool isResetDisableButton = true.obs;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    userIDController.addListener(onTextFieldsChanged);
    panController.addListener(onTextFieldsChanged);
  }

  void onTextFieldsChanged() {
    isButtonEnabled.value = _isFormValid();
  }

  checkValues() {
    isResetDisableButton.value = !(confirmPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty);
  }

  bool _isFormValid() {
    return userIDController.text.isNotEmpty && panController.text.isNotEmpty && dob.value.isNotEmpty;
  }

  Future<void> forgotPassword() async {
    isLoading.value = true;
    try {
      if (true) {
        Get.toNamed(AuthRoutes.tempPassword, arguments: {'title': '', 'type': '', 'userID': userIDController.text, 'isChangePassword': isChangePassword});
      }
    } catch (e) {
      CustomSnackbar.error(context: Get.context!, message: 'An error occurred: Invalid Details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> unblockUser() async {
    try {
      if (true) {
        Get.toNamed(AuthRoutes.tempPassword, arguments: {
          'title': 'Forgot Password', //'Unlock account',
          'type': '',
          'userID': userIDController.text
        });
      }
    } catch (e) {
      CustomSnackbar.error(context: Get.context!, message: 'An error occurred: Invalid Details');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    userIDController.dispose();
    panController.dispose();
    super.onClose();
  }

  flushValues() {
    // panController.text = '';
    // userIDController.text = '';
    // dob.value = '';
  }

  Future<void> changePassword(title) async {
    if (newPasswordController.text == confirmPasswordController.text && (newPasswordController.text.isNotEmpty || confirmPasswordController.text.isNotEmpty)) {
      isLoading.value = true;

      try {
        if (true) {
          // final description = result['description'];
          // showErrorSnackBar(description);
          if (true) {
            await storage.write('password', '');
            await storage.remove(StorageKeys.tempPassword);
            await storage.remove(StorageKeys.type);
            await storage.write(StorageKeys.password, confirmPasswordController.text);
            Get.back();
            Get.offNamedUntil(Routes.login, (route) => false);
            showSnackBar('Your Password Change Successfully', isError: false);
          }
        }
      } catch (e) {
        if (e is DioException && (e.response?.statusCode == 406 || e.response?.statusCode == 400)) {
          showSnackBar(e.response?.data['error'] ?? 'An unknown error occurred');
        } else {
          showSnackBar('An error occurred: ${e.toString()}'); // General error message
        }
      } finally {
        isLoading.value = false;
      }
    } else {
      showErrorSnackBar('New Password and Confirm Password do not match');
      isLoading.value = false;
    }
  }

  Future<void> tempPasswordGenerateOtp(userID, password) async {
    await storage.write(StorageKeys.tempPassword, password);
    isLoading.value = true;
    try {
      if (true) {
        final result = {'userID': "A1211", 'email': 'test@gmail.com', 'isReset2FA': false, 'authenticationType': 3, 'mobile_no': '9876543210'};

        final authenticationType = result['authenticationType'];
        if (authenticationType == 3 || authenticationType == 2) {
          flushValues();
          await storage.write(StorageKeys.email, result['email']);
          await storage.write(StorageKeys.mobileNo, result['mobile_no'].toString());
          Get.toNamed(AuthRoutes.otpVerification, arguments: {'userID': result['userID'], 'email': result['email'], 'mobile_no': result['mobile_no'].toString(), 'isChangePassword': true});
        }
      }
    } catch (e) {
      // debugPrint('Error generating OTP: $e');
      showSnackBar('An error occurred: ${e.toString()}'); // General error message
    } finally {
      isLoading.value = false;
    }
  }
}
