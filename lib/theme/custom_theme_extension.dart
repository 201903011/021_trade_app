import 'package:flutter/material.dart';
import 'package:minimals/settings/presets.dart';
import 'package:minimals/settings/settings.dart';
import 'package:minimals/theme/palette/index.dart';
import 'package:minimals/theme/typography/custom_text_theme_data.dart';
import 'package:minimals/theme/typography/typography.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final CustomThemeData palette;
  final CustomTypographyData typography;

  const CustomThemeExtension({
    required this.palette,
    required this.typography,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    CustomThemeData? palette,
    CustomTypographyData? typography,
  }) {
    return CustomThemeExtension(
      palette: palette ?? this.palette,
      typography: typography ?? this.typography,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(covariant ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }

    return CustomThemeExtension(
      palette: _lerpCustomThemeData(palette, other.palette, t),
      typography: CustomTypographyData.lerp(typography, other.typography, t),
    );
  }

  /// Helper method to interpolate between CustomThemeData objects
  CustomThemeData _lerpCustomThemeData(CustomThemeData a, CustomThemeData b, double t) {
    return CustomThemeData(
      common: t < 0.5 ? a.common : b.common, // Use discrete switch for common data
      mode: t < 0.5 ? a.mode : b.mode,
      text: _lerpTextTheme(a.text, b.text, t),
      background: _lerpBackgroundTheme(a.background, b.background, t),
      action: _lerpActionTheme(a.action, b.action, t),
    );
  }

  /// Helper method to interpolate between CustomTextTheme objects
  CustomTextTheme _lerpTextTheme(CustomTextTheme a, CustomTextTheme b, double t) {
    return CustomTextTheme(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
    );
  }

  /// Helper method to interpolate between CustomBackgroundTheme objects
  CustomBackgroundTheme _lerpBackgroundTheme(CustomBackgroundTheme a, CustomBackgroundTheme b, double t) {
    return CustomBackgroundTheme(
      paper: Color.lerp(a.paper, b.paper, t)!,
      defaultColor: Color.lerp(a.defaultColor, b.defaultColor, t)!,
      neutral: Color.lerp(a.neutral, b.neutral, t)!,
    );
  }

  /// Helper method to interpolate between CustomActionTheme objects
  CustomActionTheme _lerpActionTheme(CustomActionTheme a, CustomActionTheme b, double t) {
    return CustomActionTheme(
      hover: Color.lerp(a.hover, b.hover, t)!,
      selected: Color.lerp(a.selected, b.selected, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      disabledBackground: Color.lerp(a.disabledBackground, b.disabledBackground, t)!,
      focus: Color.lerp(a.focus, b.focus, t)!,
      active: Color.lerp(a.active, b.active, t)!,
      hoverOpacity: t < 0.5 ? a.hoverOpacity : b.hoverOpacity,
      disabledOpacity: t < 0.5 ? a.disabledOpacity : b.disabledOpacity,
    );
  }

  /// Factory method to create CustomThemeExtension based on theme mode
  static CustomThemeExtension create(ThemeMode themeMode, ColorPreset colorPreset) {
    final palette = PaletteFactory.createPalette(themeMode, colorPreset);

    return CustomThemeExtension(palette: palette, typography: AppTypography.typography);
  }

  /// Get light theme extension
  static CustomThemeExtension light(ColorPreset colorPreset) => create(ThemeMode.light, colorPreset);

  /// Get dark theme extension
  static CustomThemeExtension dark(ColorPreset colorPreset) => create(ThemeMode.dark, colorPreset);

  /// Fallback method for when no theme extension is available
  /// Uses the provided brightness to determine the appropriate theme
  static CustomThemeExtension fallback(Brightness brightness) {
    return create(brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light, ThemePresets.defaultPreset);
  }
}

final CustomThemeExtension defaultLightCustomThemeExtension = CustomThemeExtension(
  palette: PaletteFactory.createPalette(ThemeMode.light, ThemePresets.defaultPreset),
  typography: AppTypography.typography,
);

final CustomThemeExtension defaultDarkCustomThemeExtension = CustomThemeExtension(
  palette: PaletteFactory.createPalette(ThemeMode.dark, ThemePresets.defaultPreset),
  typography: AppTypography.typography,
);

CustomThemeExtension getDefaultCustomThemeExtension(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return defaultLightCustomThemeExtension;
    case ThemeMode.dark:
      return defaultDarkCustomThemeExtension;
    case ThemeMode.system:
      return defaultLightCustomThemeExtension;
  }
}
