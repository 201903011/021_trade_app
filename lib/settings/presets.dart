import 'package:flutter/material.dart';
import 'types.dart';

/// Theme presets configuration
class ThemePresets {
  /// Available color presets
  static const List<ColorPreset> presets = [
    // DEFAULT
    ColorPreset(
      name: 'default',
      lighter: Color(0xFFE8F5E8),
      light: Color(0xFF81C784),
      main: Color(0xFF4CAF50),
      dark: Color(0xFF388E3C),
      darker: Color(0xFF1B5E20),
      contrastText: Colors.white,
    ),
    // CYAN
    ColorPreset(
      name: 'cyan',
      lighter: Color(0xFFCCF4FE),
      light: Color(0xFF68CDF9),
      main: Color(0xFF078DEE),
      dark: Color(0xFF0351AB),
      darker: Color(0xFF012972),
      contrastText: Colors.white,
    ),
    // PURPLE
    ColorPreset(
      name: 'purple',
      lighter: Color(0xFFEBD6FD),
      light: Color(0xFFB985F4),
      main: Color(0xFF7635DC),
      dark: Color(0xFF431A9E),
      darker: Color(0xFF200A69),
      contrastText: Colors.white,
    ),
    // BLUE
    ColorPreset(
      name: 'blue',
      lighter: Color(0xFFD1E9FC),
      light: Color(0xFF76B0F1),
      main: Color(0xFF2065D1),
      dark: Color(0xFF103996),
      darker: Color(0xFF061B64),
      contrastText: Colors.white,
    ),
    // ORANGE
    ColorPreset(
      name: 'orange',
      lighter: Color(0xFFFEF4D4),
      light: Color(0xFFFED680),
      main: Color(0xFFFDA92D),
      dark: Color(0xFFB66816),
      darker: Color(0xFF793908),
      contrastText: Color(0xFF424242),
    ),
    // RED
    ColorPreset(
      name: 'red',
      lighter: Color(0xFFFFE3D5),
      light: Color(0xFFFFC1AC),
      main: Color(0xFFFF3030),
      dark: Color(0xFFB71833),
      darker: Color(0xFF7A0930),
      contrastText: Colors.white,
    ),
  ];

  /// Get preset by value
  static ColorPreset getPreset(ThemeColorPresetsValue key) {
    switch (key) {
      case ThemeColorPresetsValue.defaultTheme:
        return presets[0];
      case ThemeColorPresetsValue.cyan:
        return presets[1];
      case ThemeColorPresetsValue.purple:
        return presets[2];
      case ThemeColorPresetsValue.blue:
        return presets[3];
      case ThemeColorPresetsValue.orange:
        return presets[4];
      case ThemeColorPresetsValue.red:
        return presets[5];
    }
  }

  /// Get preset options for UI
  static List<PresetOption> get presetsOption => presets
      .map(
        (color) => PresetOption(
          name: color.name,
          value: color.main,
        ),
      )
      .toList();

  /// Default preset
  static ColorPreset get defaultPreset => presets[0];

  /// Cyan preset
  static ColorPreset get cyanPreset => presets[1];

  /// Purple preset
  static ColorPreset get purplePreset => presets[2];

  /// Blue preset
  static ColorPreset get bluePreset => presets[3];

  /// Orange preset
  static ColorPreset get orangePreset => presets[4];

  /// Red preset
  static ColorPreset get redPreset => presets[5];
}
