import 'package:flutter/material.dart';

/// Color schema types for the application
enum ColorSchema { primary, secondary, info, success, warning, error }

/// Custom color extension for additional color properties
class CustomColor {
  final Color lighter;
  final Color light;
  final Color main;
  final Color dark;
  final Color darker;
  final Color contrastText;

  const CustomColor({
    required this.lighter,
    required this.light,
    required this.main,
    required this.dark,
    required this.darker,
    required this.contrastText,
  });

  // create lerp(covariant ThemeExtension<CustomThemeExtension>? other, double t) function

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
}
