import 'package:flutter/material.dart';
import 'colors.dart';

/// Custom text theme data
class CustomTextTheme {
  final Color primary;
  final Color secondary;
  final Color disabled;

  const CustomTextTheme({
    required this.primary,
    required this.secondary,
    required this.disabled,
  });
}

/// Custom background theme data
class CustomBackgroundTheme {
  final Color paper;
  final Color defaultColor;
  final Color neutral;

  const CustomBackgroundTheme({
    required this.paper,
    required this.defaultColor,
    required this.neutral,
  });
}

/// Custom action theme data
class CustomActionTheme {
  final Color hover;
  final Color selected;
  final Color disabled;
  final Color disabledBackground;
  final Color focus;
  final Color active;
  final double hoverOpacity;
  final double disabledOpacity;

  const CustomActionTheme({
    required this.hover,
    required this.selected,
    required this.disabled,
    required this.disabledBackground,
    required this.focus,
    required this.active,
    required this.hoverOpacity,
    required this.disabledOpacity,
  });
}

/// Common colors data
class CommonColors {
  final Color black;
  final Color white;

  const CommonColors({
    required this.black,
    required this.white,
  });

  /// Default common colors
  static const CommonColors defaultColors = CommonColors(
    black: Color(0xFF000000),
    white: Color(0xFFFFFFFF),
  );
}

/// Common theme data
class CommonTheme {
  final CommonColors common;
  final CustomColor primary;
  final CustomColor secondary;
  final CustomColor info;
  final CustomColor success;
  final CustomColor warning;
  final CustomColor error;
  final Map<int, Color> grey;
  final Color divider;
  final CustomActionTheme action;

  const CommonTheme({
    required this.common,
    required this.primary,
    required this.secondary,
    required this.info,
    required this.success,
    required this.warning,
    required this.error,
    required this.grey,
    required this.divider,
    required this.action,
  });
}

/// Custom theme data class (similar to TypeScript structure)
class CustomThemeData {
  final CommonTheme common;
  final String mode;
  final CustomTextTheme text;
  final CustomBackgroundTheme background;
  final CustomActionTheme action;

  const CustomThemeData({
    required this.common,
    required this.mode,
    required this.text,
    required this.background,
    required this.action,
  });
}
