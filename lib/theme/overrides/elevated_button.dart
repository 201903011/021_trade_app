// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class ElevatedButtonOverrides {
  static ElevatedButtonThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: customTheme.palette.common.primary.main,
        foregroundColor: customTheme.palette.common.primary.contrastText,
        disabledBackgroundColor: customTheme.palette.action.disabledBackground,
        disabledForegroundColor: customTheme.palette.action.disabled,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: customTheme.typography.button.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        // Material state properties
        overlayColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return customTheme.palette.common.primary.main.withOpacity(0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return customTheme.palette.common.primary.main.withOpacity(0.12);
          }
          if (states.contains(WidgetState.pressed)) {
            return customTheme.palette.common.primary.main.withOpacity(0.16);
          }
          return Colors.transparent;
        }),
      ),
    );
  }

  /// Creates a small elevated button variant
  static ButtonStyle createSmall(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          minimumSize: WidgetStateProperty.all(const Size(64, 32)),
          textStyle: WidgetStateProperty.all(
            customTheme.typography.caption.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        );
  }

  /// Creates a large elevated button variant
  static ButtonStyle createLarge(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          minimumSize: WidgetStateProperty.all(const Size(112, 56)),
          textStyle: WidgetStateProperty.all(
            customTheme.typography.button.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 16,
            ),
          ),
        );
  }

  /// Creates a secondary color elevated button
  static ButtonStyle createSecondary(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabledBackground;
        }
        return customTheme.palette.common.secondary.main;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.secondary.contrastText;
      }),
    );
  }

  /// Creates an error color elevated button
  static ButtonStyle createError(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabledBackground;
        }
        return customTheme.palette.common.error.main;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.error.contrastText;
      }),
    );
  }

  /// Creates a rounded elevated button
  static ButtonStyle createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );
  }

  /// Creates a pill-shaped elevated button
  static ButtonStyle createPill(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
        );
  }
}
