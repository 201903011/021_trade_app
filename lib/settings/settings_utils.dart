import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';
import 'types.dart';

/// Utility functions for working with settings
class SettingsUtils {
  /// Get the current settings controller instance
  static SettingsController get controller => Get.find<SettingsController>();

  /// Quick access to current color preset
  static ColorPreset get currentColors => controller.currentColorPreset;

  /// Quick access to theme mode
  static ThemeMode get themeMode => controller.themeMode.value;

  /// Quick access to dark mode status
  static bool get isDarkMode => controller.isDarkMode;

  /// Quick access to compact mode status
  static bool get isCompactMode => controller.compact.value;

  /// Quick access to contrast mode status
  static bool get isContrastMode => controller.contrast.value;

  /// Get padding based on compact mode
  static EdgeInsets getContentPadding({
    double normal = 16.0,
    double compact = 8.0,
  }) {
    return EdgeInsets.all(isCompactMode ? compact : normal);
  }

  /// Get spacing based on compact mode
  static double getSpacing({
    double normal = 16.0,
    double compact = 8.0,
  }) {
    return isCompactMode ? compact : normal;
  }

  /// Get elevation based on compact mode
  static double getElevation({
    double normal = 4.0,
    double compact = 2.0,
  }) {
    return isCompactMode ? compact : normal;
  }

  /// Get border radius based on compact mode
  static BorderRadius getBorderRadius({
    double normal = 12.0,
    double compact = 8.0,
  }) {
    return BorderRadius.circular(isCompactMode ? compact : normal);
  }

  /// Get text style with current theme colors
  static TextStyle getTextStyle(
    BuildContext context, {
    bool usePrimaryColor = false,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: usePrimaryColor ? currentColors.main : null,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  /// Get appropriate icon color based on background
  static Color getIconColor(BuildContext context, {Color? backgroundColor}) {
    if (backgroundColor != null) {
      // Calculate if background is light or dark
      final luminance = backgroundColor.computeLuminance();
      return luminance > 0.5 ? Colors.black87 : Colors.white;
    }
    return Theme.of(context).iconTheme.color ?? Colors.black87;
  }

  /// Create a themed container
  static Container createThemedContainer({
    required Widget child,
    Color? backgroundColor,
    bool useCurrentPreset = true,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double? elevation,
  }) {
    return Container(
      padding: padding ?? getContentPadding(),
      decoration: BoxDecoration(
        color: backgroundColor ?? (useCurrentPreset ? currentColors.lighter : null),
        borderRadius: borderRadius ?? getBorderRadius(),
        boxShadow: elevation != null
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }

  /// Show a themed snackbar
  static void showThemedSnackbar({
    required String message,
    String? title,
    Duration? duration,
    bool isError = false,
  }) {
    Get.snackbar(
      title ?? (isError ? 'Error' : 'Info'),
      message,
      backgroundColor: isError ? Colors.red.withOpacity(0.8) : currentColors.main.withOpacity(0.8),
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: getContentPadding(),
      borderRadius: getBorderRadius().topLeft.x,
    );
  }

  /// Get adaptive color based on current theme
  static Color getAdaptiveColor({
    required Color lightColor,
    required Color darkColor,
  }) {
    return isDarkMode ? darkColor : lightColor;
  }

  /// Get surface color with opacity based on current preset
  static Color getSurfaceColor({double opacity = 0.1}) {
    return currentColors.main.withOpacity(opacity);
  }

  /// Check if two colors have sufficient contrast
  static bool hasGoodContrast(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();

    final lightest = luminance1 > luminance2 ? luminance1 : luminance2;
    final darkest = luminance1 < luminance2 ? luminance1 : luminance2;

    final contrast = (lightest + 0.05) / (darkest + 0.05);
    return contrast >= 4.5; // WCAG AA standard
  }

  /// Get contrasting text color for a background
  static Color getContrastingTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  /// Apply settings-aware styling to a widget
  static Widget applySettingsStyle({
    required Widget child,
    bool respectCompactMode = true,
    bool respectContrastMode = true,
    Color? backgroundColor,
  }) {
    Widget styledChild = child;

    if (respectCompactMode && isCompactMode) {
      styledChild = Padding(
        padding: getContentPadding(),
        child: styledChild,
      );
    }

    if (respectContrastMode && isContrastMode && backgroundColor != null) {
      final contrastColor = getContrastingTextColor(backgroundColor);
      styledChild = DefaultTextStyle(
        style: TextStyle(color: contrastColor),
        child: styledChild,
      );
    }

    return styledChild;
  }
}
