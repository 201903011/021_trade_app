import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class SwitchOverrides {
  static SwitchThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return customTheme.palette.common.common.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabledBackground;
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
        if (states.contains(WidgetState.selected)) {
          return customTheme.palette.common.primary.main.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return customTheme.palette.common.primary.main.withOpacity(0.12);
        }
        return null;
      }),
      trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
        return 0;
      }),
      trackOutlineColor: WidgetStateColor.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return customTheme.palette.action.disabledBackground;
          }
          if (states.contains(WidgetState.selected)) {
            return customTheme.palette.common.primary.main;
          }
          return customTheme.palette.common.divider;
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
