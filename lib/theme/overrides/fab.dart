import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class FloatingActionButtonOverrides {
  static FloatingActionButtonThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: customTheme.palette.common.primary.main,
      foregroundColor: customTheme.palette.common.primary.contrastText,
      focusColor: customTheme.palette.common.primary.main.withOpacity(0.12),
      hoverColor: customTheme.palette.common.primary.main.withOpacity(0.08),
      splashColor: customTheme.palette.common.primary.main.withOpacity(0.12),
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 8,
      highlightElevation: 12,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enableFeedback: true,
      sizeConstraints: const BoxConstraints.tightFor(
        width: 56,
        height: 56,
      ),
      smallSizeConstraints: const BoxConstraints.tightFor(
        width: 40,
        height: 40,
      ),
      largeSizeConstraints: const BoxConstraints.tightFor(
        width: 96,
        height: 96,
      ),
      extendedSizeConstraints: const BoxConstraints.tightFor(
        height: 48,
      ),
      extendedIconLabelSpacing: 8,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 16),
      extendedTextStyle: customTheme.typography.button.copyWith(
        color: customTheme.palette.common.primary.contrastText,
        fontWeight: FontWeight.w600,
      ),
      iconSize: 24,
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      }),
    );
  }
}
