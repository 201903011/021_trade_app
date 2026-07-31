// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:minimals/theme/palette/index.dart';

/// Shadow configuration for the application
/// Converts Material-UI shadow system to Flutter BoxShadow system
class AppShadows {
  // Helper method to get theme colors for shadow generation

  static const Color _lightModeColor = GreyColors.grey500;
  static const Color _darkModeColor = AppPalette.black;

  /// Creates shadow configuration based on theme mode
  /// Returns a map of elevation levels to BoxShadow lists
  static Map<int, List<BoxShadow>> createShadows(ThemeMode themeMode) {
    final Color shadowColor = themeMode == ThemeMode.light ? _lightModeColor : _darkModeColor;

    // Create transparency variants
    final Color transparent1 = shadowColor.withOpacity(0.2);
    final Color transparent2 = shadowColor.withOpacity(0.14);
    final Color transparent3 = shadowColor.withOpacity(0.12);

    return {
      0: [], // No shadow
      1: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 2),
          blurRadius: 1,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 1),
          blurRadius: 1,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
        ),
      ],
      2: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 3),
          blurRadius: 1,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 2),
          blurRadius: 2,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 1),
          blurRadius: 5,
          spreadRadius: 0,
        ),
      ],
      3: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 3),
          blurRadius: 3,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 3),
          blurRadius: 4,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 1),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      4: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 4),
          blurRadius: 5,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 1),
          blurRadius: 10,
          spreadRadius: 0,
        ),
      ],
      6: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0,
        ),
      ],
      8: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 5),
          blurRadius: 5,
          spreadRadius: -3,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 8),
          blurRadius: 10,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 3),
          blurRadius: 14,
          spreadRadius: 2,
        ),
      ],
      12: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 7),
          blurRadius: 8,
          spreadRadius: -4,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 12),
          blurRadius: 17,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 5),
          blurRadius: 22,
          spreadRadius: 4,
        ),
      ],
      16: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 8),
          blurRadius: 10,
          spreadRadius: -5,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 16),
          blurRadius: 24,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 6),
          blurRadius: 30,
          spreadRadius: 5,
        ),
      ],
      24: [
        BoxShadow(
          color: transparent1,
          offset: const Offset(0, 11),
          blurRadius: 15,
          spreadRadius: -7,
        ),
        BoxShadow(
          color: transparent2,
          offset: const Offset(0, 24),
          blurRadius: 38,
          spreadRadius: 3,
        ),
        BoxShadow(
          color: transparent3,
          offset: const Offset(0, 9),
          blurRadius: 46,
          spreadRadius: 8,
        ),
      ],
    };
  }

  /// Get shadow for specific elevation level
  static List<BoxShadow> getShadow(int elevation, ThemeMode themeMode) {
    final shadows = createShadows(themeMode);
    return shadows[elevation] ?? shadows[0]!; // Return no shadow if elevation not found
  }

  /// Convenience methods for common elevation levels
  static List<BoxShadow> light(int elevation) => getShadow(elevation, ThemeMode.light);
  static List<BoxShadow> dark(int elevation) => getShadow(elevation, ThemeMode.dark);
}

/// Extension on BuildContext for easy shadow access
extension ShadowContext on BuildContext {
  List<BoxShadow> shadows(int elevation) {
    final brightness = Theme.of(this).brightness;
    final themeMode = brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
    return AppShadows.getShadow(elevation, themeMode);
  }
}

/// Custom widget that applies elevation shadows
class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final int elevation;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;

  const ElevatedContainer({
    super.key,
    required this.child,
    this.elevation = 1,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = theme.brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(4.0),
        boxShadow: AppShadows.getShadow(elevation, themeMode),
      ),
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );
  }
}

/// Usage examples:
/// 
/// ```dart
/// // Using the extension method
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: context.shadows(2),
///     borderRadius: BorderRadius.circular(8),
///   ),
///   child: Text('Elevated content'),
/// )
/// 
/// // Using the static method
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: AppShadows.light(4),
///     borderRadius: BorderRadius.circular(8),
///   ),
///   child: Text('Elevated content'),
/// )
/// 
/// // Using the custom widget
/// ElevatedContainer(
///   elevation: 3,
///   borderRadius: BorderRadius.circular(12),
///   padding: EdgeInsets.all(16),
///   child: Text('Easy elevated container'),
/// )
/// ```
