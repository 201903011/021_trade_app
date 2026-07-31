import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum CheckboxVariant {
  standard,
  rounded,
}

enum CheckboxSize {
  small,
  medium,
  large,
}

/// A generic, themeable checkbox component that integrates with the theme system
class CustomCheckbox extends StatelessWidget {
  /// The current value of the checkbox
  final bool? value;

  /// Callback when the checkbox value changes
  final ValueChanged<bool?>? onChanged;

  /// Checkbox variant (standard, rounded)
  final CheckboxVariant variant;

  /// Checkbox size (small, medium, large)
  final CheckboxSize size;

  /// Custom active color override
  final Color? activeColor;

  /// Custom check color override
  final Color? checkColor;

  /// Custom focus color override
  final Color? focusColor;

  /// Custom hover color override
  final Color? hoverColor;

  /// Whether the checkbox is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Helper text
  final String? helperText;

  /// Whether the checkbox is required
  final bool required;

  /// Custom border radius (for rounded variant)
  final BorderRadius? borderRadius;

  /// Auto focus
  final bool autofocus;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.variant = CheckboxVariant.standard,
    this.size = CheckboxSize.medium,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.disabled = false,
    this.label,
    this.helperText,
    this.required = false,
    this.borderRadius,
    this.autofocus = false,
  });

  /// Factory constructor for checkbox with label
  factory CustomCheckbox.withLabel({
    Key? key,
    required bool? value,
    required ValueChanged<bool?>? onChanged,
    required String label,
    CheckboxVariant variant = CheckboxVariant.standard,
    CheckboxSize size = CheckboxSize.medium,
    Color? activeColor,
    Color? checkColor,
    Color? focusColor,
    Color? hoverColor,
    bool disabled = false,
    String? helperText,
    bool required = false,
    BorderRadius? borderRadius,
    bool autofocus = false,
  }) {
    return CustomCheckbox(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: variant,
      size: size,
      activeColor: activeColor,
      checkColor: checkColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      disabled: disabled,
      label: label,
      helperText: helperText,
      required: required,
      borderRadius: borderRadius,
      autofocus: autofocus,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);
    final isDisabled = disabled || onChanged == null;

    // Get theme-based colors
    final checkboxActiveColor = _getActiveColor(theme);
    final checkboxCheckColor = _getCheckColor(theme);
    final checkboxFocusColor = _getFocusColor(theme);
    final checkboxHoverColor = _getHoverColor(theme);

    // Get size-based styling
    final labelStyle = _getLabelStyle(theme);
    final helperStyle = _getHelperStyle(theme);

    Widget checkbox = Transform.scale(
      scale: _getScaleFactor(),
      child: variant == CheckboxVariant.rounded
          ? _buildRoundedCheckbox(
              theme,
              checkboxActiveColor,
              checkboxCheckColor,
              checkboxFocusColor,
              checkboxHoverColor,
            )
          : Checkbox(
              value: value,
              onChanged: isDisabled ? null : onChanged,
              activeColor: checkboxActiveColor,
              checkColor: checkboxCheckColor,
              focusColor: checkboxFocusColor,
              hoverColor: checkboxHoverColor,
              autofocus: autofocus,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
    );

    if (label == null && helperText == null) {
      return checkbox;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          InkWell(
            onTap: isDisabled ? null : () => onChanged?.call(!(value ?? false)),
            borderRadius: BorderRadius.circular(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                checkbox,
                const SizedBox(width: 8),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: label!,
                      style: labelStyle.copyWith(
                        color: isDisabled ? theme.palette.text.disabled : theme.palette.text.primary,
                      ),
                      children: required
                          ? [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: theme.error),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          checkbox,
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              helperText!,
              style: helperStyle.copyWith(
                color: theme.palette.text.secondary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRoundedCheckbox(
    UseTheme theme,
    Color activeColor,
    Color checkColor,
    Color focusColor,
    Color hoverColor,
  ) {
    final isDisabled = disabled || onChanged == null;
    final checkboxBorderRadius = borderRadius ?? BorderRadius.circular(4);
    final checkboxSize = _getCheckboxSize();

    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged?.call(!(value ?? false)),
      child: Container(
        width: checkboxSize,
        height: checkboxSize,
        decoration: BoxDecoration(
          borderRadius: checkboxBorderRadius,
          color: value == true
              ? activeColor
              : isDisabled
                  ? theme.palette.action.disabledBackground
                  : Colors.transparent,
          border: Border.all(
            color: value == true
                ? activeColor
                : isDisabled
                    ? theme.palette.action.disabled
                    : theme.palette.common.divider,
            width: 2,
          ),
        ),
        child: value == true
            ? Icon(
                Icons.check,
                size: checkboxSize * 0.7,
                color: checkColor,
              )
            : null,
      ),
    );
  }

  double _getCheckboxSize() {
    switch (size) {
      case CheckboxSize.small:
        return 16;
      case CheckboxSize.medium:
        return 20;
      case CheckboxSize.large:
        return 24;
    }
  }

  double _getScaleFactor() {
    switch (size) {
      case CheckboxSize.small:
        return 0.8;
      case CheckboxSize.medium:
        return 1.0;
      case CheckboxSize.large:
        return 1.2;
    }
  }

  TextStyle _getLabelStyle(UseTheme theme) {
    switch (size) {
      case CheckboxSize.small:
        return theme.typography.caption;
      case CheckboxSize.medium:
        return theme.typography.body2;
      case CheckboxSize.large:
        return theme.typography.body1;
    }
  }

  TextStyle _getHelperStyle(UseTheme theme) {
    return theme.typography.caption;
  }

  Color _getActiveColor(UseTheme theme) {
    return activeColor ?? theme.primary;
  }

  Color _getCheckColor(UseTheme theme) {
    return checkColor ?? theme.palette.common.primary.contrastText;
  }

  Color _getFocusColor(UseTheme theme) {
    return focusColor ?? theme.primary.withOpacity(0.12);
  }

  Color _getHoverColor(UseTheme theme) {
    return hoverColor ?? theme.primary.withOpacity(0.04);
  }
}
