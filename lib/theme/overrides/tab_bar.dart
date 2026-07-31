// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class TabBarOverrides {
  static TabBarTheme create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return TabBarTheme(
      labelColor: customTheme.palette.common.primary.main,
      unselectedLabelColor: customTheme.palette.text.secondary,
      labelStyle: customTheme.typography.button.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: customTheme.typography.button,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: customTheme.palette.common.primary.main,
          width: 2,
        ),
      ),
      indicatorColor: customTheme.palette.common.primary.main,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: customTheme.palette.common.divider,
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
    );
  }
}
