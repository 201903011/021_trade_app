import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class CardOverrides {
  static CardTheme create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return CardTheme(
      color: customTheme.palette.background.paper,
      shadowColor: customTheme.palette.common.divider.withOpacity(0.2),
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: customTheme.palette.common.divider.withOpacity(0.1),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
    );
  }

  /// Creates a flat card without shadow
  static CardTheme createFlat(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
    );
  }

  /// Creates an elevated card with more shadow
  static CardTheme createElevated(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      elevation: 4,
      shadowColor: customTheme.palette.common.divider.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide.none,
      ),
    );
  }

  /// Creates a card with subtle background
  static CardTheme createSubtle(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      color: customTheme.palette.background.neutral,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide.none,
      ),
    );
  }

  /// Creates an outlined card
  static CardTheme createOutlined(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
    );
  }

  /// Creates a rounded card
  static CardTheme createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: customTheme.palette.common.divider.withOpacity(0.1),
          width: 1,
        ),
      ),
    );
  }

  /// Creates a square card
  static CardTheme createSquare(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
          color: customTheme.palette.common.divider.withOpacity(0.1),
          width: 1,
        ),
      ),
    );
  }

  /// Creates a card with no border radius
  static CardTheme createSharp(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: customTheme.palette.common.divider.withOpacity(0.1),
          width: 1,
        ),
      ),
    );
  }

  /// Creates a card with primary color accent
  static CardTheme createPrimaryAccent(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: customTheme.palette.common.primary.main.withOpacity(0.2),
          width: 1,
        ),
      ),
    );
  }

  /// Creates a card with error color accent
  static CardTheme createErrorAccent(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: customTheme.palette.common.error.main.withOpacity(0.2),
          width: 1,
        ),
      ),
    );
  }

  /// Creates a card with warning color accent
  static CardTheme createWarningAccent(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: (customTheme.palette.common.warning.main).withOpacity(0.2),
          width: 1,
        ),
      ),
    );
  }

  /// Creates a card with success color accent
  static CardTheme createSuccessAccent(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: (customTheme.palette.common.success.main).withOpacity(0.2),
          width: 1,
        ),
      ),
    );
  }
}
