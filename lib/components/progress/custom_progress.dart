import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum ProgressVariant {
  linear,
  circular,
  circular_indeterminate,
}

enum ProgressSize {
  small,
  medium,
  large,
}

enum ProgressColor {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
}

/// A generic, themeable progress component
class CustomProgress extends StatelessWidget {
  /// Progress variant (linear, circular, circular_indeterminate)
  final ProgressVariant variant;

  /// Progress size (small, medium, large)
  final ProgressSize size;

  /// Progress color theme
  final ProgressColor color;

  /// Progress value (0.0 to 1.0, null for indeterminate)
  final double? value;

  /// Custom color override
  final Color? backgroundColor;

  /// Custom progress color override
  final Color? valueColor;

  /// Stroke width for circular progress
  final double? strokeWidth;

  /// Custom height for linear progress
  final double? height;

  /// Custom border radius for linear progress
  final BorderRadius? borderRadius;

  /// Label to display with progress
  final String? label;

  /// Whether to show percentage
  final bool showPercentage;

  /// Custom minimum height
  final double? minHeight;

  const CustomProgress({
    super.key,
    this.variant = ProgressVariant.linear,
    this.size = ProgressSize.medium,
    this.color = ProgressColor.primary,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth,
    this.height,
    this.borderRadius,
    this.label,
    this.showPercentage = false,
    this.minHeight,
  });

  /// Factory constructor for linear progress
  factory CustomProgress.linear({
    Key? key,
    ProgressSize size = ProgressSize.medium,
    ProgressColor color = ProgressColor.primary,
    double? value,
    Color? backgroundColor,
    Color? valueColor,
    double? height,
    BorderRadius? borderRadius,
    String? label,
    bool showPercentage = false,
    double? minHeight,
  }) {
    return CustomProgress(
      key: key,
      variant: ProgressVariant.linear,
      size: size,
      color: color,
      value: value,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
      height: height,
      borderRadius: borderRadius,
      label: label,
      showPercentage: showPercentage,
      minHeight: minHeight,
    );
  }

  /// Factory constructor for circular progress
  factory CustomProgress.circular({
    Key? key,
    ProgressSize size = ProgressSize.medium,
    ProgressColor color = ProgressColor.primary,
    double? value,
    Color? backgroundColor,
    Color? valueColor,
    double? strokeWidth,
    String? label,
    bool showPercentage = false,
  }) {
    return CustomProgress(
      key: key,
      variant: ProgressVariant.circular,
      size: size,
      color: color,
      value: value,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
      label: label,
      showPercentage: showPercentage,
    );
  }

  /// Factory constructor for indeterminate circular progress
  factory CustomProgress.circularIndeterminate({
    Key? key,
    ProgressSize size = ProgressSize.medium,
    ProgressColor color = ProgressColor.primary,
    Color? backgroundColor,
    Color? valueColor,
    double? strokeWidth,
    String? label,
  }) {
    return CustomProgress(
      key: key,
      variant: ProgressVariant.circular_indeterminate,
      size: size,
      color: color,
      value: null,
      backgroundColor: backgroundColor,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
      label: label,
      showPercentage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    final progressBackgroundColor = _getBackgroundColor(theme);
    final progressValueColor = _getValueColor(theme);

    Widget progressWidget;

    switch (variant) {
      case ProgressVariant.linear:
        progressWidget = _buildLinearProgress(progressBackgroundColor, progressValueColor);
        break;
      case ProgressVariant.circular:
      case ProgressVariant.circular_indeterminate:
        progressWidget = _buildCircularProgress(progressBackgroundColor, progressValueColor);
        break;
    }

    if (label != null || showPercentage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || showPercentage)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: theme.typography.body2.copyWith(
                        color: theme.palette.text.secondary,
                      ),
                    ),
                  if (showPercentage && value != null)
                    Text(
                      '${(value! * 100).round()}%',
                      style: theme.typography.caption.copyWith(
                        color: theme.palette.text.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          progressWidget,
        ],
      );
    }

    return progressWidget;
  }

  Widget _buildLinearProgress(Color? backgroundColor, Color valueColor) {
    final progressHeight = height ?? _getLinearHeight();
    final progressBorderRadius = borderRadius ?? BorderRadius.circular(progressHeight / 2);

    return Container(
      height: progressHeight,
      constraints: BoxConstraints(
        minHeight: minHeight ?? progressHeight,
      ),
      child: ClipRRect(
        borderRadius: progressBorderRadius,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          minHeight: progressHeight,
        ),
      ),
    );
  }

  Widget _buildCircularProgress(Color? backgroundColor, Color valueColor) {
    final progressSize = _getCircularSize();
    final progressStrokeWidth = strokeWidth ?? _getStrokeWidth();

    Widget progress = SizedBox(
      width: progressSize,
      height: progressSize,
      child: CircularProgressIndicator(
        value: variant == ProgressVariant.circular_indeterminate ? null : value,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
        strokeWidth: progressStrokeWidth,
      ),
    );

    return progress;
  }

  double _getLinearHeight() {
    switch (size) {
      case ProgressSize.small:
        return 4;
      case ProgressSize.medium:
        return 6;
      case ProgressSize.large:
        return 8;
    }
  }

  double _getCircularSize() {
    switch (size) {
      case ProgressSize.small:
        return 24;
      case ProgressSize.medium:
        return 40;
      case ProgressSize.large:
        return 56;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case ProgressSize.small:
        return 2;
      case ProgressSize.medium:
        return 3;
      case ProgressSize.large:
        return 4;
    }
  }

  Color? _getBackgroundColor(UseTheme theme) {
    if (backgroundColor != null) return backgroundColor;
    return theme.palette.action.disabled.withOpacity(0.1);
  }

  Color _getValueColor(UseTheme theme) {
    if (valueColor != null) return valueColor!;

    switch (color) {
      case ProgressColor.primary:
        return theme.primary;
      case ProgressColor.secondary:
        return theme.secondary;
      case ProgressColor.success:
        return theme.success;
      case ProgressColor.warning:
        return theme.warning;
      case ProgressColor.error:
        return theme.error;
      case ProgressColor.info:
        return theme.info;
    }
  }
}
