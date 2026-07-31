import 'package:flutter/material.dart';
import 'package:minimals/theme/custom_theme_extension.dart';
import 'package:minimals/theme/palette/index.dart';
import 'package:minimals/theme/theme_provider.dart';
import 'package:minimals/theme/typography/custom_text_theme_data.dart';

/// Use this in components instead of directly accessing AppPalette
class UseTheme {
  final BuildContext context;

  UseTheme(this.context);

  /// Get theme data
  ThemeData get theme => Theme.of(context);

  /// Get custom theme extension

  /// Get custom theme extension
  CustomThemeExtension get customTheme => context.customTheme;

  /// Get palette
  CustomThemeData get palette => context.customTheme.palette;

  CustomTypographyData get typography => context.customTheme.typography;

  /// Get primary color from context instead of AppPalette
  Color get primary => customTheme.palette.common.primary.main;

  /// Get secondary color from context
  Color get secondary => customTheme.palette.common.secondary.main;

  /// Get error color from context
  Color get error => customTheme.palette.common.error.main;

  /// Get success color from context
  Color get success => customTheme.palette.common.success.main;

  /// Get warning color from context
  Color get warning => customTheme.palette.common.warning.main;

  /// Get info color from context
  Color get info => customTheme.palette.common.info.main;

  /// Check if dark mode
  bool get isDark => context.isThemeDark;

  /// Check if light mode
  bool get isLight => context.isThemeLight;
}

/// Factory function to get theme hook
UseTheme useTheme(BuildContext context) => UseTheme(context);
