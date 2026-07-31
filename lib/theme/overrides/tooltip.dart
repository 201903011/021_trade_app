// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class TooltipOverrides {
  static TooltipThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: customTheme.palette.text.primary.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: customTheme.typography.caption.copyWith(
        color: customTheme.palette.background.paper,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.all(8),
      verticalOffset: 8,
      preferBelow: true,
      excludeFromSemantics: false,
      enableFeedback: true,
      triggerMode: TooltipTriggerMode.longPress,
      showDuration: const Duration(milliseconds: 1500),
      waitDuration: const Duration(milliseconds: 0),
    );
  }
}
