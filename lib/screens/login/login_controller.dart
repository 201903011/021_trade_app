import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/auth_routes.dart';
import 'package:minimals/utils/global_utils.dart';
import 'package:minimals/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final RxString apiError = ''.obs;
  final RxBool isRememberMe = true.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxString signature = ''.obs;
  final RxBool showSignature = false.obs;
  final GetStorage _storage = GetStorage();
  final RxBool isNewPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRememberMe();
    _setupListeners();
    getSignature();
    checkIfNewPassword();
  }

  checkIfNewPassword() {
    if (isRememberMe.value &&
        passwordController.text.isEmpty &&
        userController.text.isNotEmpty) {
      isNewPassword.value = true;
    } else {
      isNewPassword.value = false;
    }
  }

  getSignature() async {
    signature.value = await getSmsAutoFillSignature();
    // print("Signature:>>${signature.value}");
  }

  void _setupListeners() {
    userController.addListener(onTextFieldsChanged);
    passwordController.addListener(onTextFieldsChanged);
  }

  void onTextFieldsChanged() {
    isButtonEnabled.value = _isFormValid();
  }

  bool _isFormValid() {
    return userController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  Future<void> generateOtp() async {
    apiError.value = '';

    isLoading.value = true;
   
      try {
        if (true) {
          if (isRememberMe.value) {
            await _saveRememberMe();
          }
          else {
            await _storage.remove(StorageKeys.mPin);
            await _storage.remove(StorageKeys.isBioMetric);
          }
          final result = {
            'userID' : userController.text,
            'password' : passwordController.text,
            'authenticationType' : 3,
            'isReset2FA' : false,
            'email' : 'johndoe@gmail.com',
            'mobile_no' : '9876543210',
          };
      
          final authenticationType = result['authenticationType'];
          if (authenticationType == 3 || authenticationType == 2) {
            await _storage.write(StorageKeys.email, result['email'].toString());
            await _storage.write(
                StorageKeys.mobileNo, result['mobile_no'].toString());
            flushValues();

            Get.toNamed(AuthRoutes.otpVerification, arguments: {
              'userID': result['userID'],
              'email': result['email'].toString(),
              'mobile_no': result['mobile_no'].toString()
            });
            // showErrorSnackBar("OTP has been sent to your registered Mobile number/Email ID",isError: false);
          }
        }
      } catch (e) {
        // print('Error generating OTP: $e');
          showSnackBar('An error occurred: ${e.toString()}'); // General error message
        
      } finally {
        isLoading.value = false;
      }
  }

  Future<void> _loadRememberMe() async {
    isRememberMe.value = _storage.read<bool>(StorageKeys.rememberMe) ?? true;
    if (isRememberMe.value) {
      userController.text = _storage.read<String>(StorageKeys.userId) ?? '';
      passwordController.text =
          _storage.read<String>(StorageKeys.password) ?? '';
      onTextFieldsChanged();
    }
  }

  Future<void> _saveRememberMe() async {
    await _storage.write(StorageKeys.rememberMe, isRememberMe.value);
    // print("Abe:?${userController.text}   ${_storage.read(StorageKeys.userId)}");
    if(userController.text != await _storage.read(StorageKeys.userId)) {
      await _storage.remove(StorageKeys.mPin);
      await _storage.remove(StorageKeys.isBioMetric);
    }
    if (isRememberMe.value) {
      await _storage.write(StorageKeys.userId, userController.text);
      await _storage.write(StorageKeys.password, passwordController.text);
    } else {
      await _storage.remove(StorageKeys.userId);
      await _storage.remove(StorageKeys.password);
    }
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
    _saveRememberMe();
  }

  @override
  void onClose() {
    // userController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  flushValues() {
    if (!isRememberMe.value) {
      passwordController.text = '';
      userController.text = '';
    }
  }
}
