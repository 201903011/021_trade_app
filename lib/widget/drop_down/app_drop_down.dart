  // import 'package:minimals/constants/assets_path.dart';
  // import 'package:minimals/screens/ekyc/additional_details/ekyc_adddetails_controller.dart';
  // import 'package:minimals/theme/colors.dart';
  // import 'package:minimals/theme/styles/app_sheet_style.dart';
  // import 'package:minimals/theme/styles/app_text_style.dart';
  // import 'package:minimals/widgets/app_image.dart';
  // import 'package:minimals/widgets/bottom_sheets/info_sheet.dart';
  // import 'package:minimals/widgets/drop_down/app_drop_down_controller.dart';
  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // // class AppDropdown extends StatefulWidget {
  // //   final List<String> items;
  // //   final String? initialValue;
  // //   final bool isDisabled;
  // //   final String? placeholder;
  // //   final String? hintText;
  // //   final bool isMandatory;
  // //   final bool showInfo;
  // //   final String infoSubTitle;
  // //   final String errorText;
  // //   final String? Function(String?)? validator;
  // //   final void Function(String)? onChanged;
  // //   final List<Option> options;
  // //   final FocusNode? focusNode;
  // //   late String? selectedValue;
  // //
  // //    AppDropdown({
  // //     super.key,
  // //     required this.items,
  // //     this.initialValue,
  // //     this.isDisabled = false,
  // //     this.placeholder,
  // //     this.hintText,
  // //     this.isMandatory = false,
  // //     this.showInfo = false,
  // //     this.infoSubTitle = '',
  // //     this.errorText = '',
  // //     this.validator,
  // //     this.onChanged,
  // //     this.focusNode,
  // //      this.selectedValue,
  // //     this.options = const <Option>[],
  // //   });
  // //
  // //   @override
  // //   State<AppDropdown> createState() => _AppDropDownFocusNodeState();
  // // }
  // //
  // // class _AppDropDownFocusNodeState extends State<AppDropdown> {
  // //   late FocusNode _focusNode;
  // //
  // //   @override
  // //   void initState() {
  // //     super.initState();
  // //     _focusNode = widget.focusNode ?? FocusNode();
  // //     widget.selectedValue = widget.initialValue;
  // //   }
  // //
  // //   @override
  // //   void dispose() {
  // //     if (widget.focusNode == null) {
  // //       _focusNode.dispose();
  // //     }
  // //     super.dispose();
  // //   }
  // //
  // //   @override
  // //   Widget build(BuildContext context) {
  // //     final borderColor = _focusNode.hasFocus ? AppColors.primaryOrange : Colors.transparent;
  // //     final border = OutlineInputBorder(
  // //       borderRadius: BorderRadius.circular(10.0),
  // //       borderSide: BorderSide(color: borderColor, width: 1.5),
  // //     );
  // //
  // //     return Column(
  // //       crossAxisAlignment: CrossAxisAlignment.start,
  // //       children: [
  // //         if (widget.placeholder != null)
  // //           Padding(
  // //             padding: const EdgeInsets.only(bottom: 8.0, left: 3.0),
  // //             child: Row(
  // //               children: [
  // //                 Text(
  // //                   widget.placeholder!,
  // //                   style: AppTextStyles.textSemiBold12.copyWith(color: AppColors.subtextGrey),
  // //                 ),
  // //                 if (widget.isMandatory)
  // //                   Text(
  // //                     ' *',
  // //                     style: AppTextStyles.textSemiBold12.copyWith(color: AppColors.brightErrorRed),
  // //                   ),
  // //                 if (widget.showInfo)
  // //                   GestureDetector(
  // //                     onTap: () {
  // //                       showModalBottomSheet(
  // //                         context: context,
  // //                         shape: AppSheetStyle.bottomSheetShape,
  // //                         builder: (context) {
  // //                           return InfoSheet(title: widget.placeholder!, subTitle: widget.infoSubTitle);
  // //                         },
  // //                       );
  // //                     },
  // //                     child: const Padding(
  // //                       padding: EdgeInsets.only(left: 4),
  // //                       child: AppImage(assetPath: AppAssets.info),
  // //                     ),
  // //                   ),
  // //               ],
  // //             ),
  // //           ),
  // //         DropdownButtonFormField<String>(
  // //           borderRadius: BorderRadius.circular(8),
  // //           hint: Text(widget.hintText ?? ''),
  // //           focusNode: _focusNode,
  // //           decoration: InputDecoration(
  // //             fillColor: widget.isDisabled ? AppColors.chalkBorder : AppColors.lightGrey,
  // //             labelStyle: const TextStyle(color: AppColors.charcoal),
  // //             filled: true,
  // //             enabled: !widget.isDisabled,
  // //             border: OutlineInputBorder(
  // //               borderRadius: BorderRadius.circular(10.0),
  // //               borderSide: BorderSide.none,
  // //             ),
  // //             focusedBorder: border,
  // //             errorBorder: border,
  // //             disabledBorder: border,
  // //             errorStyle: AppTextStyles.textMedium12.copyWith(color: AppColors.brightErrorRed),
  // //           ),
  // //           value: widget.selectedValue,
  // //           dropdownColor: AppColors.white,
  // //           isExpanded: false,
  // //           items: widget.items.map((item) {
  // //             final option = widget.options.firstWhere(
  // //                   (e) => e.value == item,
  // //               orElse: () => Option(value: item, title: item),
  // //             );
  // //             return DropdownMenuItem<String>(
  // //               value: item,
  // //               child: Text(
  // //                 option.title,
  // //                 style: AppTextStyles.textMedium16.copyWith(color: AppColors.charcoal),
  // //               ),
  // //             );
  // //           }).toList(),
  // //           onChanged: !widget.isDisabled
  // //               ? (value) {
  // //             setState(() {
  // //               widget.selectedValue = value;
  // //             });
  // //             widget.onChanged?.call(value!);
  // //           }
  // //               : null,
  // //           validator: widget.validator,
  // //           selectedItemBuilder: (context) {
  // //             return widget.items.map((item) {
  // //               final option = widget.options.firstWhere(
  // //                     (e) => e.value == widget.selectedValue,
  // //                 orElse: () => Option(value: widget.selectedValue ?? '', title: ''),
  // //               );
  // //               return Text(option.title);
  // //             }).toList();
  // //           },
  // //           icon: const AppImage(
  // //             assetPath: AppAssets.downArrow,
  // //             color: AppColors.gradient3Start,
  // //           ),
  // //         ),
  // //         if (widget.errorText.isNotEmpty && !widget.isDisabled)
  // //           Padding(
  // //             padding: const EdgeInsets.only(left: 8.0, top: 4.0),
  // //             child: Text(
  // //               widget.errorText,
  // //               style: AppTextStyles.textMedium12.copyWith(color: AppColors.brightErrorRed),
  // //             ),
  // //           ),
  // //       ],
  // //     );
  // //   }
  // // }


  // class AppDropdown extends StatelessWidget {
  //   final List<String> items;
  //   final String? selectedValue;
  //   final bool isDisabled;
  //   final String? placeholder;
  //   final String? hintText;
  //   final bool isMandatory;
  //   final bool showInfo;
  //   final String infoSubTitle;
  //   final String errorText;
  //   final String? Function(String?)? validator;
  //   final void Function(String)? onChanged;
  //   final List<Option> options;

  //   AppDropdown({
  //     super.key,
  //     required this.items,
  //     this.selectedValue,
  //     this.isDisabled = false,
  //     this.placeholder,
  //     this.hintText,
  //     this.isMandatory = false,
  //     this.showInfo = false,
  //     this.infoSubTitle = '',
  //     this.errorText = '',
  //     this.validator,
  //     this.onChanged,
  //     this.options = const <Option>[],
  //   }) : assert(options.isEmpty || options.length == items.length);

  //   @override
  //   Widget build(BuildContext context) {
  //     final AppDropdownController controller = Get.put(AppDropdownController());
  //     // controller.setDefaultValue(selectedValue);
  //     final borderColor =
  //         controller.focusNode.hasFocus ? AppColors.primaryOrange : Colors.transparent;
  //     final border = OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       borderSide: BorderSide(color: borderColor, width: 1.5),
  //     );
  //     return

  //       Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 8.0, left: 3.0),
  //           child: Row(
  //             children: [
  //               Text(
  //                 placeholder!,
  //                 style: AppTextStyles.textSemiBold12.copyWith(color: AppColors.subtextGrey),
  //               ),
  //               if (isMandatory)
  //                 Text(
  //                   ' *',
  //                   style: AppTextStyles.textSemiBold12.copyWith(color: AppColors.brightErrorRed),
  //                 ),
  //               if (showInfo)
  //                 GestureDetector(
  //                   onTap: () {
  //                     showModalBottomSheet(
  //                       context: context,
  //                       shape: AppSheetStyle.bottomSheetShape,
  //                       builder: (context) {
  //                         return InfoSheet(title: placeholder!, subTitle: infoSubTitle);
  //                       },
  //                     );
  //                   },
  //                   child: const Padding(
  //                     padding: EdgeInsets.only(left: 4),
  //                     child: AppImage(assetPath: AppAssets.info),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //         DropdownButtonFormField<String>(
  //             borderRadius: BorderRadius.circular(8),
  //             hint: Text(hintText!),

  //             focusNode: controller.focusNode,
  //             decoration: InputDecoration(
  //               fillColor: isDisabled? AppColors.chalkBorder: AppColors.lightGrey,
  //               labelStyle: const TextStyle(color: AppColors.charcoal),
  //               filled: true,
  //               // hintText: hintText,
  //               enabled: !isDisabled,
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 borderSide: BorderSide.none,
  //               ),
  //               focusedBorder: border,
  //               errorBorder: border,
  //               disabledBorder: border,
  //                 errorStyle: AppTextStyles.textMedium12.copyWith(color: AppColors.brightErrorRed)
  //             ),
  //             value: selectedValue,
  //             // ,
  //             // controller.selectedValue.value.isNotEmpty
  //             //     ? controller.selectedValue.value
  //             //     : null,
  //             dropdownColor: AppColors.white,
  //             isExpanded: false,
  //             items: items.map((item) {
  //               return DropdownMenuItem<String>(
  //                 value: item,
  //                 child: Container(
  //                   padding: const EdgeInsets.only(left: 5),
  //                   child: Text(
  //                     options.firstWhereOrNull((e) => e.value == item)?.title ?? item,
  //                     style: AppTextStyles.textMedium16.copyWith(color: AppColors.charcoal),
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //             onChanged: !isDisabled
  //                 ? (value) {
  //                     if (value != null) {
  //                       controller.selectedValue.value = value;
  //                       if (onChanged != null) {
  //                         onChanged!(value);
  //                       }
  //                     }
  //                   }
  //                 : null,
  //             validator: validator,
  //             selectedItemBuilder: (context) {
  //               return items.map(
  //                 (e) {
  //                   return Text(options.firstWhereOrNull((e) => e.value == selectedValue)?.title ??
  //                       selectedValue ??
  //                       "");
  //                 },
  //               ).toList();
  //             },
  //             icon: const AppImage(
  //               assetPath: AppAssets.downArrow,
  //               color: AppColors.gradient3Start,
  //             )),
  //         if (errorText != '' && !isDisabled)
  //           Padding(
  //             padding: const EdgeInsets.only(left: 8.0, top: 4.0),
  //             child: Text(
  //               errorText,
  //               style: AppTextStyles.textMedium12.copyWith(color: AppColors.brightErrorRed),
  //             ),
  //           ),
  //       ],
  //     );


  //   }
  // }


