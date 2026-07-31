import 'package:flutter/material.dart';
import 'package:minimals/theme/custom_theme_extension.dart';
import 'package:minimals/theme/overrides/index.dart';
import 'typography/typography.dart';
import '../settings/types.dart';
import '../settings/presets.dart';

class AppTheme {
  /// Create a complete light theme
  static ThemeData createLightTheme({
    MaterialColor? primarySwatch,
    ColorPreset? colorPreset,
  }) {
    final customTheme = CustomThemeExtension.create(ThemeMode.light, colorPreset ?? ThemePresets.defaultPreset);
    final palette = customTheme.palette;
    final textTheme = AppTypography.createTextTheme();
    final primaryColor = colorPreset?.main ?? customTheme.palette.common.primary.main;
    final primaryContrastText = colorPreset?.contrastText ?? customTheme.palette.common.primary.contrastText;
    final materialColor = primarySwatch ?? colorPreset?.toMaterialColor() ?? customTheme.palette.common.primary.toMaterialColor();

    final baseTheme = ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: palette.background.defaultColor,
        cardColor: palette.background.paper,
        dividerColor: palette.common.divider,
        primarySwatch: materialColor,
        // Apply custom typography
        textTheme: textTheme.apply(
          bodyColor: palette.text.primary,
          displayColor: palette.text.primary,
        ),

        // Color scheme
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: primaryContrastText,
          secondary: palette.common.secondary.main,
          onSecondary: palette.common.secondary.contrastText,
          error: palette.common.error.main,
          onError: palette.common.error.contrastText,
          background: palette.background.defaultColor,
          onBackground: palette.text.primary,
          surface: palette.background.paper,
          onSurface: palette.text.primary,
        ),
        useMaterial3: true,
        extensions: <ThemeExtension<dynamic>>[
          CustomThemeExtension(
            palette: palette,
            typography: AppTypography.typography,
          ),
        ]);

    return ThemeOverrides.applyOverrides(baseTheme, customTheme);
  }

  /// Create a complete dark theme
  static ThemeData createDarkTheme({
    MaterialColor? primarySwatch,
    ColorPreset? colorPreset,
  }) {
    final customTheme = CustomThemeExtension.create(ThemeMode.dark, colorPreset ?? ThemePresets.defaultPreset);
    final palette = customTheme.palette;
    final textTheme = AppTypography.createTextTheme();
    final primaryColor = colorPreset?.main ?? customTheme.palette.common.primary.main;
    final primaryContrastText = colorPreset?.contrastText ?? customTheme.palette.common.primary.contrastText;
    final materialColor = primarySwatch ?? colorPreset?.toMaterialColor() ?? customTheme.palette.common.primary.toMaterialColor();

    final baseTheme = ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: palette.background.defaultColor,
        cardColor: palette.background.paper,
        dividerColor: palette.common.divider,
        primarySwatch: materialColor,
        // Apply custom typography
        textTheme: textTheme.apply(
          bodyColor: palette.text.primary,
          displayColor: palette.text.primary,
        ),

        // Color scheme
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          onPrimary: primaryContrastText,
          secondary: palette.common.secondary.main,
          onSecondary: palette.common.secondary.contrastText,
          error: palette.common.error.main,
          onError: palette.common.error.contrastText,
          background: palette.background.defaultColor,
          onBackground: palette.text.primary,
          surface: palette.background.paper,
          onSurface: palette.text.primary,
        ),
        useMaterial3: true,
        extensions: [
          CustomThemeExtension(palette: palette, typography: AppTypography.typography),
        ]);

    return ThemeOverrides.applyOverrides(baseTheme, customTheme);
  }

  /// Create a theme with the specified color preset and brightness
  static ThemeData createTheme({
    required bool isDark,
    ColorPreset? colorPreset,
    MaterialColor? primarySwatch,
  }) {
    if (isDark) {
      return createDarkTheme(
        primarySwatch: primarySwatch,
        colorPreset: colorPreset,
      );
    } else {
      return createLightTheme(
        primarySwatch: primarySwatch,
        colorPreset: colorPreset,
      );
    }
  }
}
