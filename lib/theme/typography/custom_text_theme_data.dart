import 'package:flutter/material.dart';

/// Custom typography data class
class CustomTypographyData {
  final String fontFamily;
  final FontWeight fontWeightRegular;
  final FontWeight fontWeightMedium;
  final FontWeight fontWeightBold;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle subtitle1;
  final TextStyle subtitle2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption;
  final TextStyle overline;
  final TextStyle button;

  const CustomTypographyData({
    required this.fontFamily,
    required this.fontWeightRegular,
    required this.fontWeightMedium,
    required this.fontWeightBold,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.subtitle1,
    required this.subtitle2,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.overline,
    required this.button,
  });

  /// Utility function to convert px to rem equivalent

  /// Default typography instance
  /// Convert to Flutter TextTheme
  TextTheme toTextTheme({Color? color, BuildContext? context}) {
    return TextTheme(
      displayLarge: h1,
      displayMedium: h2,
      displaySmall: h3,
      headlineLarge: h4,
      headlineMedium: h5,
      headlineSmall: h6,
      titleLarge: subtitle1,
      titleMedium: subtitle2,
      bodyLarge: body1,
      bodyMedium: body2,
      bodySmall: caption,
      labelLarge: button,
      labelMedium: overline,
    );
  }

  // Create lerp Method
  static CustomTypographyData lerp(CustomTypographyData a, CustomTypographyData b, double t) {
    return CustomTypographyData(
      fontFamily: t < 0.5 ? a.fontFamily : b.fontFamily,
      fontWeightRegular: FontWeight.lerp(a.fontWeightRegular, b.fontWeightRegular, t)!,
      fontWeightMedium: FontWeight.lerp(a.fontWeightMedium, b.fontWeightMedium, t)!,
      fontWeightBold: FontWeight.lerp(a.fontWeightBold, b.fontWeightBold, t)!,
      h1: TextStyle.lerp(a.h1, b.h1, t)!,
      h2: TextStyle.lerp(a.h2, b.h2, t)!,
      h3: TextStyle.lerp(a.h3, b.h3, t)!,
      h4: TextStyle.lerp(a.h4, b.h4, t)!,
      h5: TextStyle.lerp(a.h5, b.h5, t)!,
      h6: TextStyle.lerp(a.h6, b.h6, t)!,
      subtitle1: TextStyle.lerp(a.subtitle1, b.subtitle1, t)!,
      subtitle2: TextStyle.lerp(a.subtitle2, b.subtitle2, t)!,
      body1: TextStyle.lerp(a.body1, b.body1, t)!,
      body2: TextStyle.lerp(a.body2, b.body2, t)!,
      caption: TextStyle.lerp(a.caption, b.caption, t)!,
      overline: TextStyle.lerp(a.overline, b.overline, t)!,
      button: TextStyle.lerp(a.button, b.button, t)!,
    );
  }
}
