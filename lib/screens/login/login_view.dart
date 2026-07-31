import 'package:minimals/components/index.dart';
import 'package:minimals/routes/auth_routes.dart';
import 'package:minimals/screens/login/login_controller.dart';
import 'package:minimals/screens/login/widgets/login_app_bar.dart';
import 'package:minimals/screens/login/widgets/terms_n_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimals/theme/overrides/index.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/utils/validation.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/input_box/app_input_box.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      child: Stack(
        children: [
          Scaffold(
            appBar: const LoginAppBar(showLeadingIcon: false),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 32, top: 24),
                          child: Text(
                            'Log in',
                            style: baseTheme.textTheme.headlineLarge,
                          )),
                      Form(
                        key: controller.formKey,
                        onChanged: () {
                          controller.onTextFieldsChanged();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppInputBox(
                              placeholder: 'User ID',
                              hintText: '',
                              controller: controller.userController,
                              inputType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                              ],
                              isMandatory: true,
                              isCapital: true,
                              validator: (value) {
                                return validateUserId(controller.userController.text);
                              },
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () => AppInputBox(
                                placeholder: controller.isNewPassword.value ? 'New Password' : 'Password',
                                isMandatory: true,
                                isPassword: true,
                                controller: controller.passwordController,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  return validatePassword(controller.passwordController.text, controller.userController.text);
                                },
                                hintText: '',
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.apiError.value != '' ? true : false,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${controller.apiError.value}*',
                                      style: baseTheme.textTheme.bodyMedium?.copyWith(
                                        color: customTheme.palette.common.error.main,
                                      )),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.toggleRememberMe();
                              },
                              child: Container(
                                // color: AppColors.white,
                                padding: const EdgeInsets.only(top: 32, bottom: 44),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => CustomCheckbox(
                                        value: controller.isRememberMe.value,
                                        onChanged: (value) {
                                          controller.toggleRememberMe();
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Remember Credentials",
                                      style: baseTheme.textTheme.bodyMedium?.copyWith(
                                        color: customTheme.palette.text.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => CustomButton.contained(
                                text: 'Generate OTP',
                                disabled: !controller.isButtonEnabled.value,
                                fullWidth: true,
                                onPressed: () {
                                  if (controller.formKey.currentState!.validate()) {
                                    debugPrint('Form is valid');
                                    controller.generateOtp();
                                  } else {
                                    debugPrint('Form is invalid');
                                  }
                                },
                                color: ButtonColor.primary,
                              ),
                            ),
                            const SizedBox(height: 22),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AuthRoutes.forgotPassword, arguments: {'title': 'Forgot Password', 'type': 'forgotPassword', 'userID': ''});
                              },
                              child: const Center(
                                child: Text(
                                  'Forgot Password?',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?  ',
                            style: baseTheme.textTheme.labelLarge, // Replace with your actual text style
                          ),
                          const Text(
                            'Register',
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TermsNConditions(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppLoader(
            isLoading: controller.isLoading,
          )
        ],
      ),
    );
  }
}
