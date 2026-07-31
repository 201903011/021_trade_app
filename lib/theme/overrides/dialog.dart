import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class DialogOverrides {
  static DialogTheme create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return DialogTheme(
      backgroundColor: customTheme.palette.background.paper,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: customTheme.palette.common.divider.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: customTheme.typography.h6.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: customTheme.typography.body1.copyWith(
        color: customTheme.palette.text.secondary,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      // titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      // contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      alignment: Alignment.center,
    );
  }

  /// Creates a full-screen dialog
  static DialogTheme createFullScreen(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: customTheme.palette.background.defaultColor,
      shape: const RoundedRectangleBorder(),
      insetPadding: EdgeInsets.zero,
    );
  }

  /// Creates a bottom sheet dialog
  static DialogTheme createBottomSheet(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(top: 56),
    );
  }

  /// Creates a compact dialog
  static DialogTheme createCompact(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      // titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      // contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Creates a dialog with custom padding
  static DialogTheme createCustomPadding(
    ThemeData baseTheme,
    CustomThemeExtension customTheme, {
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
  }) {
    return create(baseTheme, customTheme).copyWith(
      // titlePadding: titlePadding ?? const EdgeInsets.fromLTRB(24, 24, 24, 16),
      // contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(24, 0, 24, 16),
      actionsPadding: actionsPadding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
    );
  }
}
