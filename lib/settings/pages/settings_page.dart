import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../settings_controller.dart';
import '../presets.dart';
import '../types.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Get.find<SettingsController>().resetSettings(),
            tooltip: 'Reset to defaults',
          ),
        ],
      ),
      body: Obx(() {
        final controller = Get.find<SettingsController>();
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildThemeModeSection(controller),
            const SizedBox(height: 24),
            _buildColorPresetSection(controller),
            const SizedBox(height: 24),
            _buildLayoutSection(controller),
            const SizedBox(height: 24),
            _buildAppearanceSection(controller),
          ],
        );
      }),
    );
  }

  Widget _buildThemeModeSection(SettingsController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Mode',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...controller.themeOptions.map(
              (option) => RadioListTile<ThemeMode>(
                title: Text(option.title),
                subtitle: Text(option.subtitle),
                value: option.mode,
                groupValue: controller.themeMode.value,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    controller.changeThemeMode(value);
                  }
                },
                secondary: Icon(option.icon),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPresetSection(SettingsController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Color Preset',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ThemeColorPresetsValue.values.map(
                (preset) {
                  final colorPreset = ThemePresets.getPreset(preset);
                  final isSelected = controller.colorPreset.value == preset;

                  return GestureDetector(
                    onTap: () => controller.changeColorPreset(preset),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: colorPreset.main,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Theme.of(Get.context!).colorScheme.onSurface : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24,
                            )
                          : null,
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutSection(SettingsController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Layout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...ThemeLayout.values.map(
              (layout) => RadioListTile<ThemeLayout>(
                title: Text(layout.toString().split('.').last.capitalize!),
                value: layout,
                groupValue: controller.layout.value,
                onChanged: (ThemeLayout? value) {
                  if (value != null) {
                    controller.changeLayout(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(SettingsController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appearance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Compact Mode'),
              subtitle: const Text('Reduce spacing and padding'),
              value: controller.compact.value,
              onChanged: (value) => controller.toggleCompact(),
            ),
            SwitchListTile(
              title: const Text('High Contrast'),
              subtitle: const Text('Increase contrast for better accessibility'),
              value: controller.contrast.value,
              onChanged: (value) => controller.toggleContrast(),
            ),
            SwitchListTile(
              title: const Text('Stretch Layout'),
              subtitle: const Text('Stretch content to fill available space'),
              value: controller.stretch.value == ThemeStretch.enabled,
              onChanged: (value) => controller.changeStretch(
                value ? ThemeStretch.enabled : ThemeStretch.disabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
