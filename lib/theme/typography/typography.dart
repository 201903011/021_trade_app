import 'package:flutter/material.dart';
import 'package:minimals/theme/typography/custom_text_theme_data.dart';

class AppTypography {
  // Font size conversion utilities
  static double remToPx(String value) {
    return (double.parse(value.replaceAll('rem', '')) * 16).roundToDouble();
  }

  static double pxToRem(double value) {
    return value / 16;
  }

  static Map<String, double> responsiveFontSizes({
    required double sm,
    required double md,
    required double lg,
  }) {
    return {
      'sm': sm, // For screen width >= 600px
      'md': md, // For screen width >= 900px
      'lg': lg, // For screen width >= 1200px
    };
  }

  // Get responsive font size based on screen width
  static double getResponsiveFontSize(
    BuildContext context, {
    required double sm,
    required double md,
    required double lg,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1200) {
      return lg;
    } else if (screenWidth >= 900) {
      return md;
    } else if (screenWidth >= 600) {
      return sm;
    } else {
      return sm * 0.9; // Smaller than sm for very small screens
    }
  }

  // Primary font family (equivalent to Public Sans)
  // Using system fonts as fallback since google_fonts package is not available
  static const TextStyle primaryFont = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
  );

  // Secondary font family (equivalent to Barlow)
  static const TextStyle secondaryFont = TextStyle(
    fontFamily: 'Barlow',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
  );

  // Font weight constants
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  /// Create the complete TextTheme for the application
  static TextTheme createTextTheme({BuildContext? context}) {
    // Base font family
    const baseTextStyle = primaryFont;

    return TextTheme(
      // Display styles (equivalent to h1, h2, h3)
      displayLarge: baseTextStyle.copyWith(
        fontWeight: fontWeightExtraBold,
        fontSize: context != null ? getResponsiveFontSize(context, sm: 52, md: 58, lg: 64) : 40,
        height: 80 / 64, // lineHeight equivalent
      ),
      displayMedium: baseTextStyle.copyWith(
        fontWeight: fontWeightExtraBold,
        fontSize: context != null ? getResponsiveFontSize(context, sm: 40, md: 44, lg: 48) : 32,
        height: 64 / 48,
      ),
      displaySmall: baseTextStyle.copyWith(
        fontWeight: fontWeightBold,
        fontSize: context != null ? getResponsiveFontSize(context, sm: 26, md: 30, lg: 32) : 24,
        height: 1.5,
      ),

      // Headline styles (equivalent to h4, h5, h6)
      headlineMedium: baseTextStyle.copyWith(
        fontWeight: fontWeightBold,
        fontSize: context != null ? getResponsiveFontSize(context, sm: 20, md: 24, lg: 24) : 20,
        height: 1.5,
      ),
      headlineSmall: baseTextStyle.copyWith(
        fontWeight: fontWeightBold,
        fontSize: context != null ? getResponsiveFontSize(context, sm: 19, md: 20, lg: 20) : 18,
        height: 1.5,
      ),

      // Title styles (equivalent to subtitle1, subtitle2)
      titleLarge: baseTextStyle.copyWith(
        fontWeight: fontWeightBold,
        fontSize: context != null ? getResponsiveFontSize(context, sm: 18, md: 18, lg: 18) : 17,
        height: 28 / 18,
      ),
      titleMedium: baseTextStyle.copyWith(
        fontWeight: fontWeightMedium,
        fontSize: 16,
        height: 1.5,
      ),
      titleSmall: baseTextStyle.copyWith(
        fontWeight: fontWeightMedium,
        fontSize: 14,
        height: 22 / 14,
      ),

      // Body styles
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 14,
        height: 22 / 14,
      ),
      bodySmall: baseTextStyle.copyWith(
        fontSize: 12,
        height: 1.5,
      ),

      // Label styles (equivalent to button, overline, caption)
      labelLarge: baseTextStyle.copyWith(
        fontWeight: fontWeightBold,
        fontSize: 14,
        height: 24 / 14,
      ),
      labelMedium: baseTextStyle.copyWith(
        fontWeight: fontWeightBold,
        fontSize: 12,
        height: 1.5,
      ),
      labelSmall: baseTextStyle.copyWith(
        fontSize: 12,
        height: 1.5,
      ),
    );
  }

  static const CustomTypographyData typography = CustomTypographyData(
    fontFamily: 'Public Sans',
    fontWeightRegular: AppTypography.fontWeightRegular,
    fontWeightMedium: AppTypography.fontWeightMedium,
    fontWeightBold: AppTypography.fontWeightBold,
    h1: CustomTextStyles.h1,
    h2: CustomTextStyles.h2,
    h3: CustomTextStyles.h3,
    h4: CustomTextStyles.h4,
    h5: CustomTextStyles.h5,
    h6: CustomTextStyles.h6,
    subtitle1: CustomTextStyles.subtitle1,
    subtitle2: CustomTextStyles.subtitle2,
    body1: CustomTextStyles.body1,
    body2: CustomTextStyles.body2,
    caption: CustomTextStyles.caption,
    overline: CustomTextStyles.overline,
    button: CustomTextStyles.button,
  );

  /// Create a custom text theme with responsive sizes
}

/// Custom text styles that match the original JS configuration
class CustomTextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightExtraBold,
    fontSize: 40,
    height: 80 / 64,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightExtraBold,
    fontSize: 32,
    height: 64 / 48,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightBold,
    fontSize: 24,
    height: 1.5,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightBold,
    fontSize: 20,
    height: 1.5,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightBold,
    fontSize: 18,
    height: 1.5,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightBold,
    fontSize: 17,
    height: 28 / 18,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightMedium,
    fontSize: 16,
    height: 1.5,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightMedium,
    fontSize: 14,
    height: 22 / 14,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontSize: 16,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontSize: 14,
    height: 22 / 14,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontSize: 12,
    height: 1.5,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightBold,
    fontSize: 12,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Public Sans',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: AppTypography.fontWeightBold,
    fontSize: 14,
    height: 24 / 14,
  );

  // Secondary font style (Barlow equivalent)
  static const TextStyle secondaryBold = TextStyle(
    fontFamily: 'Barlow',
    fontFamilyFallback: ['Helvetica', 'Arial', 'sans-serif'],
    fontWeight: FontWeight.w900,
  );

  // create lerp method
}

/// Extension on BuildContext for easy typography access
extension TypographyContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get responsive text style
  TextStyle responsiveTextStyle({
    required double sm,
    required double md,
    required double lg,
    TextStyle? baseStyle,
  }) {
    final fontSize = AppTypography.getResponsiveFontSize(
      this,
      sm: sm,
      md: md,
      lg: lg,
    );

    return (baseStyle ?? AppTypography.primaryFont).copyWith(fontSize: fontSize);
  }
}
