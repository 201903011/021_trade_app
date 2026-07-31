import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class OutlinedButtonOverrides {
  static OutlinedButtonThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: customTheme.palette.common.primary.main,
        disabledForegroundColor: customTheme.palette.action.disabled,
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: customTheme.typography.button.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        side: BorderSide(
          color: customTheme.palette.common.primary.main.withOpacity(0.28),
          width: 2,
        ),
        overlayColor: customTheme.palette.common.primary.main,
      ),
    );
  }

  /// Creates a small outlined button variant
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

  /// Creates a large outlined button variant
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

  /// Creates a secondary color outlined button
  static ButtonStyle createSecondary(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.secondary.main;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: customTheme.palette.action.disabled,
            width: 1,
          );
        }
        if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
          return BorderSide(
            color: customTheme.palette.common.secondary.main,
            width: 2,
          );
        }
        return BorderSide(
          color: customTheme.palette.common.secondary.main,
          width: 1,
        );
      }),
    );
  }

  /// Creates an error color outlined button
  static ButtonStyle createError(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.error.main;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: customTheme.palette.action.disabled,
            width: 1,
          );
        }
        if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
          return BorderSide(
            color: customTheme.palette.common.error.main,
            width: 2,
          );
        }
        return BorderSide(
          color: customTheme.palette.common.error.main,
          width: 1,
        );
      }),
    );
  }

  /// Creates a dashed outlined button
  static ButtonStyle createDashed(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          // Note: Flutter doesn't support dashed borders natively
          // This would require custom painting or third-party packages
          side: WidgetStateProperty.all(
            BorderSide(
              color: customTheme.palette.common.primary.main,
              width: 1,
            ),
          ),
        );
  }

  /// Creates a rounded outlined button
  static ButtonStyle createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );
  }

  /// Creates a pill-shaped outlined button
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
