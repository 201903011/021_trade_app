import 'package:minimals/components/index.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/screens/login/forgot_password/controller/forgot_password_controller.dart';
import 'package:minimals/screens/login/widgets/login_app_bar.dart';
import 'package:minimals/screens/login/widgets/terms_n_conditions.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimals/widget/input_box/app_input_box.dart';

class RestPassword extends StatelessWidget {
  RestPassword({
    super.key,
  });
  final controller = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;

    String title = Get.arguments['title'];
    bool isChangePassword = Get.arguments['isChangePassword'] ?? false;
    return Scaffold(
      appBar: const LoginAppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: isChangePassword ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, top: 24),
                  child: Text(
                    title,
                    style: baseTheme.textTheme.headlineLarge,
                  ),
                ),
                Form(
                  key: controller.changeFormKey,
                  child: Column(
                    children: [
                      Visibility(
                        visible: isChangePassword,
                        child: AppInputBox(
                          placeholder: 'Enter old password',
                          hintText: '',
                          controller: controller.tempPasswordController,
                          inputType: TextInputType.name,
                          showInfo: false,
                          isMandatory: true,
                          isPassword: true,
                          validator: (value) {
                            return validatePassword(controller.tempPasswordController.text, controller.userID);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppInputBox(
                        placeholder: isChangePassword ? 'Enter new password' : 'Set new password',
                        isMandatory: true,
                        isPassword: true,
                        showInfo: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        infoSubTitle:
                            '1. Password must have minimum 6 characters.\n2. Password must have maximum 12 characters.\n3. Password must have atleast one lowercase character.\n4. Password must have atleast one uppercase character.\n5. Password must have atleast one digit.\n6. Password must have atleast one special character.\n7. Password must not be same as login ID.',
                        controller: controller.newPasswordController,
                        inputType: TextInputType.text,
                        validator: (value) {
                          return validatePassword(controller.newPasswordController.text, controller.userID);
                        },
                        onChanged: (value) {
                          controller.checkValues();
                        },
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      AppInputBox(
                        placeholder: 'Confirm new password',
                        isMandatory: true,
                        isPassword: true,
                        controller: controller.confirmPasswordController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        inputType: TextInputType.text,
                        validator: (value) {
                          return controller.confirmPasswordController.text.isNotEmpty ? validatePassword(controller.confirmPasswordController.text, controller.userID) : null;
                        },
                        onChanged: (value) {
                          controller.checkValues();
                        },
                        hintText: '',
                      ),
                      const SizedBox(height: 32),
                      // AppButton(
                      //     text: 'Continue',
                      //     onPressed: () {
                      //       if (_formKey.currentState!.validate()) {
                      //         debugPrint('Form is valid');
                      //         Get.toNamed(LoginRoutes.tempPassword);
                      //       } else {
                      //         debugPrint('Form is invalid');
                      //       }
                      //     },
                      //     type: ButtonType.primary),
                      Obx(
                        () => CustomButton.contained(
                          text: 'Continue',
                          disabled: !controller.isButtonEnabled.value,
                          fullWidth: true,
                          onPressed: () async {
                            if (controller.changeFormKey.currentState!.validate()) {
                              controller.changePassword(title);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: TermsNConditions(),
            ),
          ],
        ),
      ),
    );
  }
}
