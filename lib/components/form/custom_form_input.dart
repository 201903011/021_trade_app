import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimals/theme/use_theme.dart';

/// A comprehensive form input component
class CustomFormInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool required;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final FormInputVariant variant;
  final FormInputSize size;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final bool showCounter;

  const CustomFormInput({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.variant = FormInputVariant.outlined,
    this.size = FormInputSize.medium,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius = 8.0,
    this.showCounter = false,
  });

  @override
  State<CustomFormInput> createState() => _CustomFormInputState();
}

class _CustomFormInputState extends State<CustomFormInput> {
  late TextEditingController _controller;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) _buildLabel(palette),
        _buildInput(palette),
        if (widget.helperText != null || widget.errorText != null || widget.showCounter) _buildHelperText(palette),
      ],
    );
  }

  Widget _buildLabel(dynamic palette) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: widget.label,
          style: TextStyle(
            color: palette.text.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          children: [
            if (widget.required)
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: palette.common.error.main,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(dynamic palette) {
    final hasError = widget.errorText != null;
    final inputPadding = _getInputPadding();
    final suffixIcon = _buildSuffixIcon(palette);

    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: _obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(
        color: widget.enabled ? palette.text.primary : palette.text.disabled,
        fontSize: _getFontSize(),
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: palette.text.secondary,
          fontSize: _getFontSize(),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: widget.contentPadding ?? inputPadding,
        filled: widget.variant == FormInputVariant.filled,
        fillColor: widget.backgroundColor ?? _getBackgroundColor(palette),
        border: _getBorder(palette, false, hasError),
        enabledBorder: _getBorder(palette, false, hasError),
        focusedBorder: _getBorder(palette, true, hasError),
        errorBorder: _getBorder(palette, false, true),
        focusedErrorBorder: _getBorder(palette, true, true),
        counterText: widget.showCounter ? null : '',
        errorText: widget.errorText,
        errorStyle: TextStyle(
          color: palette.common.error.main,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon(dynamic palette) {
    if (widget.obscureText) {
      return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: palette.text.secondary,
        ),
      );
    }
    return widget.suffixIcon;
  }

  Widget _buildHelperText(dynamic palette) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Expanded(
            child: widget.errorText != null
                ? Text(
                    widget.errorText!,
                    style: TextStyle(
                      color: palette.common.error.main,
                      fontSize: 12,
                    ),
                  )
                : widget.helperText != null
                    ? Text(
                        widget.helperText!,
                        style: TextStyle(
                          color: palette.text.secondary,
                          fontSize: 12,
                        ),
                      )
                    : const SizedBox.shrink(),
          ),
          if (widget.showCounter && widget.maxLength != null)
            Text(
              '${_controller.text.length}/${widget.maxLength}',
              style: TextStyle(
                color: palette.text.secondary,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  EdgeInsetsGeometry _getInputPadding() {
    switch (widget.size) {
      case FormInputSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case FormInputSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case FormInputSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case FormInputSize.small:
        return 13;
      case FormInputSize.medium:
        return 14;
      case FormInputSize.large:
        return 16;
    }
  }

  Color? _getBackgroundColor(dynamic palette) {
    if (widget.variant == FormInputVariant.filled) {
      return palette.background.neutral;
    }
    return null;
  }

  InputBorder _getBorder(dynamic palette, bool focused, bool hasError) {
    Color borderColor;

    if (hasError) {
      borderColor = palette.common.error.main;
    } else if (focused) {
      borderColor = widget.focusedBorderColor ?? palette.common.primary.main;
    } else {
      borderColor = widget.borderColor ?? palette.common.divider;
    }

    switch (widget.variant) {
      case FormInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: focused ? 2.0 : 1.0,
          ),
        );
      case FormInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        );
      case FormInputVariant.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: focused ? 2.0 : 1.0,
          ),
        );
    }
  }
}

/// Form input variant enumeration
enum FormInputVariant {
  outlined,
  filled,
  underline,
}

/// Form input size enumeration
enum FormInputSize {
  small,
  medium,
  large,
}
