import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class CheckboxOverrides {
  static CheckboxThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabledBackground;
        }
        if (states.contains(WidgetState.selected)) {
          return customTheme.palette.common.primary.main;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.primary.contrastText;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return customTheme.palette.common.primary.main.withOpacity(0.04);
        }
        if (states.contains(WidgetState.focused)) {
          return customTheme.palette.common.primary.main.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return customTheme.palette.common.primary.main.withOpacity(0.12);
        }
        return null;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: customTheme.palette.action.disabled,
            width: 2,
          );
        }
        if (states.contains(WidgetState.selected)) {
          return BorderSide(
            color: customTheme.palette.common.primary.main,
            width: 2,
          );
        }
        return BorderSide(
          color: customTheme.palette.common.divider,
          width: 2,
        );
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
    );
  }

  /// Creates a rounded checkbox
  static CheckboxThemeData createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Creates a circular checkbox
  static CheckboxThemeData createCircular(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: const CircleBorder(),
    );
  }

  /// Creates a secondary color checkbox
  static CheckboxThemeData createSecondary(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabledBackground;
        }
        if (states.contains(WidgetState.selected)) {
          return customTheme.palette.common.secondary.main;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.secondary.contrastText;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: customTheme.palette.action.disabled,
            width: 2,
          );
        }
        if (states.contains(WidgetState.selected)) {
          return BorderSide(
            color: customTheme.palette.common.secondary.main,
            width: 2,
          );
        }
        return BorderSide(
          color: customTheme.palette.common.divider,
          width: 2,
        );
      }),
    );
  }

  /// Creates an error color checkbox
  static CheckboxThemeData createError(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabledBackground;
        }
        if (states.contains(WidgetState.selected)) {
          return customTheme.palette.common.error.main;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return customTheme.palette.common.error.contrastText;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: customTheme.palette.action.disabled,
            width: 2,
          );
        }
        if (states.contains(WidgetState.selected)) {
          return BorderSide(
            color: customTheme.palette.common.error.main,
            width: 2,
          );
        }
        return BorderSide(
          color: customTheme.palette.common.divider,
          width: 2,
        );
      }),
    );
  }

  /// Creates a large checkbox
  static CheckboxThemeData createLarge(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.comfortable,
    );
  }

  /// Creates a small checkbox
  static CheckboxThemeData createSmall(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
