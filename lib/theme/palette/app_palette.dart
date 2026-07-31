import 'package:flutter/material.dart';
import 'colors.dart';
import 'grey_colors.dart';

/// Application color palette
class AppPalette {
  // Primary color scheme
  static const CustomColor primary = CustomColor(
    lighter: Color(0xFFC8FACD),
    light: Color(0xFF5BE584),
    main: Color(0xFF00AB55),
    dark: Color(0xFF007B55),
    darker: Color(0xFF005249),
    contrastText: Color(0xFFFFFFFF),
  );

  // Secondary color scheme
  static const CustomColor secondary = CustomColor(
    lighter: Color(0xFFD6E4FF),
    light: Color(0xFF84A9FF),
    main: Color(0xFF3366FF),
    dark: Color(0xFF1939B7),
    darker: Color(0xFF091A7A),
    contrastText: Color(0xFFFFFFFF),
  );

  // Info color scheme
  static const CustomColor info = CustomColor(
    lighter: Color(0xFFCAFDF5),
    light: Color(0xFF61F3F3),
    main: Color(0xFF00B8D9),
    dark: Color(0xFF006C9C),
    darker: Color(0xFF003768),
    contrastText: Color(0xFFFFFFFF),
  );

  // Success color scheme
  static const CustomColor success = CustomColor(
    lighter: Color(0xFFD8FBDE),
    light: Color(0xFF86E8AB),
    main: Color(0xFF36B37E),
    dark: Color(0xFF1B806A),
    darker: Color(0xFF0A5554),
    contrastText: Color(0xFFFFFFFF),
  );

  // Warning color scheme
  static const CustomColor warning = CustomColor(
    lighter: Color(0xFFFFF5CC),
    light: Color(0xFFFFD666),
    main: Color(0xFFFFAB00),
    dark: Color(0xFFB76E00),
    darker: Color(0xFF7A4100),
    contrastText: GreyColors.grey800,
  );

  // Error color scheme
  static const CustomColor error = CustomColor(
    lighter: Color(0xFFFFE9D5),
    light: Color(0xFFFFAC82),
    main: Color(0xFFFF5630),
    dark: Color(0xFFB71D18),
    darker: Color(0xFF7A0916),
    contrastText: Color(0xFFFFFFFF),
  );

  // Common colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Helper method to create alpha transparency
  static Color withAlpha(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // Divider color
  static Color get divider => withAlpha(GreyColors.grey500, 0.24);

  // Action colors
  static Color get actionHover => withAlpha(GreyColors.grey500, 0.08);
  static Color get actionSelected => withAlpha(GreyColors.grey500, 0.16);
  static Color get actionDisabled => withAlpha(GreyColors.grey500, 0.8);
  static Color get actionDisabledBackground => withAlpha(GreyColors.grey500, 0.24);
  static Color get actionFocus => withAlpha(GreyColors.grey500, 0.24);
  static const double actionHoverOpacity = 0.08;
  static const double actionDisabledOpacity = 0.48;
}
