import 'package:minimals/components/index.dart';
import 'package:minimals/screens/login/forgot_password/controller/forgot_password_controller.dart';
import 'package:minimals/screens/login/widgets/login_app_bar.dart';
import 'package:minimals/screens/login/widgets/terms_n_conditions.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/widget/input_box/app_input_box.dart';

class TempPassword extends StatelessWidget {
  TempPassword({super.key});
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgotPasswordController());
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    userController.text = Get.arguments['userID'];
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, top: 24),
                  child: Text(
                    "Forgot Password", //controller.title,
                    style: baseTheme.textTheme.headlineLarge,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppInputBox(
                        placeholder: 'User ID',
                        hintText: '',
                        isCapital: true,
                        controller: userController,
                        inputType: TextInputType.name,
                        isMandatory: true,
                        validator: (value) {
                          return validateUserId(userController.text);
                        },
                        onChanged: (value) {
                          controller.isDisableButton.value = !(passwordController.text.isNotEmpty && userController.text.isNotEmpty);
                        },
                      ),
                      const SizedBox(height: 20),
                      AppInputBox(
                        placeholder: 'Temporary password',
                        isMandatory: true,
                        isPassword: true,
                        showInfo: true,
                        controller: passwordController,
                        inputType: TextInputType.text,
                        infoSubTitle: "System generated password received on user's registered Mobile No and Email ID. ",
                        validator: (value) {
                          return value == "" ? "Please enter the temporary password to proceed." : validatePassword(passwordController.text, userController.text);
                        },
                        hintText: '',
                        onChanged: (value) {
                          controller.isDisableButton.value = !(passwordController.text.isNotEmpty && userController.text.isNotEmpty);
                        },
                      ),
                      const SizedBox(height: 32),
                      Obx(
                        () => CustomButton.contained(
                            text: "Submit",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.tempPasswordGenerateOtp(userController.text, passwordController.text);
                              }
                            },
                            fullWidth: true,
                            disabled: controller.isDisableButton.value),
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
