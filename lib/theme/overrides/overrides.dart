import 'package:flutter/material.dart';
import 'package:minimals/theme/overrides/index.dart';
import '../custom_theme_extension.dart';

/// Theme overrides class that provides Material UI style theme customization
/// This is similar to Material UI's theme.components overrides
class ThemeOverrides {
  /// Apply all theme overrides to the given ThemeData
  static ThemeData applyOverrides(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return baseTheme.copyWith(
      // AppBar overrides
      appBarTheme: AppBarOverrides.create(baseTheme, customTheme),

      // Button overrides
      elevatedButtonTheme: ElevatedButtonOverrides.create(baseTheme, customTheme),
      outlinedButtonTheme: OutlinedButtonOverrides.create(baseTheme, customTheme),
      textButtonTheme: TextButtonOverrides.create(baseTheme, customTheme),

      // Card overrides
      cardTheme: CardOverrides.create(baseTheme, customTheme),

      // Input overrides
      inputDecorationTheme: InputDecorationOverrides.create(baseTheme, customTheme),

      // List tile overrides
      listTileTheme: ListTileOverrides.create(baseTheme, customTheme),

      // Checkbox overrides
      checkboxTheme: CheckboxOverrides.create(baseTheme, customTheme),

      // Radio overrides
      radioTheme: RadioOverrides.create(baseTheme, customTheme),

      // Switch overrides
      switchTheme: SwitchOverrides.create(baseTheme, customTheme),

      // Slider overrides
      sliderTheme: SliderOverrides.create(baseTheme, customTheme),

      // Tab bar overrides
      tabBarTheme: TabBarOverrides.create(baseTheme, customTheme),

      // Dialog overrides
      dialogTheme: DialogOverrides.create(baseTheme, customTheme),

      // Drawer overrides
      drawerTheme: DrawerOverrides.create(baseTheme, customTheme),

      // FloatingActionButton overrides
      floatingActionButtonTheme: FloatingActionButtonOverrides.create(baseTheme, customTheme),

      // IconButton overrides
      iconButtonTheme: IconButtonOverrides.create(baseTheme, customTheme),

      // Chip overrides
      chipTheme: ChipOverrides.create(baseTheme, customTheme),

      // Tooltip overrides
      tooltipTheme: TooltipOverrides.create(baseTheme, customTheme),

      // Navigation bar overrides
      navigationBarTheme: NavigationBarOverrides.create(baseTheme, customTheme),
    );
  }
}
