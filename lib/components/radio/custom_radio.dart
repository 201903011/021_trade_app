import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum RadioVariant {
  standard,
  button,
}

enum RadioSize {
  small,
  medium,
  large,
}

/// A generic, themeable radio button component
class CustomRadio<T> extends StatelessWidget {
  /// The value represented by this radio button
  final T value;

  /// The currently selected value
  final T? groupValue;

  /// Callback when the radio button is selected
  final ValueChanged<T?>? onChanged;

  /// Radio variant (standard, button)
  final RadioVariant variant;

  /// Radio size (small, medium, large)
  final RadioSize size;

  /// Custom active color override
  final Color? activeColor;

  /// Custom focus color override
  final Color? focusColor;

  /// Custom hover color override
  final Color? hoverColor;

  /// Whether the radio button is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Helper text
  final String? helperText;

  /// Auto focus
  final bool autofocus;

  /// Custom padding for button variant
  final EdgeInsetsGeometry? padding;

  /// Custom border radius for button variant
  final BorderRadius? borderRadius;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.variant = RadioVariant.standard,
    this.size = RadioSize.medium,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.disabled = false,
    this.label,
    this.helperText,
    this.autofocus = false,
    this.padding,
    this.borderRadius,
  });

  /// Factory constructor for radio with label
  factory CustomRadio.withLabel({
    Key? key,
    required T value,
    required T? groupValue,
    required ValueChanged<T?>? onChanged,
    required String label,
    RadioVariant variant = RadioVariant.standard,
    RadioSize size = RadioSize.medium,
    Color? activeColor,
    Color? focusColor,
    Color? hoverColor,
    bool disabled = false,
    String? helperText,
    bool autofocus = false,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return CustomRadio<T>(
      key: key,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      variant: variant,
      size: size,
      activeColor: activeColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      disabled: disabled,
      label: label,
      helperText: helperText,
      autofocus: autofocus,
      padding: padding,
      borderRadius: borderRadius,
    );
  }

  /// Factory constructor for button-style radio
  factory CustomRadio.button({
    Key? key,
    required T value,
    required T? groupValue,
    required ValueChanged<T?>? onChanged,
    required String label,
    RadioSize size = RadioSize.medium,
    Color? activeColor,
    Color? focusColor,
    Color? hoverColor,
    bool disabled = false,
    String? helperText,
    bool autofocus = false,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return CustomRadio<T>(
      key: key,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      variant: RadioVariant.button,
      size: size,
      activeColor: activeColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      disabled: disabled,
      label: label,
      helperText: helperText,
      autofocus: autofocus,
      padding: padding,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);
    final isDisabled = disabled || onChanged == null;
    final isSelected = value == groupValue;

    // Get theme-based colors
    final radioActiveColor = _getActiveColor(theme);
    final radioFocusColor = _getFocusColor(theme);
    final radioHoverColor = _getHoverColor(theme);

    // Get size-based styling
    final labelStyle = _getLabelStyle(theme);
    final helperStyle = _getHelperStyle(theme);

    Widget radioWidget;

    if (variant == RadioVariant.button) {
      radioWidget = _buildButtonRadio(
        theme,
        isSelected,
        isDisabled,
        radioActiveColor,
        radioFocusColor,
        radioHoverColor,
        labelStyle,
      );
    } else {
      radioWidget = Transform.scale(
        scale: _getScaleFactor(),
        child: Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: isDisabled ? null : onChanged,
          activeColor: radioActiveColor,
          focusColor: radioFocusColor,
          hoverColor: radioHoverColor,
          autofocus: autofocus,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      );
    }

    if (variant == RadioVariant.button) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          radioWidget,
          if (helperText != null) ...[
            const SizedBox(height: 4),
            Text(
              helperText!,
              style: helperStyle.copyWith(
                color: theme.palette.text.secondary,
              ),
            ),
          ],
        ],
      );
    }

    if (label == null && helperText == null) {
      return radioWidget;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          InkWell(
            onTap: isDisabled ? null : () => onChanged?.call(value),
            borderRadius: BorderRadius.circular(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                radioWidget,
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label!,
                    style: labelStyle.copyWith(
                      color: isDisabled ? theme.palette.text.disabled : theme.palette.text.primary,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          radioWidget,
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

  Widget _buildButtonRadio(
    UseTheme theme,
    bool isSelected,
    bool isDisabled,
    Color activeColor,
    Color focusColor,
    Color hoverColor,
    TextStyle labelStyle,
  ) {
    final radioPadding = padding ?? _getButtonPadding();
    final radioBorderRadius = borderRadius ?? _getButtonBorderRadius();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : () => onChanged?.call(value),
        borderRadius: radioBorderRadius,
        hoverColor: hoverColor,
        focusColor: focusColor,
        child: Container(
          padding: radioPadding,
          decoration: BoxDecoration(
            borderRadius: radioBorderRadius,
            border: Border.all(
              color: isSelected
                  ? activeColor
                  : isDisabled
                      ? theme.palette.action.disabled
                      : theme.palette.common.divider,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected
                ? activeColor.withOpacity(0.08)
                : isDisabled
                    ? theme.palette.action.disabledBackground
                    : Colors.transparent,
          ),
          child: Text(
            label ?? value.toString(),
            style: labelStyle.copyWith(
              color: isSelected
                  ? activeColor
                  : isDisabled
                      ? theme.palette.text.disabled
                      : theme.palette.text.primary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  double _getScaleFactor() {
    switch (size) {
      case RadioSize.small:
        return 0.8;
      case RadioSize.medium:
        return 1.0;
      case RadioSize.large:
        return 1.2;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case RadioSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case RadioSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case RadioSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  BorderRadius _getButtonBorderRadius() {
    switch (size) {
      case RadioSize.small:
        return BorderRadius.circular(6);
      case RadioSize.medium:
        return BorderRadius.circular(8);
      case RadioSize.large:
        return BorderRadius.circular(10);
    }
  }

  TextStyle _getLabelStyle(UseTheme theme) {
    switch (size) {
      case RadioSize.small:
        return theme.typography.caption;
      case RadioSize.medium:
        return theme.typography.body2;
      case RadioSize.large:
        return theme.typography.body1;
    }
  }

  TextStyle _getHelperStyle(UseTheme theme) {
    return theme.typography.caption;
  }

  Color _getActiveColor(UseTheme theme) {
    return activeColor ?? theme.primary;
  }

  Color _getFocusColor(UseTheme theme) {
    return focusColor ?? theme.primary.withOpacity(0.12);
  }

  Color _getHoverColor(UseTheme theme) {
    return hoverColor ?? theme.primary.withOpacity(0.04);
  }
}
