import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum AlertVariant {
  filled,
  outlined,
  standard,
}

enum AlertSeverity {
  success,
  info,
  warning,
  error,
}

enum AlertSize {
  small,
  medium,
  large,
}

/// A generic, themeable alert component
class CustomAlert extends StatelessWidget {
  /// Alert severity (success, info, warning, error)
  final AlertSeverity severity;

  /// Alert variant (filled, outlined, standard)
  final AlertVariant variant;

  /// Alert size (small, medium, large)
  final AlertSize size;

  /// Alert title
  final String? title;

  /// Alert message
  final String message;

  /// Whether the alert can be dismissed
  final bool dismissible;

  /// Callback when alert is dismissed
  final VoidCallback? onDismiss;

  /// Custom icon override
  final IconData? icon;

  /// Whether to show the default icon
  final bool showIcon;

  /// Custom actions to display
  final List<Widget>? actions;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom text color override
  final Color? textColor;

  /// Custom border color override
  final Color? borderColor;

  /// Custom padding override
  final EdgeInsetsGeometry? padding;

  /// Custom margin override
  final EdgeInsetsGeometry? margin;

  /// Custom border radius override
  final BorderRadius? borderRadius;

  /// Whether the alert should expand to fill width
  final bool fullWidth;

  const CustomAlert({
    super.key,
    required this.severity,
    required this.message,
    this.variant = AlertVariant.filled,
    this.size = AlertSize.medium,
    this.title,
    this.dismissible = false,
    this.onDismiss,
    this.icon,
    this.showIcon = true,
    this.actions,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.fullWidth = true,
  });

  /// Factory constructor for success alert
  factory CustomAlert.success({
    Key? key,
    required String message,
    String? title,
    AlertVariant variant = AlertVariant.filled,
    AlertSize size = AlertSize.medium,
    bool dismissible = false,
    VoidCallback? onDismiss,
    IconData? icon,
    bool showIcon = true,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    bool fullWidth = true,
  }) {
    return CustomAlert(
      key: key,
      severity: AlertSeverity.success,
      message: message,
      title: title,
      variant: variant,
      size: size,
      dismissible: dismissible,
      onDismiss: onDismiss,
      icon: icon,
      showIcon: showIcon,
      actions: actions,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      fullWidth: fullWidth,
    );
  }

  /// Factory constructor for error alert
  factory CustomAlert.error({
    Key? key,
    required String message,
    String? title,
    AlertVariant variant = AlertVariant.filled,
    AlertSize size = AlertSize.medium,
    bool dismissible = true,
    VoidCallback? onDismiss,
    IconData? icon,
    bool showIcon = true,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    bool fullWidth = true,
  }) {
    return CustomAlert(
      key: key,
      severity: AlertSeverity.error,
      message: message,
      title: title,
      variant: variant,
      size: size,
      dismissible: dismissible,
      onDismiss: onDismiss,
      icon: icon,
      showIcon: showIcon,
      actions: actions,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      fullWidth: fullWidth,
    );
  }

  /// Factory constructor for warning alert
  factory CustomAlert.warning({
    Key? key,
    required String message,
    String? title,
    AlertVariant variant = AlertVariant.filled,
    AlertSize size = AlertSize.medium,
    bool dismissible = false,
    VoidCallback? onDismiss,
    IconData? icon,
    bool showIcon = true,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    bool fullWidth = true,
  }) {
    return CustomAlert(
      key: key,
      severity: AlertSeverity.warning,
      message: message,
      title: title,
      variant: variant,
      size: size,
      dismissible: dismissible,
      onDismiss: onDismiss,
      icon: icon,
      showIcon: showIcon,
      actions: actions,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      fullWidth: fullWidth,
    );
  }

  /// Factory constructor for info alert
  factory CustomAlert.info({
    Key? key,
    required String message,
    String? title,
    AlertVariant variant = AlertVariant.filled,
    AlertSize size = AlertSize.medium,
    bool dismissible = false,
    VoidCallback? onDismiss,
    IconData? icon,
    bool showIcon = true,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    bool fullWidth = true,
  }) {
    return CustomAlert(
      key: key,
      severity: AlertSeverity.info,
      message: message,
      title: title,
      variant: variant,
      size: size,
      dismissible: dismissible,
      onDismiss: onDismiss,
      icon: icon,
      showIcon: showIcon,
      actions: actions,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      fullWidth: fullWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    // Get theme-based colors
    final alertBackgroundColor = _getBackgroundColor(theme);
    final alertTextColor = _getTextColor(theme);
    final alertBorderColor = _getBorderColor(theme);
    final alertBorder = _getBorder(alertBorderColor);

    // Get size-based styling
    final alertPadding = _getAlertPadding();
    final alertMargin = _getAlertMargin();
    final alertBorderRadius = _getBorderRadius();
    final iconSize = _getIconSize();
    final titleStyle = _getTitleStyle(theme);
    final messageStyle = _getMessageStyle(theme);

    final alertIcon = _getIcon();

    return Container(
      width: fullWidth ? double.infinity : null,
      margin: margin ?? alertMargin,
      padding: padding ?? alertPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? alertBackgroundColor,
        borderRadius: borderRadius ?? alertBorderRadius,
        border: alertBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          if (showIcon) ...[
            Icon(
              icon ?? alertIcon,
              size: iconSize,
              color: textColor ?? alertTextColor,
            ),
            const SizedBox(width: 12),
          ],

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: titleStyle.copyWith(
                      color: textColor ?? alertTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  message,
                  style: messageStyle.copyWith(
                    color: textColor ?? alertTextColor,
                  ),
                ),
                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: actions!,
                  ),
                ],
              ],
            ),
          ),

          // Dismiss button
          if (dismissible) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDismiss,
              icon: Icon(
                Icons.close,
                size: iconSize,
                color: (textColor ?? alertTextColor).withOpacity(0.7),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ],
      ),
    );
  }

  EdgeInsetsGeometry _getAlertPadding() {
    switch (size) {
      case AlertSize.small:
        return const EdgeInsets.all(12);
      case AlertSize.medium:
        return const EdgeInsets.all(16);
      case AlertSize.large:
        return const EdgeInsets.all(20);
    }
  }

  EdgeInsetsGeometry _getAlertMargin() {
    switch (size) {
      case AlertSize.small:
        return const EdgeInsets.symmetric(vertical: 4);
      case AlertSize.medium:
        return const EdgeInsets.symmetric(vertical: 8);
      case AlertSize.large:
        return const EdgeInsets.symmetric(vertical: 12);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (size) {
      case AlertSize.small:
        return BorderRadius.circular(6);
      case AlertSize.medium:
        return BorderRadius.circular(8);
      case AlertSize.large:
        return BorderRadius.circular(12);
    }
  }

  double _getIconSize() {
    switch (size) {
      case AlertSize.small:
        return 18;
      case AlertSize.medium:
        return 20;
      case AlertSize.large:
        return 24;
    }
  }

  TextStyle _getTitleStyle(UseTheme theme) {
    switch (size) {
      case AlertSize.small:
        return theme.typography.subtitle2.copyWith(fontWeight: FontWeight.w600);
      case AlertSize.medium:
        return theme.typography.subtitle1.copyWith(fontWeight: FontWeight.w600);
      case AlertSize.large:
        return theme.typography.h6.copyWith(fontWeight: FontWeight.w600);
    }
  }

  TextStyle _getMessageStyle(UseTheme theme) {
    switch (size) {
      case AlertSize.small:
        return theme.typography.caption;
      case AlertSize.medium:
        return theme.typography.body2;
      case AlertSize.large:
        return theme.typography.body1;
    }
  }

  IconData _getIcon() {
    switch (severity) {
      case AlertSeverity.success:
        return Icons.check_circle_outline;
      case AlertSeverity.info:
        return Icons.info_outline;
      case AlertSeverity.warning:
        return Icons.warning_amber_outlined;
      case AlertSeverity.error:
        return Icons.error_outline;
    }
  }

  Color _getBackgroundColor(UseTheme theme) {
    switch (variant) {
      case AlertVariant.filled:
        return _getSeverityColor(theme).withOpacity(0.1);
      case AlertVariant.outlined:
      case AlertVariant.standard:
        return Colors.transparent;
    }
  }

  Color _getTextColor(UseTheme theme) {
    switch (variant) {
      case AlertVariant.filled:
      case AlertVariant.outlined:
      case AlertVariant.standard:
        return _getSeverityColor(theme);
    }
  }

  Color _getBorderColor(UseTheme theme) {
    return _getSeverityColor(theme);
  }

  Border? _getBorder(Color borderColor) {
    switch (variant) {
      case AlertVariant.outlined:
        return Border.all(color: borderColor, width: 1);
      case AlertVariant.standard:
        return Border(left: BorderSide(color: borderColor, width: 4));
      case AlertVariant.filled:
        return null;
    }
  }

  Color _getSeverityColor(UseTheme theme) {
    switch (severity) {
      case AlertSeverity.success:
        return theme.success;
      case AlertSeverity.info:
        return theme.info;
      case AlertSeverity.warning:
        return theme.warning;
      case AlertSeverity.error:
        return theme.error;
    }
  }
}
