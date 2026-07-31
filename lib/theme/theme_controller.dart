import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// GetX controller for managing theme mode throughout the app
class ThemeController extends GetxController {
  // Private reactive variable for theme mode
  final Rx<ThemeMode> _themeMode = Rx<ThemeMode>(ThemeMode.system);

  // GetStorage instance
  final GetStorage _storage = GetStorage();

  // Getter for theme mode
  ThemeMode get themeMode => _themeMode.value;

  // Key for storing theme preference in GetStorage
  static const String _themePreferenceKey = 'theme_mode';

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPreferences();
  }

  /// Load theme preference from local storage
  Future<void> _loadThemeFromPreferences() async {
    try {
      final themeModeString = _storage.read(_themePreferenceKey);

      if (themeModeString != null) {
        _themeMode.value = _getThemeModeFromString(themeModeString);
      } else {
        // Default to system theme if no preference is saved
        _themeMode.value = ThemeMode.system;
      }
    } catch (e) {
      // If there's an error loading preferences, default to system theme
      _themeMode.value = ThemeMode.system;
      debugPrint('Error loading theme preference: $e');
    }
  }

  /// Save theme preference to local storage
  Future<void> _saveThemeToPreferences(ThemeMode mode) async {
    try {
      await _storage.write(_themePreferenceKey, _getStringFromThemeMode(mode));
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }

  /// Change theme mode and save to preferences
  Future<void> changeThemeMode(ThemeMode mode) async {
    if (_themeMode.value != mode) {
      _themeMode.value = mode;
      await _saveThemeToPreferences(mode);

      // Update GetX theme
      Get.changeThemeMode(mode);
    }
  }

  /// Toggle between light and dark theme (excluding system)
  Future<void> toggleTheme() async {
    final newMode = _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await changeThemeMode(newMode);
  }

  /// Switch to light theme
  Future<void> setLightTheme() async {
    await changeThemeMode(ThemeMode.light);
  }

  /// Switch to dark theme
  Future<void> setDarkTheme() async {
    await changeThemeMode(ThemeMode.dark);
  }

  /// Switch to system theme
  Future<void> setSystemTheme() async {
    await changeThemeMode(ThemeMode.system);
  }

  /// Check if current theme is dark
  bool get isDarkMode {
    if (_themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode;
    }
    return _themeMode.value == ThemeMode.dark;
  }

  /// Check if current theme is light
  bool get isLightMode {
    if (_themeMode.value == ThemeMode.system) {
      return !Get.isPlatformDarkMode;
    }
    return _themeMode.value == ThemeMode.light;
  }

  /// Check if current theme is system
  bool get isSystemMode => _themeMode.value == ThemeMode.system;

  /// Get theme mode string for display purposes
  String get themeModeString {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  /// Convert ThemeMode enum to string for storage
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

  /// Convert string to ThemeMode enum
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

  /// Get available theme options for UI
  List<ThemeOption> get themeOptions => [
        const ThemeOption(
          mode: ThemeMode.light,
          title: 'Light',
          subtitle: 'Always use light theme',
          icon: Icons.light_mode,
        ),
        const ThemeOption(
          mode: ThemeMode.dark,
          title: 'Dark',
          subtitle: 'Always use dark theme',
          icon: Icons.dark_mode,
        ),
        const ThemeOption(
          mode: ThemeMode.system,
          title: 'System',
          subtitle: 'Follow system settings',
          icon: Icons.settings_brightness,
        ),
      ];
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
