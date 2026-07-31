import 'package:flutter/material.dart';
import 'package:minimals/theme/palette/index.dart';

/// Theme color presets enumeration
enum ThemeColorPresetsValue {
  defaultTheme,
  cyan,
  purple,
  blue,
  orange,
  red,
}

/// Theme layout enumeration
enum ThemeLayout {
  vertical,
  horizontal,
  mini,
}

/// Theme stretch enumeration
enum ThemeStretch {
  enabled,
  disabled,
}

/// Color preset model
class ColorPreset {
  final String name;
  final Color lighter;
  final Color light;
  final Color main;
  final Color dark;
  final Color darker;
  final Color contrastText;

  const ColorPreset({
    required this.name,
    required this.lighter,
    required this.light,
    required this.main,
    required this.dark,
    required this.darker,
    required this.contrastText,
  });

  /// Convert to ColorScheme for Material 3
  ColorScheme toColorScheme({required bool isDark}) {
    return ColorScheme.fromSeed(
      seedColor: main,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: main,
      onPrimary: contrastText,
      secondary: light,
      onSecondary: contrastText,
      tertiary: dark,
      onTertiary: contrastText,
      surface: isDark ? darker : lighter,
      onSurface: isDark ? lighter : darker,
    );
  }

  /// Create a MaterialColor from the preset
  MaterialColor toMaterialColor() {
    return MaterialColor(
      main.value,
      <int, Color>{
        50: lighter,
        100: light,
        200: light,
        300: light,
        400: main,
        500: main,
        600: dark,
        700: dark,
        800: darker,
        900: darker,
      },
    );
  }

  /// Convert to CustomColor for compatibility
  CustomColor toCustomColor() {
    return CustomColor(
      lighter: lighter,
      light: light,
      main: main,
      dark: dark,
      darker: darker,
      contrastText: contrastText,
    );
  }
}

/// Preset option for UI display
class PresetOption {
  final String name;
  final Color value;

  const PresetOption({
    required this.name,
    required this.value,
  });
}
