// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimals/components/input/custom_text_input.dart';
import 'package:minimals/theme/use_theme.dart';

class AppInputBox extends StatefulWidget {
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Widget? prefixIcon;
  final String placeholder;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool isMandatory;
  final bool isDisabled;
  final bool showInfo;
  final List<Widget> prefix;
  final List<Widget> suffix;
  final List<TextInputFormatter>? inputFormatters;
  final bool isCapital;
  final String customErrorText;
  final String infoTitle;
  final String infoSubTitle;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;

  final void Function(PointerDownEvent event)? onTapOutside;
  final bool isClearText;
  FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool isReadOnly;
  AppInputBox({
    super.key,
    this.suffixWidget,
    required this.placeholder,
    required this.hintText,
    this.validator,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    required this.controller,
    this.isMandatory = false,
    this.isDisabled = false,
    this.showInfo = false,
    this.prefix = const <Widget>[],
    this.suffix = const <Widget>[],
    this.inputFormatters,
    this.isCapital = false,
    this.customErrorText = '',
    this.infoTitle = '',
    this.infoSubTitle = '',
    this.onChanged,
    this.onEditingComplete,
    this.onTapOutside,
    this.focusNode,
    this.prefixWidget,
    this.isClearText = false,
    this.onTap,
    this.prefixIcon,
    this.isReadOnly = false,
  });

  @override
  AppInputBoxInputBoxState createState() => AppInputBoxInputBoxState();
}

class AppInputBoxInputBoxState extends State<AppInputBox> {
  final bool _obscureText = true;
  late final FocusNode _focusNode = FocusNode()..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
    widget.focusNode ??= FocusNode();
    widget.focusNode?.addListener(() => setState(() {}));
    if (widget.isCapital) {
      widget.controller.addListener(() {
        final text = widget.controller.text.toUpperCase();
        if (widget.controller.text != text) {
          widget.controller.value = widget.controller.value.copyWith(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return FormField<String>(
      key: widget.key,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              if (widget.placeholder != "")
                Padding(
                  padding: const EdgeInsets.only(bottom: 1.0, left: 3.0),
                  child: Text(
                    widget.placeholder,
                    style: customTheme.typography.subtitle2.copyWith(
                      color: widget.isDisabled ? customTheme.palette.text.disabled : customTheme.palette.text.primary,
                    ),
                  ),
                ),
              if (widget.isMandatory)
                Text(
                  ' *',
                  style: customTheme.typography.body1.copyWith(color: customTheme.palette.common.error.main),
                ),
            ]),
            const SizedBox(height: 8),
            Row(
              children: [
                ...widget.prefix,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: _focusNode.hasFocus
                          ? [
                              BoxShadow(
                                color: customTheme.palette.action.hover,
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(0, 0),
                              ),
                            ]
                          : null,
                    ),
                    child: CustomTextInput(
                      controller: widget.controller,
                      obscureText: widget.isPassword ? _obscureText : false,
                      keyboardType: widget.inputType,
                      onChanged: (value) {
                        state.didChange.call(value);
                        widget.onChanged?.call(value);
                      },
                    ),
                  ),
                ),
                ...widget.suffix,
              ],
            ),
            if (state.errorText != null && !widget.isDisabled)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${state.errorText!}*',
                  style: baseTheme.textTheme.bodySmall?.copyWith(color: customTheme.palette.common.error.main),
                ),
              ),
            if (widget.customErrorText != '')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.customErrorText}*',
                  style: baseTheme.textTheme.bodySmall?.copyWith(color: customTheme.palette.common.error.main),
                ),
              ),
          ],
        );
      },
    );
  }
}
