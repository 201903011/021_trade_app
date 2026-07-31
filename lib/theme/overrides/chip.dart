import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class ChipOverrides {
  static ChipThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return ChipThemeData(
      backgroundColor: customTheme.palette.background.neutral,
      selectedColor: customTheme.palette.common.primary.main.withOpacity(0.1),
      disabledColor: customTheme.palette.action.disabledBackground,
      deleteIconColor: customTheme.palette.text.secondary,
      brightness: baseTheme.brightness,
      labelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.secondary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide(
        color: customTheme.palette.common.divider,
        width: 1,
      ),
      iconTheme: IconThemeData(
        color: customTheme.palette.text.secondary,
        size: 18,
      ),
      elevation: 0,
      pressElevation: 0,
      shadowColor: Colors.transparent,
    );
  }

  /// Creates a filled chip
  static ChipThemeData createFilled(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: customTheme.palette.common.primary.main.withOpacity(0.1),
      selectedColor: customTheme.palette.common.primary.main.withOpacity(0.2),
      side: BorderSide.none,
      labelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.common.primary.main,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Creates an outlined chip
  static ChipThemeData createOutlined(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: Colors.transparent,
      selectedColor: customTheme.palette.common.primary.main.withOpacity(0.1),
      side: BorderSide(
        color: customTheme.palette.common.primary.main,
        width: 1,
      ),
      labelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.common.primary.main,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Creates a small chip
  static ChipThemeData createSmall(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      labelPadding: const EdgeInsets.symmetric(horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: customTheme.typography.caption.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: customTheme.palette.text.secondary,
        size: 16,
      ),
    );
  }

  /// Creates a large chip
  static ChipThemeData createLarge(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: customTheme.typography.subtitle2.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: customTheme.palette.text.secondary,
        size: 20,
      ),
    );
  }

  /// Creates a secondary color chip
  static ChipThemeData createSecondary(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: customTheme.palette.common.secondary.main.withOpacity(0.1),
      selectedColor: customTheme.palette.common.secondary.main.withOpacity(0.2),
      side: BorderSide(
        color: customTheme.palette.common.secondary.main.withOpacity(0.3),
        width: 1,
      ),
      labelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.common.secondary.main,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Creates an error color chip
  static ChipThemeData createError(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: customTheme.palette.common.error.main.withOpacity(0.1),
      selectedColor: customTheme.palette.common.error.main.withOpacity(0.2),
      side: BorderSide(
        color: customTheme.palette.common.error.main.withOpacity(0.3),
        width: 1,
      ),
      labelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.common.error.main,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Creates a success color chip
  static ChipThemeData createSuccess(ThemeData baseTheme, CustomThemeExtension customTheme) {
    final successColor = customTheme.palette.common.success.main;
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: successColor.withOpacity(0.1),
      selectedColor: successColor.withOpacity(0.2),
      side: BorderSide(
        color: successColor.withOpacity(0.3),
        width: 1,
      ),
      labelStyle: customTheme.typography.body2.copyWith(
        color: successColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Creates a warning color chip
  static ChipThemeData createWarning(ThemeData baseTheme, CustomThemeExtension customTheme) {
    final warningColor = customTheme.palette.common.warning.main;
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: warningColor.withOpacity(0.1),
      selectedColor: warningColor.withOpacity(0.2),
      side: BorderSide(
        color: warningColor.withOpacity(0.3),
        width: 1,
      ),
      labelStyle: customTheme.typography.body2.copyWith(
        color: warningColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Creates a rounded chip
  static ChipThemeData createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  /// Creates a square chip
  static ChipThemeData createSquare(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
