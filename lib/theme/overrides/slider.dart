import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class SliderOverrides {
  static SliderThemeData create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return SliderThemeData(
      activeTrackColor: customTheme.palette.common.primary.main,
      inactiveTrackColor: customTheme.palette.common.divider,
      thumbColor: customTheme.palette.common.primary.main,
      // ignore: deprecated_member_use
      overlayColor: customTheme.palette.common.primary.main.withOpacity(0.1),
      valueIndicatorColor: customTheme.palette.common.primary.main,
      valueIndicatorTextStyle: customTheme.typography.caption.copyWith(
        color: customTheme.palette.common.primary.contrastText,
      ),
    );
  }
}
