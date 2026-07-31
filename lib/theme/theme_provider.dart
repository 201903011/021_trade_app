import 'package:flutter/material.dart';
import 'package:minimals/theme/custom_theme_extension.dart';
import 'package:minimals/theme/palette/index.dart';

extension ThemeContextExtensions on BuildContext {
  /// Get custom theme extension with fallback
  CustomThemeExtension get customTheme {
    final theme = Theme.of(this);
    return theme.extension<CustomThemeExtension>() ?? CustomThemeExtension.fallback(theme.brightness);
  }

  /// Get palette from custom theme extension
  CustomThemeData get palette {
    return customTheme.palette;
  }

  /// Check if current theme is dark
  bool get isThemeDark {
    return Theme.of(this).brightness == Brightness.dark;
  }

  /// Check if current theme is light
  bool get isThemeLight {
    return Theme.of(this).brightness == Brightness.light;
  }
}

/// Responsive breakpoints similar to MUI
