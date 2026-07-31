import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../custom_theme_extension.dart';

class AppBarOverrides {
  static AppBarTheme create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return AppBarTheme(
      backgroundColor: customTheme.palette.background.paper,
      foregroundColor: customTheme.palette.text.primary,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: customTheme.palette.common.divider,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleSpacing: 16,
      toolbarHeight: 64,
      titleTextStyle: customTheme.typography.h6.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w600,
      ),
      actionsIconTheme: IconThemeData(
        color: customTheme.palette.text.secondary,
        size: 24,
      ),
      iconTheme: IconThemeData(
        color: customTheme.palette.text.secondary,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: baseTheme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
        statusBarBrightness: baseTheme.brightness == Brightness.light ? Brightness.light : Brightness.dark,
      ),
    );
  }

  /// Creates a transparent AppBar variant
  static AppBarTheme createTransparent(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  /// Creates an elevated AppBar variant
  static AppBarTheme createElevated(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      elevation: 4,
      scrolledUnderElevation: 8,
      shadowColor: customTheme.palette.common.divider,
    );
  }
}
