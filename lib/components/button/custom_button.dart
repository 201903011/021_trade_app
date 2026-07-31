import 'package:flutter/material.dart';
import 'package:minimals/theme/custom_theme_extension.dart';
import 'package:minimals/theme/overrides/button.dart';
import 'package:minimals/theme/overrides/elevated_button.dart';
import 'package:minimals/theme/use_theme.dart';

/// A generic, reusable button component that supports multiple variants, sizes, and colors
class CustomButton extends StatelessWidget {
  /// The button's label text
  final String text;

  /// Callback function executed when button is pressed
  final VoidCallback? onPressed;

  /// Button variant (contained, outlined, text)
  final ButtonVariant variant;

  /// Button size (small, medium, large)
  final ButtonSize size;

  /// Button color theme
  final ButtonColor color;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button should expand to fill available width
  final bool fullWidth;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Whether the button is in loading state
  final bool loading;

  /// Custom padding override
  final EdgeInsetsGeometry? padding;

  /// Custom minimum size override
  final Size? minimumSize;

  /// Additional styling for the button
  final ButtonStyle? style;

  /// Whether the button should have rounded corners
  final bool rounded;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.contained,
    this.size = ButtonSize.medium,
    this.color = ButtonColor.primary,
    this.disabled = false,
    this.fullWidth = false,
    this.icon,
    this.loading = false,
    this.padding,
    this.minimumSize,
    this.style,
    this.rounded = false,
  });

  /// Factory constructor for contained button
  factory CustomButton.contained({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    ButtonColor color = ButtonColor.primary,
    bool disabled = false,
    bool fullWidth = false,
    IconData? icon,
    bool loading = false,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    ButtonStyle? style,
    bool rounded = false,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.contained,
      size: size,
      color: color,
      disabled: disabled,
      fullWidth: fullWidth,
      icon: icon,
      loading: loading,
      padding: padding,
      minimumSize: minimumSize,
      style: style,
      rounded: rounded,
    );
  }

  /// Factory constructor for outlined button
  factory CustomButton.outlined({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    ButtonColor color = ButtonColor.primary,
    bool disabled = false,
    bool fullWidth = false,
    IconData? icon,
    bool loading = false,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    ButtonStyle? style,
    bool rounded = false,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.outlined,
      size: size,
      color: color,
      disabled: disabled,
      fullWidth: fullWidth,
      icon: icon,
      loading: loading,
      padding: padding,
      minimumSize: minimumSize,
      style: style,
      rounded: rounded,
    );
  }

  /// Factory constructor for text button
  factory CustomButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    ButtonColor color = ButtonColor.primary,
    bool disabled = false,
    bool fullWidth = false,
    IconData? icon,
    bool loading = false,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    ButtonStyle? style,
    bool rounded = false,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.text,
      size: size,
      color: color,
      disabled: disabled,
      fullWidth: fullWidth,
      icon: icon,
      loading: loading,
      padding: padding,
      minimumSize: minimumSize,
      style: style,
      rounded: rounded,
    );
  }

  /// Factory constructor for rounded button (contained variant)
  factory CustomButton.rounded({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    ButtonColor color = ButtonColor.primary,
    bool disabled = false,
    bool fullWidth = false,
    IconData? icon,
    bool loading = false,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    ButtonStyle? style,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.contained,
      size: size,
      color: color,
      disabled: disabled,
      fullWidth: fullWidth,
      icon: icon,
      loading: loading,
      padding: padding,
      minimumSize: minimumSize,
      style: style,
      rounded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    // Build button content
    Widget buttonContent = _buildButtonContent(baseTheme, customTheme);

    // Apply full width if needed
    if (fullWidth) {
      buttonContent = SizedBox(
        width: double.infinity,
        child: buttonContent,
      );
    }

    return buttonContent;
  }

  Widget _buildButtonContent(ThemeData baseTheme, CustomThemeExtension customTheme) {
    final isDisabled = disabled || loading;

    // Create button style using ElevatedButtonOverrides
    final buttonStyle = _createButtonStyleWithOverrides(baseTheme, customTheme, isDisabled);

    // Create button child content
    final child = _buildButtonChild(customTheme);

    // Return appropriate button type based on variant
    switch (variant) {
      case ButtonVariant.contained:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: child,
        );
      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: child,
        );
      case ButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: child,
        );
    }
  }

  Widget _buildButtonChild(CustomThemeExtension customTheme) {
    final textStyle = ButtonOverrides.getButtonTextStyle(customTheme, size);
    final buttonColor = color.getColor(customTheme);
    final contrastColor = color.getContrastColor(customTheme);

    // Show loading indicator if loading
    if (loading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size == ButtonSize.small ? 14 : 16,
            height: size == ButtonSize.small ? 14 : 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.contained ? contrastColor : buttonColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: textStyle,
          ),
        ],
      );
    }

    // Show icon and text if icon is provided
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: size == ButtonSize.small ? 16 : (size == ButtonSize.large ? 20 : 18),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: textStyle,
          ),
        ],
      );
    }

    // Default text only
    return Text(
      text,
      style: textStyle,
    );
  }

  ButtonStyle _createButtonStyleWithOverrides(
    ThemeData baseTheme,
    CustomThemeExtension customTheme,
    bool isDisabled,
  ) {
    ButtonStyle baseStyle;

    // Get base style from ElevatedButtonOverrides based on size and color
    switch (size) {
      case ButtonSize.small:
        baseStyle = ElevatedButtonOverrides.createSmall(baseTheme, customTheme);
        break;
      case ButtonSize.large:
        baseStyle = ElevatedButtonOverrides.createLarge(baseTheme, customTheme);
        break;
      case ButtonSize.medium:
        baseStyle = ElevatedButtonOverrides.create(baseTheme, customTheme).style!;
        break;
    }

    // Apply color variant
    switch (color) {
      case ButtonColor.secondary:
        baseStyle = ElevatedButtonOverrides.createSecondary(baseTheme, customTheme);
        break;
      case ButtonColor.error:
        baseStyle = ElevatedButtonOverrides.createError(baseTheme, customTheme);
        break;
      case ButtonColor.primary:
      case ButtonColor.warning:
      case ButtonColor.info:
      case ButtonColor.success:
        // Use default primary style, but update colors if needed
        if (color != ButtonColor.primary) {
          final buttonColor = color.getColor(customTheme);
          final contrastColor = color.getContrastColor(customTheme);
          baseStyle = baseStyle.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return customTheme.palette.action.disabledBackground;
              }
              return buttonColor;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return customTheme.palette.action.disabled;
              }
              return contrastColor;
            }),
          );
        }
        break;
    }

    // Apply rounded corners if requested
    if (rounded) {
      baseStyle = ElevatedButtonOverrides.createRounded(baseTheme, customTheme);

      // Reapply size and color overrides if needed
      if (size != ButtonSize.medium) {
        baseStyle = baseStyle.copyWith(
          padding: WidgetStateProperty.all(
            padding ?? ButtonOverrides.getButtonPadding(size),
          ),
          minimumSize: WidgetStateProperty.all(
            minimumSize ?? ButtonOverrides.getButtonMinimumSize(size),
          ),
          textStyle: WidgetStateProperty.all(
            ButtonOverrides.getButtonTextStyle(customTheme, size),
          ),
        );
      }

      // Reapply color if not primary
      if (color != ButtonColor.primary) {
        final buttonColor = color.getColor(customTheme);
        final contrastColor = color.getContrastColor(customTheme);
        baseStyle = baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return customTheme.palette.action.disabledBackground;
            }
            return buttonColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return customTheme.palette.action.disabled;
            }
            return contrastColor;
          }),
        );
      }
    }

    // Apply custom overrides
    if (padding != null) {
      baseStyle = baseStyle.copyWith(
        padding: WidgetStateProperty.all(padding),
      );
    }

    if (minimumSize != null) {
      baseStyle = baseStyle.copyWith(
        minimumSize: WidgetStateProperty.all(minimumSize),
      );
    }

    // Merge with custom style if provided
    if (style != null) {
      baseStyle = baseStyle.merge(style);
    }

    // For outlined and text variants, create appropriate styles based on the elevated button style
    switch (variant) {
      case ButtonVariant.contained:
        return baseStyle;
      case ButtonVariant.outlined:
        return _createOutlinedStyleFromBase(baseStyle, customTheme);
      case ButtonVariant.text:
        return _createTextStyleFromBase(baseStyle, customTheme);
    }
  }

  ButtonStyle _createOutlinedStyleFromBase(
    ButtonStyle baseStyle,
    CustomThemeExtension customTheme,
  ) {
    // Extract colors from the base style
    final backgroundColor = baseStyle.backgroundColor?.resolve({});
    final foregroundColor = baseStyle.foregroundColor?.resolve({});

    return baseStyle.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return backgroundColor?.withOpacity(0.08) ?? Colors.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return backgroundColor?.withOpacity(0.12) ?? Colors.transparent;
        }
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return backgroundColor ?? foregroundColor;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: customTheme.palette.action.disabled);
        }
        return BorderSide(color: backgroundColor ?? Colors.grey);
      }),
      elevation: WidgetStateProperty.all(0),
    );
  }

  ButtonStyle _createTextStyleFromBase(
    ButtonStyle baseStyle,
    CustomThemeExtension customTheme,
  ) {
    // Extract colors from the base style
    final backgroundColor = baseStyle.backgroundColor?.resolve({});
    final foregroundColor = baseStyle.foregroundColor?.resolve({});

    return baseStyle.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return backgroundColor?.withOpacity(0.08) ?? Colors.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return backgroundColor?.withOpacity(0.12) ?? Colors.transparent;
        }
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return customTheme.palette.action.disabled;
        }
        return backgroundColor ?? foregroundColor;
      }),
      elevation: WidgetStateProperty.all(0),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return backgroundColor?.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return backgroundColor?.withOpacity(0.12);
        }
        return null;
      }),
    );
  }
}
