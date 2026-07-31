import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class DrawerOverrides {
  static DrawerThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return DrawerThemeData(
      backgroundColor: customTheme.palette.background.paper,
      surfaceTintColor: Colors.transparent,
      shadowColor: customTheme.palette.common.divider,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      width: 304,
      endShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
    );
  }
}
