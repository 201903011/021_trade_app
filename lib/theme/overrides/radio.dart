import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class RadioOverrides {
  static RadioThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        if (states.contains(WidgetState.selected)) {
          return customTheme.palette.common.primary.main;
        }
        return customTheme.palette.common.divider;
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
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
    );
  }
}
