import 'package:minimals/components/date_picker/custom_date_picker.dart';
import 'package:minimals/components/index.dart';
import 'package:minimals/theme/overrides/index.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/utils/global_utils.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino for iOS-style picker
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDatePickerController extends GetxController {
  var selectedDate = Rxn<DateTime>();

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {},
    );
  }
}

class AppDatePicker extends StatelessWidget {
  final void Function(DateTime? selectedDate) onDateChange;
  final String? Function(DateTime?)? validator;
  final String placeholder;
  final DateTime? selectedDate;
  final DateTime? maxDate;
  final DateTime? minDate;
  final bool isMandatory;
  final bool isDisabled;
  final bool showInfo;
  final Color? color;
  final AppDatePickerController? dateController;

  const AppDatePicker({
    super.key,
    required this.onDateChange,
    this.isMandatory = false,
    this.isDisabled = false,
    this.showInfo = false,
    required this.placeholder,
    this.validator,
    this.selectedDate,
    this.minDate,
    this.maxDate,
    this.color,
    this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    final AppDatePickerController controller = dateController ?? AppDatePickerController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (selectedDate != null) {
          controller.setSelectedDate(selectedDate);
        } else {
          controller.setSelectedDate(null);
        }
      },
    );

    Future<void> selectDate(BuildContext context) async {
      final theme = useTheme(context);
      final baseTheme = theme.theme;
      final customTheme = theme.customTheme;

      DateTime? picked = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: customTheme.palette.background.paper,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    final tempPickedDate = controller.selectedDate.value ?? getEighteenYearsBackDate();
                    return Text(
                      formatDate(tempPickedDate),
                      style: baseTheme.textTheme.titleMedium?.copyWith(
                        color: customTheme.palette.text.primary,
                        decoration: TextDecoration.none,
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 26),
                    child: SizedBox(
                      height: 127,
                      child: CustomDatePicker(
                        initialDate: controller.selectedDate.value ?? DateTime(2000, 1),
                        minDate: minDate ?? getDate101YearsBack(),
                        maxDate: maxDate ?? DateTime.now(), //getEighteenYearsBackDate(),
                        onDateSelected: (DateTime date) {
                          controller.setSelectedDate(date);
                        },
                      ),
                    ),
                  ),
                  // Cancel/Confirm buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomButton.contained(
                            text: 'Cancel',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: ButtonColor.primary),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomButton.contained(
                          text: 'Save',
                          onPressed: () {
                            Navigator.of(context).pop();
                            onDateChange(controller.selectedDate.value);
                          },
                          color: ButtonColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (picked != null && picked != controller.selectedDate.value) {
        controller.setSelectedDate(picked);
        onDateChange(picked);
      }
    }

    final theme = useTheme(context);
    final customTheme = theme.customTheme;

    return FormField<DateTime>(
      key: key,
      validator: validator,
      builder: (field) {
        return Obx(() {
          final selectedDate = controller.selectedDate.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 3.0),
                child: Row(
                  children: [
                    if (placeholder != "")
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0, left: 3.0),
                        child: Text(
                          placeholder,
                          style: customTheme.typography.subtitle2.copyWith(
                            color: isDisabled ? customTheme.palette.text.disabled : customTheme.palette.text.primary,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (isMandatory)
                      Text(
                        ' *',
                        style: customTheme.typography.body1.copyWith(color: customTheme.palette.common.error.main),
                      ),
                    if (showInfo)
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.info_outline,
                            size: 16,
                            color: customTheme.palette.common.info.main,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (!isDisabled) {
                    selectDate(context);
                  }
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: customTheme.palette.common.divider,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (selectedDate != null)
                        Text(
                          "${selectedDate.day.toString()} ${intToMonth(selectedDate.month)} ${selectedDate.year.toString()} ",
                        ),
                      const Spacer(),
                      Icon(
                        Icons.calendar_today,
                        color: isDisabled ? customTheme.palette.common.grey[400]! : customTheme.palette.common.primary.main,
                      ),
                    ],
                  ),
                ),
              ),
              if (field.errorText != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${field.errorText!}*',
                    style: customTheme.typography.h1.copyWith(color: customTheme.palette.common.error.main, fontSize: 12),
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}
