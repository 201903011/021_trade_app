import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum InputVariant {
  filled,
  outlined,
  standard,
}

enum InputSize {
  small,
  medium,
  large,
}

/// A generic, themeable text input component
class CustomTextInput extends StatefulWidget {
  /// The controller for the text field
  final TextEditingController? controller;

  /// The label text
  final String? label;

  /// The hint text
  final String? hintText;

  /// The helper text
  final String? helperText;

  /// The error text
  final String? errorText;

  /// Input variant (filled, outlined, standard)
  final InputVariant variant;

  /// Input size (small, medium, large)
  final InputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Whether the input is required
  final bool required;

  /// Whether the input should be obscured (for passwords)
  final bool obscureText;

  /// The keyboard type
  final TextInputType keyboardType;

  /// The text input action
  final TextInputAction textInputAction;

  /// Callback when the text changes
  final ValueChanged<String>? onChanged;

  /// Callback when the field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Callback when the focus changes
  final ValueChanged<bool>? onFocusChange;

  /// Custom validator function
  final String? Function(String?)? validator;

  /// Maximum number of lines
  final int? maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum length of input
  final int? maxLength;

  /// Prefix icon
  final IconData? prefixIcon;

  /// Suffix icon
  final IconData? suffixIcon;

  /// Suffix icon callback
  final VoidCallback? onSuffixIconPressed;

  /// Custom prefix widget
  final Widget? prefix;

  /// Custom suffix widget
  final Widget? suffix;

  /// Whether to show character counter
  final bool showCounter;

  /// Custom input decoration
  final InputDecoration? decoration;

  /// Auto focus
  final bool autofocus;

  /// Whether to expand to fill available width
  final bool fullWidth;

  

  const CustomTextInput({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.variant = InputVariant.outlined,
    this.size = InputSize.medium,
    this.disabled = false,
    this.required = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChange,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.prefix,
    this.suffix,
    this.showCounter = false,
    this.decoration,
    this.autofocus = false,
    this.fullWidth = true,
  });

  /// Factory constructor for search input
  factory CustomTextInput.search({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hintText = 'Search...',
    InputVariant variant = InputVariant.outlined,
    InputSize size = InputSize.medium,
    bool disabled = false,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool autofocus = false,
    bool fullWidth = true,
  }) {
    return CustomTextInput(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      variant: variant,
      size: size,
      disabled: disabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefixIcon: Icons.search,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      autofocus: autofocus,
      fullWidth: fullWidth,
    );
  }

  /// Factory constructor for password input
  factory CustomTextInput.password({
    Key? key,
    TextEditingController? controller,
    String? label = 'Password',
    String? hintText,
    InputVariant variant = InputVariant.outlined,
    InputSize size = InputSize.medium,
    bool disabled = false,
    bool required = true,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    bool autofocus = false,
    bool fullWidth = true,
  }) {
    return CustomTextInput(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      variant: variant,
      size: size,
      disabled: disabled,
      required: required,
      obscureText: true,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofocus: autofocus,
      fullWidth: fullWidth,
    );
  }

  /// Factory constructor for email input
  factory CustomTextInput.email({
    Key? key,
    TextEditingController? controller,
    String? label = 'Email',
    String? hintText,
    InputVariant variant = InputVariant.outlined,
    InputSize size = InputSize.medium,
    bool disabled = false,
    bool required = true,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    bool autofocus = false,
    bool fullWidth = true,
  }) {
    return CustomTextInput(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      variant: variant,
      size: size,
      disabled: disabled,
      required: required,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: autofocus,
      fullWidth: fullWidth,
    );
  }

  /// Factory constructor for textarea
  factory CustomTextInput.textarea({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hintText,
    String? helperText,
    String? errorText,
    InputVariant variant = InputVariant.outlined,
    InputSize size = InputSize.medium,
    bool disabled = false,
    bool required = false,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    int maxLines = 4,
    int? minLines = 2,
    int? maxLength,
    bool showCounter = true,
    bool autofocus = false,
    bool fullWidth = true,
  }) {
    return CustomTextInput(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      variant: variant,
      size: size,
      disabled: disabled,
      required: required,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      showCounter: showCounter,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      autofocus: autofocus,
      fullWidth: fullWidth,
    );
  }

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscureText = widget.obscureText;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    widget.onFocusChange?.call(_isFocused);
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    // Get size-based styling
    final contentPadding = _getContentPadding();
    final fontSize = _getFontSize();
    final borderRadius = _getBorderRadius();

    // Build decoration
    final inputDecoration = _buildInputDecoration(theme, contentPadding, borderRadius, fontSize);

    final textField = TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: !widget.disabled,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      style: theme.typography.body1.copyWith(
        fontSize: fontSize,
        color: widget.disabled ? theme.palette.text.disabled : theme.palette.text.primary,
      ),
      decoration: widget.decoration ?? inputDecoration,
      buildCounter: widget.showCounter && widget.maxLength != null
          ? (context, {required currentLength, required isFocused, maxLength}) {
              return Text(
                '$currentLength/${maxLength ?? ''}',
                style: theme.typography.caption.copyWith(
                  color: theme.palette.text.secondary,
                ),
              );
            }
          : null,
    );

    if (widget.fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: textField,
      );
    }

    return textField;
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (widget.size) {
      case InputSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case InputSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case InputSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case InputSize.small:
        return 14;
      case InputSize.medium:
        return 16;
      case InputSize.large:
        return 18;
    }
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.circular(8);
  }

  InputDecoration _buildInputDecoration(UseTheme theme, EdgeInsetsGeometry contentPadding, BorderRadius borderRadius, double fontSize) {
    final hasError = widget.errorText != null;
    final isDisabled = widget.disabled;

    // Build prefix icon
    Widget? prefixIconWidget;
    if (widget.prefixIcon != null || widget.prefix != null) {
      prefixIconWidget = widget.prefix ??
          Icon(
            widget.prefixIcon,
            size: 20,
            color: hasError
                ? theme.error
                : _isFocused
                    ? theme.primary
                    : isDisabled
                        ? theme.palette.text.disabled
                        : theme.palette.text.secondary,
          );
    }

    // Build suffix icon
    Widget? suffixIconWidget;
    if (widget.obscureText) {
      suffixIconWidget = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
          color: theme.palette.text.secondary,
        ),
        onPressed: _toggleObscureText,
      );
    } else if (widget.suffixIcon != null || widget.suffix != null) {
      suffixIconWidget = widget.suffix ??
          IconButton(
            icon: Icon(
              widget.suffixIcon,
              size: 20,
              color: hasError
                  ? theme.error
                  : _isFocused
                      ? theme.primary
                      : isDisabled
                          ? theme.palette.text.disabled
                          : theme.palette.text.secondary,
            ),
            onPressed: widget.onSuffixIconPressed,
          );
    }

    // Build borders based on variant
    InputBorder border;
    InputBorder focusedBorder;
    InputBorder errorBorder;
    Color? fillColor;

    switch (widget.variant) {
      case InputVariant.filled:
        fillColor = theme.palette.background.neutral;
        border = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.primary, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.error, width: 2),
        );
        break;

      case InputVariant.outlined:
        border = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: isDisabled ? theme.palette.action.disabled : theme.palette.common.divider,
          ),
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.primary, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.error, width: 2),
        );
        break;

      case InputVariant.standard:
        border = UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDisabled ? theme.palette.action.disabled : theme.palette.common.divider,
          ),
        );
        focusedBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: theme.primary, width: 2),
        );
        errorBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: theme.error, width: 2),
        );
        break;
    }

    return InputDecoration(
      labelText: widget.label,
      hintText: widget.hintText,
      helperText: widget.helperText,
      errorText: widget.errorText,
      prefixIcon: prefixIconWidget,
      suffixIcon: suffixIconWidget,
      filled: widget.variant == InputVariant.filled,
      fillColor: fillColor,
      contentPadding: contentPadding,
      border: border,
      enabledBorder: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      disabledBorder: border.copyWith(
        borderSide: BorderSide(color: theme.palette.action.disabled),
      ),
      hintStyle: theme.typography.body1.copyWith(
        fontSize: fontSize,
        color: theme.palette.text.disabled,
      ),
      helperStyle: theme.typography.caption.copyWith(
        color: theme.palette.text.secondary,
      ),
      errorStyle: theme.typography.caption.copyWith(
        color: theme.error,
      ),
    );
  }
}
