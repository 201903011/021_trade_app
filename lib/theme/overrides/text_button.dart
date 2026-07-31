import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class TextButtonOverrides {
  static TextButtonThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
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
        overlayColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return customTheme.palette.common.primary.main.withOpacity(0.04);
          }
          if (states.contains(WidgetState.focused)) {
            return customTheme.palette.common.primary.main.withOpacity(0.08);
          }
          if (states.contains(WidgetState.pressed)) {
            return customTheme.palette.common.primary.main.withOpacity(0.12);
          }
          return Colors.transparent;
        }),
      ),
    );
  }

  /// Creates a small text button variant
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

  /// Creates a large text button variant
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

  /// Creates a secondary color text button
  static ButtonStyle createSecondary(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.secondary.main;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return customTheme.palette.common.secondary.main.withOpacity(0.04);
        }
        if (states.contains(WidgetState.focused)) {
          return customTheme.palette.common.secondary.main.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return customTheme.palette.common.secondary.main.withOpacity(0.12);
        }
        return null;
      }),
    );
  }

  /// Creates an error color text button
  static ButtonStyle createError(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.error.main;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return customTheme.palette.common.error.main.withOpacity(0.04);
        }
        if (states.contains(WidgetState.focused)) {
          return customTheme.palette.common.error.main.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return customTheme.palette.common.error.main.withOpacity(0.12);
        }
        return null;
      }),
    );
  }

  /// Creates a text button with underline
  static ButtonStyle createUnderlined(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          textStyle: WidgetStateProperty.all(
            customTheme.typography.button.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              decoration: TextDecoration.underline,
            ),
          ),
        );
  }

  /// Creates a text button with icon space
  static ButtonStyle createWithIcon(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        );
  }

  /// Creates a compact text button (no padding)
  static ButtonStyle createCompact(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
  }

  /// Creates a rounded text button
  static ButtonStyle createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).style!.copyWith(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );
  }

  /// Creates a pill-shaped text button
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
