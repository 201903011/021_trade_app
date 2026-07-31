import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class IconButtonOverrides {
  static IconButtonThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: customTheme.palette.text.secondary,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: customTheme.palette.action.disabled,
        disabledBackgroundColor: Colors.transparent,
        hoverColor: customTheme.palette.action.hover,
        focusColor: customTheme.palette.action.focus,
        highlightColor: customTheme.palette.action.selected,
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(48, 48),
        fixedSize: null,
        maximumSize: Size.infinite,
        iconSize: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enableFeedback: true,
        enabledMouseCursor: SystemMouseCursors.basic,
        disabledMouseCursor: SystemMouseCursors.click,
      ),
    );
  }
}
