import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class ButtonOverrides {
  /// Common button padding
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  /// Common button shape
  static const OutlinedBorder defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  /// Small button padding
  static const EdgeInsetsGeometry smallPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  /// Large button padding
  static const EdgeInsetsGeometry largePadding = EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  /// Common button minimum size
  static const Size defaultMinimumSize = Size(88, 48);

  /// Small button minimum size
  static const Size smallMinimumSize = Size(64, 32);

  /// Large button minimum size
  static const Size largeMinimumSize = Size(112, 56);

  /// Get button text style based on size
  static TextStyle? getButtonTextStyle(CustomThemeExtension customTheme, ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return customTheme.typography.caption.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
      case ButtonSize.large:
        return customTheme.typography.button.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontSize: 16,
        );
      case ButtonSize.medium:
        return customTheme.typography.button.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        );
    }
  }

  /// Get button padding based on size
  static EdgeInsetsGeometry getButtonPadding(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return smallPadding;
      case ButtonSize.large:
        return largePadding;
      case ButtonSize.medium:
        return defaultPadding;
    }
  }

  /// Get button minimum size based on size
  static Size getButtonMinimumSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return smallMinimumSize;
      case ButtonSize.large:
        return largeMinimumSize;
      case ButtonSize.medium:
        return defaultMinimumSize;
    }
  }
}

/// Button size variants
enum ButtonSize {
  small,
  medium,
  large,
}

/// Button variant types
enum ButtonVariant {
  contained,
  outlined,
  text,
}

/// Button color variants
enum ButtonColor {
  primary,
  secondary,
  error,
  warning,
  info,
  success,
}

/// Helper extension to get colors from ButtonColor enum
extension ButtonColorExtension on ButtonColor {
  Color getColor(CustomThemeExtension customTheme) {
    switch (this) {
      case ButtonColor.primary:
        return customTheme.palette.common.primary.main;
      case ButtonColor.secondary:
        return customTheme.palette.common.secondary.main;
      case ButtonColor.error:
        return customTheme.palette.common.error.main;
      case ButtonColor.warning:
        return customTheme.palette.common.warning.main;
      case ButtonColor.info:
        return customTheme.palette.common.info.main;
      case ButtonColor.success:
        return customTheme.palette.common.success.main;
    }
  }

  Color getContrastColor(CustomThemeExtension customTheme) {
    switch (this) {
      case ButtonColor.primary:
        return customTheme.palette.common.primary.contrastText;
      case ButtonColor.secondary:
        return customTheme.palette.common.secondary.contrastText;
      case ButtonColor.error:
        return customTheme.palette.common.error.contrastText;
      case ButtonColor.warning:
        return Colors.white;
      case ButtonColor.info:
        return Colors.white;
      case ButtonColor.success:
        return Colors.white;
    }
  }
}
