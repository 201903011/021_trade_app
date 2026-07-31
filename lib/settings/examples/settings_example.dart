import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../settings_controller.dart';
import '../types.dart';

/// Example widget showing how to use SettingsController
class SettingsExample extends StatelessWidget {
  const SettingsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Example'),
      ),
      body: Obx(() {
        final settingsController = Get.find<SettingsController>();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Theme Mode Controls
              const Text(
                'Theme Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => settingsController.changeThemeMode(ThemeMode.light),
                    child: const Text('Light'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => settingsController.changeThemeMode(ThemeMode.dark),
                    child: const Text('Dark'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => settingsController.changeThemeMode(ThemeMode.system),
                    child: const Text('System'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Color Preset Controls
              const Text(
                'Color Presets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ThemeColorPresetsValue.values.map((preset) {
                  final isSelected = settingsController.colorPreset.value == preset;
                  return FilterChip(
                    label: Text(preset.toString().split('.').last.capitalize!),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        settingsController.changeColorPreset(preset);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Layout Controls
              const Text(
                'Layout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SegmentedButton<ThemeLayout>(
                segments: ThemeLayout.values.map((layout) {
                  return ButtonSegment<ThemeLayout>(
                    value: layout,
                    label: Text(layout.toString().split('.').last.capitalize!),
                  );
                }).toList(),
                selected: {settingsController.layout.value},
                onSelectionChanged: (Set<ThemeLayout> newSelection) {
                  settingsController.changeLayout(newSelection.first);
                },
              ),
              const SizedBox(height: 16),

              // Toggle Controls
              const Text(
                'Appearance Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Compact Mode'),
                value: settingsController.compact.value,
                onChanged: (value) => settingsController.toggleCompact(),
              ),
              SwitchListTile(
                title: const Text('High Contrast'),
                value: settingsController.contrast.value,
                onChanged: (value) => settingsController.toggleContrast(),
              ),
              SwitchListTile(
                title: const Text('Stretch Layout'),
                value: settingsController.stretch.value == ThemeStretch.enabled,
                onChanged: (value) => settingsController.changeStretch(
                  value ? ThemeStretch.enabled : ThemeStretch.disabled,
                ),
              ),
              const SizedBox(height: 16),

              // Current Settings Display
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Settings',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Theme Mode: ${settingsController.themeModeString}'),
                      Text('Color Preset: ${settingsController.colorPreset.value.toString().split('.').last}'),
                      Text('Layout: ${settingsController.layout.value.toString().split('.').last}'),
                      Text('Compact: ${settingsController.compact.value}'),
                      Text('Contrast: ${settingsController.contrast.value}'),
                      Text('Stretch: ${settingsController.stretch.value.toString().split('.').last}'),
                      Text('Dark Mode: ${settingsController.isDarkMode}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Reset Button
              ElevatedButton(
                onPressed: () => settingsController.resetSettings(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Reset All Settings'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
