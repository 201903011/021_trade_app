import 'package:minimals/screens/login/forgot_password/forgot_password.dart';
import 'package:minimals/screens/login/forgot_password/rest_password.dart';
import 'package:minimals/screens/login/forgot_password/temp_password.dart';
import 'package:minimals/screens/login/otp_verification/otp_verification.dart';
import 'package:get/get.dart';

abstract class AuthRoutes {
  static const otpVerification = '/otp-verification';
  static const forgotPassword = '/forgot-password';
  static const enterMpin = '/enter-pin';
  static const tempPassword = '/temp-password';
  static const restPassword = '/rest_password';
  static const setMpin = '/set-pin';
  static const changeMpin = '/change-mpin';
}

class AuthPages {
  static final routes = [
    GetPage(
        name: AuthRoutes.otpVerification, page: () => const OtpVerification()),
    GetPage(name: AuthRoutes.forgotPassword, page: () => ForgotPassword()),
    GetPage(name: AuthRoutes.tempPassword, page: () => TempPassword()),
    GetPage(name: AuthRoutes.restPassword, page: () => RestPassword()),
  ];
}
