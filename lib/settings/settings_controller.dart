import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/theme/app_theme.dart';
import 'types.dart';
import 'presets.dart';

/// Settings controller for managing app theme, layout, and other settings
class SettingsController extends GetxController {
  // Storage instance
  final GetStorage _storage = GetStorage();

  // Storage keys
  static const String _themeModeKey = 'theme_mode';
  static const String _colorPresetKey = 'color_preset';
  static const String _layoutKey = 'layout';
  static const String _stretchKey = 'stretch';
  static const String _compactKey = 'compact';
  static const String _contrastKey = 'contrast';

  // Public reactive variables
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final Rx<ThemeColorPresetsValue> colorPreset = ThemeColorPresetsValue.defaultTheme.obs;
  final Rx<ThemeLayout> layout = ThemeLayout.vertical.obs;
  final Rx<ThemeStretch> stretch = ThemeStretch.disabled.obs;
  final RxBool compact = false.obs;
  final RxBool contrast = false.obs;

  /// Get current color preset object
  ColorPreset get currentColorPreset => ThemePresets.getPreset(colorPreset.value);

  /// Check if current theme is dark
  bool get isDarkMode {
    if (themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode;
    }
    return themeMode.value == ThemeMode.dark;
  }

  /// Check if current theme is light
  bool get isLightMode {
    if (themeMode.value == ThemeMode.system) {
      return !Get.isPlatformDarkMode;
    }
    return themeMode.value == ThemeMode.light;
  }

  /// Check if current theme is system
  bool get isSystemMode => themeMode.value == ThemeMode.system;

  /// Get theme mode string for display
  String get themeModeString {
    switch (themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  /// Load all settings from storage
  Future<void> _loadSettings() async {
    try {
      // Load theme mode
      final themeModeString = _storage.read(_themeModeKey);
      if (themeModeString != null) {
        themeMode.value = _getThemeModeFromString(themeModeString);
      }

      // Load color preset
      final colorPresetString = _storage.read(_colorPresetKey);
      if (colorPresetString != null) {
        colorPreset.value = _getColorPresetFromString(colorPresetString);
      }

      // Load layout
      final layoutString = _storage.read(_layoutKey);
      if (layoutString != null) {
        layout.value = _getLayoutFromString(layoutString);
      }

      // Load stretch
      final stretchString = _storage.read(_stretchKey);
      if (stretchString != null) {
        stretch.value = _getStretchFromString(stretchString);
      }

      // Load compact
      final compactValue = _storage.read(_compactKey);
      if (compactValue != null) {
        compact.value = compactValue as bool;
      }

      // Load contrast
      final contrastValue = _storage.read(_contrastKey);
      if (contrastValue != null) {
        contrast.value = contrastValue as bool;
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  /// Change theme mode
  Future<void> changeThemeMode(ThemeMode mode) async {
    if (themeMode.value != mode) {
      themeMode.value = mode;
      await _storage.write(_themeModeKey, _getStringFromThemeMode(mode));
      Get.changeThemeMode(mode);
    }
  }

  /// Change color preset
  Future<void> changeColorPreset(ThemeColorPresetsValue preset) async {
    if (colorPreset.value != preset) {
      colorPreset.value = preset;
      await _storage.write(_colorPresetKey, _getStringFromColorPreset(preset));
      // Force rebuild to apply new colors
      update();
    }
  }

  /// Change layout
  Future<void> changeLayout(ThemeLayout layoutValue) async {
    if (layout.value != layoutValue) {
      layout.value = layoutValue;
      await _storage.write(_layoutKey, _getStringFromLayout(layoutValue));
    }
  }

  /// Change stretch
  Future<void> changeStretch(ThemeStretch stretchValue) async {
    if (stretch.value != stretchValue) {
      stretch.value = stretchValue;
      await _storage.write(_stretchKey, _getStringFromStretch(stretchValue));
    }
  }

  /// Toggle compact mode
  Future<void> toggleCompact() async {
    compact.value = !compact.value;
    await _storage.write(_compactKey, compact.value);
  }

  /// Toggle contrast mode
  Future<void> toggleContrast() async {
    contrast.value = !contrast.value;
    await _storage.write(_contrastKey, contrast.value);
  }

  /// Reset all settings to defaults
  Future<void> resetSettings() async {
    themeMode.value = ThemeMode.system;
    colorPreset.value = ThemeColorPresetsValue.defaultTheme;
    layout.value = ThemeLayout.vertical;
    stretch.value = ThemeStretch.disabled;
    compact.value = false;
    contrast.value = false;

    await _storage.remove(_themeModeKey);
    await _storage.remove(_colorPresetKey);
    await _storage.remove(_layoutKey);
    await _storage.remove(_stretchKey);
    await _storage.remove(_compactKey);
    await _storage.remove(_contrastKey);

    Get.changeThemeMode(themeMode.value);
    update();
  }

  /// Get theme data based on current settings
  ThemeData getThemeData({required bool isDark}) {
    return AppTheme.createTheme(
      isDark: isDark,
      colorPreset: currentColorPreset,
    );
  }

  /// Get available theme options for UI
  List<ThemeOption> get themeOptions => [
        ThemeOption(
          mode: ThemeMode.light,
          title: 'Light',
          subtitle: 'Always use light theme',
          icon: Icons.light_mode,
        ),
        ThemeOption(
          mode: ThemeMode.dark,
          title: 'Dark',
          subtitle: 'Always use dark theme',
          icon: Icons.dark_mode,
        ),
        ThemeOption(
          mode: ThemeMode.system,
          title: 'System',
          subtitle: 'Follow system settings',
          icon: Icons.settings_brightness,
        ),
      ];

  // String conversion methods
  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  ThemeMode _getThemeModeFromString(String modeString) {
    switch (modeString.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String _getStringFromColorPreset(ThemeColorPresetsValue preset) {
    return preset.toString().split('.').last;
  }

  ThemeColorPresetsValue _getColorPresetFromString(String presetString) {
    switch (presetString.toLowerCase()) {
      case 'defaulttheme':
        return ThemeColorPresetsValue.defaultTheme;
      case 'cyan':
        return ThemeColorPresetsValue.cyan;
      case 'purple':
        return ThemeColorPresetsValue.purple;
      case 'blue':
        return ThemeColorPresetsValue.blue;
      case 'orange':
        return ThemeColorPresetsValue.orange;
      case 'red':
        return ThemeColorPresetsValue.red;
      default:
        return ThemeColorPresetsValue.defaultTheme;
    }
  }

  String _getStringFromLayout(ThemeLayout layout) {
    return layout.toString().split('.').last;
  }

  ThemeLayout _getLayoutFromString(String layoutString) {
    switch (layoutString.toLowerCase()) {
      case 'vertical':
        return ThemeLayout.vertical;
      case 'horizontal':
        return ThemeLayout.horizontal;
      case 'mini':
        return ThemeLayout.mini;
      default:
        return ThemeLayout.vertical;
    }
  }

  String _getStringFromStretch(ThemeStretch stretch) {
    return stretch.toString().split('.').last;
  }

  ThemeStretch _getStretchFromString(String stretchString) {
    switch (stretchString.toLowerCase()) {
      case 'enabled':
        return ThemeStretch.enabled;
      case 'disabled':
        return ThemeStretch.disabled;
      default:
        return ThemeStretch.disabled;
    }
  }
}

/// Model for theme options in UI
class ThemeOption {
  final ThemeMode mode;
  final String title;
  final String subtitle;
  final IconData icon;

  const ThemeOption({
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
