import 'package:minimals/components/index.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/screens/login/forgot_password/controller/forgot_password_controller.dart';
import 'package:minimals/screens/login/widgets/login_app_bar.dart';
import 'package:minimals/screens/login/widgets/terms_n_conditions.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/utils/global_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/utils/validation.dart';
import 'package:minimals/widget/date_picker/app_datepicker.dart';
import 'package:minimals/widget/input_box/app_input_box.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final controller = Get.put(ForgotPasswordController());
  final FocusNode panFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;

    return Scaffold(
      appBar: const LoginAppBar(),
      resizeToAvoidBottomInset: true,
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
                    controller.title,
                    style: baseTheme.textTheme.headlineLarge,
                  ),
                ),
                Form(
                  key: controller.formKey,
                  onChanged: () {
                    controller.onTextFieldsChanged();
                  },
                  child: Column(
                    children: <Widget>[
                      AppInputBox(
                        placeholder: 'User ID',
                        hintText: '',
                        controller: controller.userIDController,
                        isCapital: true,
                        inputType: TextInputType.name,
                        isMandatory: true,
                        onTapOutside: (value) {
                          if (FocusScope.of(context).isFirstFocus) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => AppDatePicker(
                          onDateChange: (date) {
                            controller.dob.value = convertDate(date)!;
                            FocusScope.of(Get.context!).requestFocus(panFocusNode);
                          },
                          placeholder: 'DOB',
                          selectedDate: convertToDateTime(controller.dob.value),
                          isMandatory: true,
                          validator: (value) {
                            return controller.dob.value != "" ? validateDate(controller.dob.value) : validateDate(convertDate(value));
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppInputBox(
                        placeholder: 'PAN',
                        isMandatory: true,
                        isPassword: false,
                        controller: controller.panController,
                        isCapital: true,
                        inputType: TextInputType.text,
                        validator: (value) {
                          return controller.panController.text != "" ? validatePanCard(controller.panController.text) : validatePanCard(value);
                        },
                        focusNode: panFocusNode,
                        onChanged: (value) {
                          if (value.length == 10) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        hintText: '',
                        onTapOutside: (value) {
                          if (FocusScope.of(context).isFirstFocus) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      Obx(
                        () => CustomButton.contained(
                          text: 'Continue',
                          disabled: !controller.isButtonEnabled.value,
                          fullWidth: true,
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.storage.write(StorageKeys.type, 'Forgot Password');
                              controller.forgotPassword();

                              // Get.toNamed(LoginRoutes.tempPassword);
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
