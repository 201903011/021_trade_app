# Flutter Material UI Theme Overrides

This folder contains Material UI style theme overrides for Flutter, converting Material-UI design principles into Flutter-compatible theme configurations.

## Overview

The overrides system provides a Material-UI-like approach to theming Flutter applications, allowing for consistent and customizable component styling across the entire app.

## Structure

```
overrides/
├── index.dart              # Barrel file for all exports
├── overrides.dart          # Main overrides application logic
├── app_bar.dart           # AppBar theme overrides
├── button.dart            # Common button utilities
├── card.dart              # Card theme overrides
├── checkbox.dart          # Checkbox theme overrides
├── chip.dart              # Chip theme overrides
├── dialog.dart            # Dialog theme overrides
├── drawer.dart            # Drawer theme overrides
├── elevated_button.dart   # ElevatedButton theme overrides
├── fab.dart               # FloatingActionButton theme overrides
├── icon_button.dart       # IconButton theme overrides
├── input_decoration.dart  # InputDecoration theme overrides
├── list_tile.dart         # ListTile theme overrides
├── navigation_bar.dart    # NavigationBar theme overrides
├── outlined_button.dart   # OutlinedButton theme overrides
├── radio.dart             # Radio theme overrides
├── slider.dart            # Slider theme overrides
├── switch.dart            # Switch theme overrides
├── tab_bar.dart           # TabBar theme overrides
├── text_button.dart       # TextButton theme overrides
└── tooltip.dart           # Tooltip theme overrides
```

## Usage

### Basic Usage

To apply all theme overrides at once:

```dart
import 'package:minimals/theme/overrides/index.dart';

// In your theme creation
final customTheme = CustomThemeExtension.create(ThemeMode.light, colorPreset);
final baseTheme = ThemeData(/* your base theme config */);
final themedApp = ThemeOverrides.applyOverrides(baseTheme, customTheme);
```

### Individual Component Usage

Each component override can be used independently:

```dart
import 'package:minimals/theme/overrides/elevated_button.dart';

// Create specific button variants
final primaryButton = ElevatedButtonOverrides.create(customTheme);
final secondaryButton = ElevatedButtonOverrides.createSecondary(customTheme);
final smallButton = ElevatedButtonOverrides.createSmall(customTheme);
```

### Custom Component Variants

Most components provide multiple variants:

```dart
// Button variants
ElevatedButtonOverrides.create(customTheme)           // Default
ElevatedButtonOverrides.createSmall(customTheme)      // Small size
ElevatedButtonOverrides.createLarge(customTheme)      // Large size
ElevatedButtonOverrides.createSecondary(customTheme)  // Secondary color
ElevatedButtonOverrides.createError(customTheme)      // Error color
ElevatedButtonOverrides.createRounded(customTheme)    // Rounded corners
ElevatedButtonOverrides.createPill(customTheme)       // Pill shape

// Card variants
CardOverrides.create(customTheme)                     // Default
CardOverrides.createFlat(customTheme)                 // No shadow
CardOverrides.createElevated(customTheme)             // More shadow
CardOverrides.createOutlined(customTheme)             // Outlined
CardOverrides.createRounded(customTheme)              // Rounded
CardOverrides.createPrimaryAccent(customTheme)        // Primary accent border

// Input variants
InputDecorationOverrides.create(customTheme)          // Default filled
InputDecorationOverrides.createOutlined(customTheme)  // Outlined
InputDecorationOverrides.createFilled(customTheme)    // Filled
InputDecorationOverrides.createUnderlined(customTheme) // Underlined
InputDecorationOverrides.createDense(customTheme)     // Dense padding
InputDecorationOverrides.createRounded(customTheme)   // Rounded
```

## Key Features

### 1. Material-UI Inspired Design
- Consistent with Material Design principles
- Follows Material-UI component API patterns
- Supports multiple variants and sizes

### 2. Comprehensive Component Coverage
- All major Flutter components are covered
- Custom variants for different use cases
- Consistent theming across components

### 3. Responsive Design
- Adaptive sizing (small, medium, large)
- Proper touch targets
- Accessibility considerations

### 4. Color System Integration
- Primary, secondary, error color variants
- Proper contrast ratios
- Support for custom color schemes

### 5. State Management
- Hover, focus, pressed states
- Disabled states
- Selected states

## Component-Specific Features

### Buttons
- **Variants**: Contained (Elevated), Outlined, Text
- **Sizes**: Small, Medium, Large
- **Colors**: Primary, Secondary, Error, Warning, Info, Success
- **Shapes**: Default, Rounded, Pill

### Cards
- **Variants**: Default, Flat, Elevated, Outlined, Subtle
- **Shapes**: Default, Rounded, Square, Sharp
- **Accents**: Primary, Error, Warning, Success

### Inputs
- **Variants**: Filled, Outlined, Underlined, Standard, Borderless
- **Sizes**: Default, Dense
- **Shapes**: Default, Rounded

### Navigation
- **AppBar**: Transparent, Elevated variants
- **NavigationBar**: Bottom navigation with indicators
- **Drawer**: Rounded corners, proper elevation

## Customization

### Adding New Variants

To add a new variant to any component:

```dart
// In the component's override file
static ButtonStyle createCustomVariant(CustomThemeExtension customTheme) {
  return create(customTheme).style!.copyWith(
    backgroundColor: WidgetStateProperty.all(customColor),
    // ... other customizations
  );
}
```

### Modifying Existing Variants

```dart
// Extend existing variants
static ButtonStyle createCustomPrimary(CustomThemeExtension customTheme) {
  return create(customTheme).style!.copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
    // ... other modifications
  );
}
```

## Best Practices

### 1. Use Semantic Colors
```dart
// Good
color: customTheme.palette.common.primary.main
color: customTheme.palette.common.error.main

// Avoid
color: Colors.blue
color: Colors.red
```

### 2. Maintain Consistency
- Use the same padding patterns across similar components
- Follow the established border radius conventions
- Maintain consistent elevation levels

### 3. Accessibility
- Ensure proper contrast ratios
- Use appropriate touch target sizes
- Include proper focus indicators

### 4. Performance
- Reuse theme data where possible
- Avoid creating new theme objects unnecessarily
- Use `WidgetStateProperty.resolveWith` for dynamic states

## Integration with App Theme

To integrate with your main app theme:

```dart
// In app_theme.dart
import 'package:minimals/theme/overrides/index.dart';

static ThemeData createLightTheme({
  ColorPreset? colorPreset,
}) {
  final customTheme = CustomThemeExtension.create(ThemeMode.light, colorPreset);
  final baseTheme = ThemeData(/* base config */);
  
  // Apply overrides
  return ThemeOverrides.applyOverrides(baseTheme, customTheme);
}
```

## Migration Guide

If you're migrating from the old theme system:

1. Replace direct `ThemeData` property assignments with override calls
2. Use component-specific override methods instead of inline styling
3. Leverage the variant system for different component appearances
4. Update imports to use the new overrides system

## Examples

### Button Example
```dart
// Old way
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: theme.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
  child: Text('Button'),
)

// New way with overrides
ElevatedButton(
  style: ElevatedButtonOverrides.createLarge(customTheme),
  child: Text('Button'),
)
```

### Card Example
```dart
// Old way
Card(
  color: theme.cardColor,
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: content,
)

// New way with overrides
Card(
  // Theme automatically applied via CardOverrides.create()
  child: content,
)
```

This overrides system provides a robust, scalable, and maintainable approach to theming Flutter applications with Material-UI inspired design patterns.
