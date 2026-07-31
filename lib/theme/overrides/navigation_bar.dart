// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class NavigationBarOverrides {
  static NavigationBarThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return NavigationBarThemeData(
      backgroundColor: customTheme.palette.background.paper,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: customTheme.palette.common.divider,
      height: 80,
      indicatorColor: customTheme.palette.common.primary.main.withOpacity(0.1),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return customTheme.typography.caption.copyWith(
            color: customTheme.palette.common.primary.main,
            fontWeight: FontWeight.w600,
          );
        }
        return customTheme.typography.caption.copyWith(
          color: customTheme.palette.text.secondary,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: customTheme.palette.common.primary.main,
            size: 24,
          );
        }
        return IconThemeData(
          color: customTheme.palette.text.secondary,
          size: 24,
        );
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
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
