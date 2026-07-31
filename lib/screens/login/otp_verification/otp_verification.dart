import 'package:minimals/screens/login/widgets/login_app_bar.dart';
import 'package:minimals/screens/login/widgets/terms_n_conditions.dart';
import 'package:minimals/utils/global_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/otp/app_otp.dart';
import 'package:minimals/widget/resend_otp/resend_otp_button.dart';
import 'otp_verification_controller.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpVerificationController());

    return Stack(
      children: [
        Scaffold(
          appBar: const LoginAppBar(),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 32),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            'We have sent it to ',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${maskPhoneNumber(controller.mobileNo)}",
                              ),
                              Text(
                                " and ",
                              ),
                              Flexible(
                                child: Text(
                                  maskEmail(controller.email),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CommonOtpWidget(
                      onCompleted: (value) async {
                        controller.otp.value = value;
                        print('OTP onCompleted:>>$value');
                        if (value.length == 4) {
                          FocusScope.of(context).unfocus();
                          controller.otp.value = value;
                          controller.validateOtp(value: value, isPasswordReset: Get.arguments['isChangePassword'] ?? false);
                        }
                      },
                      onError: (value) {
                        print('OTP Error:>>4$value');
                      },
                    ),
                    Obx(
                      () => Visibility(
                          visible: controller.isOtpValid.value,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 45, top: 10),
                                child: Text(
                                  "${controller.otpError.value}*",
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => controller.showResendOtp.value
                          ? ResendOtpButton(
                              isResendingOtp: controller.isResendingOtp,
                              countdownSeconds: controller.countdownSeconds,
                              onResendOtp: () => controller.resendOtp(),
                            )
                          : Container(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                    ),
                  ],
                ),
                const TermsNConditions(),
              ],
            ),
          ),
        ),
        AppLoader(
          isLoading: controller.isLoading,
        )
      ],
    );
  }
}
