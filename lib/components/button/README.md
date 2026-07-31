# Custom Button Component

A generic, reusable button component that supports multiple variants, sizes, and colors using the predefined enums from the theme system.

## Features

- **Multiple Variants**: Contained, Outlined, and Text buttons
- **Multiple Sizes**: Small, Medium, and Large
- **Multiple Colors**: Primary, Secondary, Error, Warning, Info, and Success
- **Special States**: Loading, Disabled, with Icons
- **Full Width Support**: Option to expand button to full container width
- **Theme Integration**: Fully integrated with the app's theme system

## Usage

### Basic Usage

```dart
import 'package:minimals/components/button/index.dart';

// Basic contained button
CustomButton.contained(
  text: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
)

// Basic outlined button
CustomButton.outlined(
  text: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
)

// Basic text button
CustomButton.text(
  text: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
)
```

### Using Different Sizes

```dart
// Small button
CustomButton.contained(
  text: 'Small',
  size: ButtonSize.small,
  onPressed: () {},
)

// Medium button (default)
CustomButton.contained(
  text: 'Medium',
  size: ButtonSize.medium,
  onPressed: () {},
)

// Large button
CustomButton.contained(
  text: 'Large',
  size: ButtonSize.large,
  onPressed: () {},
)
```

### Using Different Colors

```dart
// Primary color (default)
CustomButton.contained(
  text: 'Primary',
  color: ButtonColor.primary,
  onPressed: () {},
)

// Error color
CustomButton.contained(
  text: 'Error',
  color: ButtonColor.error,
  onPressed: () {},
)

// Success color
CustomButton.contained(
  text: 'Success',
  color: ButtonColor.success,
  onPressed: () {},
)
```

### Special States

```dart
// Button with icon
CustomButton.contained(
  text: 'With Icon',
  icon: Icons.star,
  onPressed: () {},
)

// Loading button
CustomButton.contained(
  text: 'Loading',
  loading: true,
  onPressed: () {},
)

// Disabled button
CustomButton.contained(
  text: 'Disabled',
  disabled: true,
  onPressed: () {},
)

// Full width button
CustomButton.contained(
  text: 'Full Width',
  fullWidth: true,
  onPressed: () {},
)
```

### Using the Generic Constructor

```dart
CustomButton(
  text: 'Custom Button',
  variant: ButtonVariant.outlined,
  size: ButtonSize.large,
  color: ButtonColor.info,
  icon: Icons.info,
  fullWidth: true,
  onPressed: () {},
)
```

## Properties

| Property      | Type                  | Default                   | Description                                              |
| ------------- | --------------------- | ------------------------- | -------------------------------------------------------- |
| `text`        | `String`              | **required**              | The button's label text                                  |
| `onPressed`   | `VoidCallback?`       | `null`                    | Callback function executed when button is pressed        |
| `variant`     | `ButtonVariant`       | `ButtonVariant.contained` | Button variant (contained, outlined, text)               |
| `size`        | `ButtonSize`          | `ButtonSize.medium`       | Button size (small, medium, large)                       |
| `color`       | `ButtonColor`         | `ButtonColor.primary`     | Button color theme                                       |
| `disabled`    | `bool`                | `false`                   | Whether the button is disabled                           |
| `fullWidth`   | `bool`                | `false`                   | Whether the button should expand to fill available width |
| `icon`        | `IconData?`           | `null`                    | Optional icon to display before the text                 |
| `loading`     | `bool`                | `false`                   | Whether the button is in loading state                   |
| `padding`     | `EdgeInsetsGeometry?` | `null`                    | Custom padding override                                  |
| `minimumSize` | `Size?`               | `null`                    | Custom minimum size override                             |
| `style`       | `ButtonStyle?`        | `null`                    | Additional styling for the button                        |

## Enums

### ButtonVariant
- `ButtonVariant.contained` - Filled button with background color
- `ButtonVariant.outlined` - Button with border and transparent background
- `ButtonVariant.text` - Text-only button with no background or border

### ButtonSize
- `ButtonSize.small` - Compact button for dense layouts
- `ButtonSize.medium` - Standard button size
- `ButtonSize.large` - Prominent button for primary actions

### ButtonColor
- `ButtonColor.primary` - App's primary color
- `ButtonColor.secondary` - App's secondary color
- `ButtonColor.error` - Error/danger color (typically red)
- `ButtonColor.warning` - Warning color (typically orange/yellow)
- `ButtonColor.info` - Info color (typically blue)
- `ButtonColor.success` - Success color (typically green)

## Examples

See `button_examples.dart` for a comprehensive example showing all button variants, sizes, colors, and states.
