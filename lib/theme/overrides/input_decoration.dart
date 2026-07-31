import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';

class InputDecorationOverrides {
  static InputDecorationTheme create(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: customTheme.palette.background.neutral,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      // Border styles
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.common.primary.main,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.common.error.main,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.common.error.main,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.action.disabled,
          width: 1,
        ),
      ),

      // Text styles
      labelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.secondary,
      ),
      floatingLabelStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.common.primary.main,
      ),
      hintStyle: customTheme.typography.body2.copyWith(
        color: customTheme.palette.text.disabled,
      ),
      errorStyle: customTheme.typography.caption.copyWith(
        color: customTheme.palette.common.error.main,
      ),
      helperStyle: customTheme.typography.caption.copyWith(
        color: customTheme.palette.text.secondary,
      ),

      // Icon styles
      prefixIconColor: customTheme.palette.text.secondary,
      suffixIconColor: customTheme.palette.text.secondary,
      iconColor: customTheme.palette.text.secondary,

      // Constraints
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
    );
  }

  /// Creates outlined input decoration
  static InputDecorationTheme createOutlined(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      filled: false,
      fillColor: Colors.transparent,
    );
  }

  /// Creates filled input decoration
  static InputDecorationTheme createFilled(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      filled: true,
      fillColor: customTheme.palette.background.neutral,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: customTheme.palette.common.primary.main,
          width: 2,
        ),
      ),
    );
  }

  /// Creates underlined input decoration
  static InputDecorationTheme createUnderlined(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      filled: false,
      fillColor: Colors.transparent,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.primary.main,
          width: 2,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.error.main,
          width: 1,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.error.main,
          width: 2,
        ),
      ),
    );
  }

  /// Creates dense input decoration
  static InputDecorationTheme createDense(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      constraints: const BoxConstraints(
        minHeight: 48,
      ),
    );
  }

  /// Creates rounded input decoration
  static InputDecorationTheme createRounded(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: customTheme.palette.common.primary.main,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: customTheme.palette.common.error.main,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: customTheme.palette.common.error.main,
          width: 2,
        ),
      ),
    );
  }

  /// Creates borderless input decoration
  static InputDecorationTheme createBorderless(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
  }

  /// Creates standard Material Design input decoration
  static InputDecorationTheme createStandard(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return create(baseTheme, customTheme).copyWith(
      filled: false,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      border: const UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.divider,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: customTheme.palette.common.primary.main,
          width: 2,
        ),
      ),
    );
  }
}
