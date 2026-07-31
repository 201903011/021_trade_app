# Settings Module

This module provides a comprehensive settings system for Flutter applications using GetX state management. It converts React MUI theme and contrast logic into Flutter Dart with GetX.

## Features

- **Theme Management**: Light, Dark, and System theme modes
- **Color Presets**: Multiple color schemes (Default, Cyan, Purple, Blue, Orange, Red)
- **Layout Options**: Vertical, Horizontal, and Mini layouts
- **Appearance Controls**: Compact mode, High contrast, and Stretch layout
- **Persistent Storage**: All settings are saved using GetStorage
- **Reactive Updates**: Automatic UI updates when settings change

## Usage

### 1. Initialize in AppBindings

```dart
import 'package:minimals/settings/settings_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController(), permanent: true);
  }
}
```

### 2. Use in GetMaterialApp

```dart
import 'package:minimals/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (settingsController) {
        return GetMaterialApp(
          theme: settingsController.getThemeData(isDark: false),
          darkTheme: settingsController.getThemeData(isDark: true),
          themeMode: settingsController.themeMode,
          // ... other properties
        );
      },
    );
  }
}
```

### 3. Access Settings in Widgets

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    
    return GetBuilder<SettingsController>(
      builder: (controller) {
        return Container(
          color: controller.currentColorPreset.main,
          child: Text('Current theme: ${controller.themeModeString}'),
        );
      },
    );
  }
}
```

### 4. Change Settings

```dart
// Change theme mode
settingsController.changeThemeMode(ThemeMode.dark);

// Change color preset
settingsController.changeColorPreset(ThemeColorPresetsValue.cyan);

// Toggle features
settingsController.toggleCompact();
settingsController.toggleContrast();

// Reset all settings
settingsController.resetSettings();
```

## Available Settings

### Theme Modes
- `ThemeMode.light` - Always light theme
- `ThemeMode.dark` - Always dark theme  
- `ThemeMode.system` - Follow system preference

### Color Presets
- `ThemeColorPresetsValue.defaultTheme` - Default green theme
- `ThemeColorPresetsValue.cyan` - Cyan theme
- `ThemeColorPresetsValue.purple` - Purple theme
- `ThemeColorPresetsValue.blue` - Blue theme
- `ThemeColorPresetsValue.orange` - Orange theme
- `ThemeColorPresetsValue.red` - Red theme

### Layout Options
- `ThemeLayout.vertical` - Vertical layout
- `ThemeLayout.horizontal` - Horizontal layout
- `ThemeLayout.mini` - Mini layout

### Appearance Features
- **Compact Mode**: Reduces spacing and padding
- **High Contrast**: Improves accessibility with higher contrast
- **Stretch Layout**: Stretches content to fill available space

## File Structure

```
lib/settings/
├── settings.dart                 # Main export file
├── settings_controller.dart      # Main controller
├── types.dart                   # Type definitions
├── presets.dart                 # Color presets
├── pages/
│   └── settings_page.dart       # Settings UI page
└── examples/
    └── settings_example.dart    # Usage examples
```

## Key Classes

### SettingsController
Main controller that manages all settings state and persistence.

### ColorPreset
Defines a color scheme with lighter, light, main, dark, darker, and contrast text colors.

### ThemePresets
Static class containing all available color presets.

## Migration from ThemeController

If you're migrating from the old ThemeController:

1. Replace `ThemeController` with `SettingsController` in bindings
2. Update `GetBuilder<ThemeController>` to `GetBuilder<SettingsController>`
3. Replace `AppTheme.createLightTheme()` with `settingsController.getThemeData(isDark: false)`
4. Replace `AppTheme.createDarkTheme()` with `settingsController.getThemeData(isDark: true)`

## Storage Keys

Settings are stored using these keys:
- `theme_mode` - Theme mode preference
- `color_preset` - Selected color preset
- `layout` - Layout preference
- `stretch` - Stretch setting
- `compact` - Compact mode setting
- `contrast` - High contrast setting
