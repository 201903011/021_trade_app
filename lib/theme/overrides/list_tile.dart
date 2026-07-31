import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class ListTileOverrides {
  static ListTileThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      minLeadingWidth: 40,
      minVerticalPadding: 8,
      horizontalTitleGap: 16,
      titleTextStyle: customTheme.typography.subtitle1.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.secondary,
      ),
      leadingAndTrailingTextStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.secondary,
      ),
      iconColor: customTheme.palette.text.secondary,
      textColor: customTheme.palette.text.primary,
      selectedTileColor: customTheme.palette.action.selected,
      selectedColor: customTheme.palette.common.primary.main,
      tileColor: Colors.transparent,
      enableFeedback: true,
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      visualDensity: VisualDensity.standard,
    );
  }

  /// Creates a dense list tile
  static ListTileThemeData createDense(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minVerticalPadding: 4,
      visualDensity: VisualDensity.compact,
      titleTextStyle: customTheme.typography.body1.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.secondary,
      ),
    );
  }

  /// Creates a comfortable list tile
  static ListTileThemeData createComfortable(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      minVerticalPadding: 12,
      visualDensity: VisualDensity.comfortable,
    );
  }

  /// Creates a three-line list tile
  static ListTileThemeData createThreeLine(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      minVerticalPadding: 12,
      titleTextStyle: customTheme.typography.subtitle1.copyWith(
        color: customTheme.palette.text.primary,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.secondary,
        height: 1.4,
      ),
    );
  }

  /// Creates a list tile with custom padding
  static ListTileThemeData createCustomPadding(
    ThemeData baseTheme,
    CustomThemeExtension customTheme, {
    EdgeInsets? contentPadding,
    double? minVerticalPadding,
    double? horizontalTitleGap,
  }) {
    return create(baseTheme, customTheme).copyWith(
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      minVerticalPadding: minVerticalPadding ?? 8,
      horizontalTitleGap: horizontalTitleGap ?? 16,
    );
  }

  /// Creates a list tile with rounded corners
  static ListTileThemeData createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// Creates a list tile with no shape
  static ListTileThemeData createFlat(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: const RoundedRectangleBorder(),
    );
  }

  /// Creates a list tile with border
  static ListTileThemeData createBordered(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
    );
  }

  /// Creates a list tile with custom tile color
  static ListTileThemeData createWithBackground(
    ThemeData baseTheme,
    CustomThemeExtension customTheme, {
    Color? tileColor,
    Color? selectedTileColor,
  }) {
    return create(baseTheme, customTheme).copyWith(
      tileColor: tileColor ?? customTheme.palette.background.neutral,
      selectedTileColor: selectedTileColor ?? customTheme.palette.action.selected,
    );
  }
}
