import 'package:flutter/material.dart';
import 'package:minimals/settings/types.dart';
import 'app_palette.dart';
import 'grey_colors.dart';
import 'theme_data.dart';

/// COMMON factory similar to TypeScript structure
class AppCommon {
  static CommonTheme getCommon(ColorPreset colorPreset) {
    return CommonTheme(
      common: CommonColors.defaultColors,
      primary: colorPreset.toCustomColor(),
      secondary: AppPalette.secondary,
      info: AppPalette.info,
      success: AppPalette.success,
      warning: AppPalette.warning,
      error: AppPalette.error,
      grey: GreyColors.values,
      divider: const Color(0x3D919EAB), // alpha(GREY[500], 0.24)
      action: const CustomActionTheme(
        hover: const Color(0x14919EAB), // alpha(GREY[500], 0.08)
        selected: Color(0x29919EAB), // alpha(GREY[500], 0.16)
        disabled: Color(0xCC919EAB), // alpha(GREY[500], 0.8)
        disabledBackground: Color(0x3D919EAB), // alpha(GREY[500], 0.24)
        focus: Color(0x3D919EAB), // alpha(GREY[500], 0.24)
        active: GreyColors.grey600, // Will be overridden in light/dark themes
        hoverOpacity: 0.08,
        disabledOpacity: 0.48,
      ),
    );
  }
}

/// Palette factory function
class PaletteFactory {
  static CustomThemeData createPalette(ThemeMode themeMode, ColorPreset colorPreset) {
    final isLight = themeMode == ThemeMode.light;
    final common = AppCommon.getCommon(colorPreset);

    if (isLight) {
      return CustomThemeData(
        common: common,
        mode: 'light',
        text: const CustomTextTheme(
          primary: GreyColors.grey800,
          secondary: GreyColors.grey600,
          disabled: GreyColors.grey500,
        ),
        background: const CustomBackgroundTheme(
          paper: Color(0xFFFFFFFF),
          defaultColor: Color(0xFFFFFFFF),
          neutral: GreyColors.grey200,
        ),
        action: CustomActionTheme(
          hover: common.action.hover,
          selected: common.action.selected,
          disabled: common.action.disabled,
          disabledBackground: common.action.disabledBackground,
          focus: common.action.focus,
          active: GreyColors.grey600,
          hoverOpacity: common.action.hoverOpacity,
          disabledOpacity: common.action.disabledOpacity,
        ),
      );
    } else {
      return CustomThemeData(
        common: AppCommon.getCommon(colorPreset),
        mode: 'dark',
        text: const CustomTextTheme(
          primary: Color(0xFFFFFFFF),
          secondary: GreyColors.grey500,
          disabled: GreyColors.grey600,
        ),
        background: CustomBackgroundTheme(
          paper: GreyColors.grey800,
          defaultColor: GreyColors.grey900,
          neutral: AppPalette.withAlpha(GreyColors.grey500, 0.16),
        ),
        action: CustomActionTheme(
          hover: common.action.hover,
          selected: common.action.selected,
          disabled: common.action.disabled,
          disabledBackground: common.action.disabledBackground,
          focus: common.action.focus,
          active: GreyColors.grey500,
          hoverOpacity: common.action.hoverOpacity,
          disabledOpacity: common.action.disabledOpacity,
        ),
      );
    }
  }

  /// Helper method to get theme data similar to TypeScript palette function
  static CustomThemeData light(ColorPreset colorPreset) => createPalette(ThemeMode.light, colorPreset);
  static CustomThemeData dark(ColorPreset colorPreset) => createPalette(ThemeMode.dark, colorPreset);
}
