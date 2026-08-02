import 'package:flutter/material.dart';
import '../custom_theme_extension.dart';
import 'index.dart';

/// Example usage of the Material UI style theme overrides system
/// This demonstrates how to use various component overrides and variants
class ThemeOverridesExample extends StatelessWidget {
  const ThemeOverridesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Overrides Example'),
        // AppBar automatically uses AppBarOverrides.create()
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     // Button Examples
        //     _buildSection(
        //       'Buttons',
        //       Column(
        //         children: [
        //           // Elevated Button variants
        //           ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButtonOverrides.create(customTheme).style,
        //             child: const Text('Default Elevated'),
        //           ),
        //           const SizedBox(height: 8),
        //           ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButtonOverrides.createSecondary(customTheme),
        //             child: const Text('Secondary Elevated'),
        //           ),
        //           const SizedBox(height: 8),
        //           ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButtonOverrides.createSmall(customTheme),
        //             child: const Text('Small'),
        //           ),
        //           const SizedBox(height: 8),

        //           // Outlined Button variants
        //           OutlinedButton(
        //             onPressed: () {},
        //             style: OutlinedButtonOverrides.create(customTheme).style,
        //             child: const Text('Default Outlined'),
        //           ),
        //           const SizedBox(height: 8),
        //           OutlinedButton(
        //             onPressed: () {},
        //             style: OutlinedButtonOverrides.createError(customTheme),
        //             child: const Text('Error Outlined'),
        //           ),
        //           const SizedBox(height: 8),

        //           // Text Button variants
        //           TextButton(
        //             onPressed: () {},
        //             style: TextButtonOverrides.create(customTheme).style,
        //             child: const Text('Default Text'),
        //           ),
        //         ],
        //       ),
        //     ),

        //     const SizedBox(height: 24),

        //     // Card Examples
        //     _buildSection(
        //       'Cards',
        //       Column(
        //         children: [
        //           Card(
        //             // Uses CardOverrides.create() automatically
        //             child: const Padding(
        //               padding: EdgeInsets.all(16),
        //               child: Text('Default Card'),
        //             ),
        //           ),

        //           // Custom card with specific override
        //           Card(
        //             color: CardOverrides.createElevated(customTheme).color,
        //             elevation: CardOverrides.createElevated(customTheme).elevation,
        //             shape: CardOverrides.createElevated(customTheme).shape,
        //             child: const Padding(
        //               padding: EdgeInsets.all(16),
        //               child: Text('Elevated Card'),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),

        //     const SizedBox(height: 24),

        //     // Input Examples
        //     _buildSection(
        //       'Inputs',
        //       Column(
        //         children: [
        //           TextField(
        //             decoration: InputDecoration(
        //               labelText: 'Default Input',
        //               // Uses InputDecorationOverrides.create() automatically
        //             ),
        //           ),
        //           const SizedBox(height: 16),

        //           // Custom input with specific override
        //           TextField(
        //             decoration: InputDecoration(
        //               labelText: 'Outlined Input',
        //             ).applyDefaults(
        //               InputDecorationOverrides.createOutlined(customTheme),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),

        //     const SizedBox(height: 24),

        //     // Chip Examples
        //     _buildSection(
        //       'Chips',
        //       Wrap(
        //         spacing: 8,
        //         children: [
        //           Chip(
        //             label: const Text('Default'),
        //             // Uses ChipOverrides.create() automatically
        //           ),

        //           // Custom chips with specific overrides
        //           Theme(
        //             data: Theme.of(context).copyWith(
        //               chipTheme: ChipOverrides.createFilled(customTheme),
        //             ),
        //             child: const Chip(label: Text('Filled')),
        //           ),

        //           Theme(
        //             data: Theme.of(context).copyWith(
        //               chipTheme: ChipOverrides.createOutlined(customTheme),
        //             ),
        //             child: const Chip(label: Text('Outlined')),
        //           ),

        //           Theme(
        //             data: Theme.of(context).copyWith(
        //               chipTheme: ChipOverrides.createError(customTheme),
        //             ),
        //             child: const Chip(label: Text('Error')),
        //           ),
        //         ],
        //       ),
        //     ),

        //     const SizedBox(height: 24),

        //     // Form Controls Examples
        //     _buildSection(
        //       'Form Controls',
        //       Column(
        //         children: [
        //           CheckboxListTile(
        //             title: const Text('Checkbox'),
        //             value: true,
        //             onChanged: (value) {},
        //             // Uses CheckboxOverrides.create() automatically
        //           ),
        //           RadioListTile<String>(
        //             title: const Text('Radio'),
        //             value: 'option1',
        //             groupValue: 'option1',
        //             onChanged: (value) {},
        //             // Uses RadioOverrides.create() automatically
        //           ),
        //           SwitchListTile(
        //             title: const Text('Switch'),
        //             value: true,
        //             onChanged: (value) {},
        //             // Uses SwitchOverrides.create() automatically
        //           ),
        //         ],
        //       ),
        //     ),

        //     const SizedBox(height: 24),

        //     // ListTile Examples
        //     _buildSection(
        //       'List Tiles',
        //       Column(
        //         children: [
        //           ListTile(
        //             leading: const Icon(Icons.home),
        //             title: const Text('Default ListTile'),
        //             subtitle: const Text('Uses ListTileOverrides.create()'),
        //             trailing: const Icon(Icons.arrow_forward),
        //             // Uses ListTileOverrides.create() automatically
        //           ),

        //           // Custom ListTile with specific override
        //           Theme(
        //             data: Theme.of(context).copyWith(
        //               listTileTheme: ListTileOverrides.createDense(customTheme),
        //             ),
        //             child: const ListTile(
        //               leading: Icon(Icons.settings),
        //               title: Text('Dense ListTile'),
        //               subtitle: Text('Compact spacing'),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // Uses FloatingActionButtonOverrides.create() automatically
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Example of how to create a custom theme using the overrides system
class CustomThemeExample {
  /// Create a theme with custom overrides applied
  static ThemeData createCustomTheme(CustomThemeExtension customTheme) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: customTheme.palette.common.primary.main,
        // ignore: unrelated_type_equality_checks
        brightness: customTheme.palette.mode == ThemeMode.light ? Brightness.light : Brightness.dark,
      ),
    );

    // Apply all overrides
    return ThemeOverrides.applyOverrides(baseTheme, customTheme);
  }

  /// Create a theme with selective overrides
  static ThemeData createSelectiveTheme(CustomThemeExtension customTheme) {
    final baseTheme = ThemeData(useMaterial3: true);

    return baseTheme.copyWith(
      // Apply only specific overrides
      elevatedButtonTheme: ElevatedButtonOverrides.create(baseTheme, customTheme),
      outlinedButtonTheme: OutlinedButtonOverrides.create(baseTheme, customTheme),
      textButtonTheme: TextButtonOverrides.create(baseTheme, customTheme),
      // cardTheme: CardOverrides.create(baseTheme, customTheme),
      inputDecorationTheme: InputDecorationOverrides.create(baseTheme, customTheme),
      appBarTheme: AppBarOverrides.create(baseTheme, customTheme),
    );
  }

  /// Create a theme with custom variants
  static ThemeData createVariantTheme(ThemeData baseTheme, CustomThemeExtension customTheme) {
    return baseTheme.copyWith(
      // Use specific variants instead of defaults
      elevatedButtonTheme: ElevatedButtonOverrides.create(baseTheme, customTheme),
      // cardTheme: CardOverrides.createElevated(baseTheme, customTheme),
      inputDecorationTheme: InputDecorationOverrides.createOutlined(baseTheme, customTheme),
      appBarTheme: AppBarOverrides.createTransparent(baseTheme, customTheme),
      chipTheme: ChipOverrides.createFilled(baseTheme, customTheme),
      listTileTheme: ListTileOverrides.createDense(baseTheme, customTheme),
    );
  }
}
