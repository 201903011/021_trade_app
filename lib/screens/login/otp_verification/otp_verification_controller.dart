import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/routes/auth_routes.dart';
// ignore: unused_import
import 'package:minimals/services/biometric_services/biometric_service.dart';
import 'package:minimals/utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final String userID = (Get.arguments != null && Get.arguments['userID'] != null) ? Get.arguments['userID'] : '';
  final String mobileNo = (Get.arguments != null && Get.arguments['mobile_no'] != null) ? Get.arguments['mobile_no'] : '9876543210';
  final String email = (Get.arguments != null && Get.arguments['email'] != null) ? Get.arguments['email'] : 'johndoe@gmail.com';
  final bool skipMPIN = (Get.arguments != null && Get.arguments['skipMPIN'] != null) ? Get.arguments['skipMPIN'] : false;
  RxBool isResendingOtp = false.obs;
  RxInt countdownSeconds = 0.obs;
  Timer? _timer;
  RxBool isOtpValid = false.obs;
  RxString otpError = ''.obs;
  final RxBool hasError = false.obs;
  final RxString otp = ''.obs;
  RxBool isLoading = false.obs;
  RxBool showResendOtp = false.obs;
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    showResendOtpWidget();
  }

  showResendOtpWidget() {
    Timer(const Duration(seconds: 5), () {
      showResendOtp.value = true;
    });
  }

  void resendOtp() async {
    if (countdownSeconds.value <= 0) {
      isResendingOtp.value = true;
      try {
        isLoading.value = true;
        await Future.delayed(const Duration(seconds: 2));
        if (true) {
          showSuccessSnackBar('OTP sent successfully');
        }
        isResendingOtp.value = false;
        isLoading.value = false;
        startCountdown();
      } catch (e) {
        // debugPrint('Error generating OTP: $e');
        isResendingOtp.value = false;
        isLoading.value = false;
      } finally {
        isResendingOtp.value = false;
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void startCountdown() {
    countdownSeconds.value = 5;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownSeconds.value > 0) {
        countdownSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> validateOtp({value, isPasswordReset = false}) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    try {
      if (true) {
        final result = {
          'userID': userID,
          'email': email,
          'isReset2FA': false,
          'authenticationType': 3,
          'mobile_no': mobileNo,
          'auth_token': 'sample_auth_token',
          'auth_token_expiry': DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
          'user_name': 'Sample User',
          'profile_type': 'Sample Profile',
          'refresh_token': 'sample_refresh_token',
          'refresh_token_expiry': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        };
        await _storage.write(StorageKeys.authToken, result['auth_token']);
        await _storage.write(StorageKeys.authTokenExpiry, result['auth_token_expiry']);
        await _storage.write(StorageKeys.userName, result['user_name']);
        await _storage.write(StorageKeys.profileType, result['profile_type']);
        await _storage.write(StorageKeys.refreshToken, result['refresh_token']);
        await _storage.write(StorageKeys.refreshTokenExpiry, result['refresh_token_expiry']);
        await getUserData();

        if (isPasswordReset) {
          String tempPass = _storage.read(StorageKeys.tempPassword) ?? "";
          String restPasswordTitle = _storage.read(StorageKeys.type) ?? "Change Password";

          if (tempPass == "") {
            restPasswordTitle = "Change Password";
            await _storage.write(StorageKeys.tempPassword, _storage.read<String>(StorageKeys.password));
          }
          Get.toNamed(AuthRoutes.restPassword, arguments: {'userID': userID, 'title': restPasswordTitle, 'type': '', 'isChangePassword': false});
        } else {
          Get.offNamedUntil(Routes.dashboard, (route) => false);
          await _storage.write(StorageKeys.isLogin, true);
        }
        isLoading.value = false;
      }
    } catch (e) {
      showSnackBar('An unknown error occurred');
      hasError.value = true;
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  getUserData() async {}
}
