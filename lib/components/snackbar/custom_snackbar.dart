import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable snackbar component
class CustomSnackbar extends StatelessWidget {
  final String message;
  final SnackbarType type;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Duration? duration;
  final SnackbarPosition position;
  final IconData? icon;
  final bool showCloseButton;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const CustomSnackbar({
    super.key,
    required this.message,
    this.type = SnackbarType.info,
    this.actionLabel,
    this.onActionPressed,
    this.duration,
    this.position = SnackbarPosition.bottom,
    this.icon,
    this.showCloseButton = false,
    this.backgroundColor,
    this.textColor,
    this.margin,
    this.borderRadius = 8.0,
  });

  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 4),
    SnackbarPosition position = SnackbarPosition.bottom,
    IconData? icon,
    bool showCloseButton = false,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? margin,
    double borderRadius = 8.0,
  }) {
    final snackbar = CustomSnackbar(
      message: message,
      type: type,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      duration: duration,
      position: position,
      icon: icon,
      showCloseButton: showCloseButton,
      backgroundColor: backgroundColor,
      textColor: textColor,
      margin: margin,
      borderRadius: borderRadius,
    );

    // Remove any existing snackbars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show the new snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      snackbar._buildSnackBar(context),
    );
  }

  static void success({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.success,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 6),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.error,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.warning,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  static void info({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.info,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  SnackBar _buildSnackBar(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    final colors = _getTypeColors(palette);
    final snackbarIcon = icon ?? _getTypeIcon();

    return SnackBar(
      content: Row(
        children: [
          if (snackbarIcon != null) ...[
            Icon(
              snackbarIcon,
              color: colors.iconColor,
              size: 20,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? colors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (showCloseButton)
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              icon: Icon(
                Icons.close,
                color: colors.iconColor,
                size: 18,
              ),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
      backgroundColor: backgroundColor ?? colors.backgroundColor,
      duration: duration ?? const Duration(seconds: 4),
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      behavior: position == SnackbarPosition.top ? SnackBarBehavior.floating : SnackBarBehavior.floating,
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel!,
              onPressed: onActionPressed!,
              textColor: colors.actionColor,
            )
          : null,
    );
  }

  _SnackbarColors _getTypeColors(dynamic palette) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarColors(
          backgroundColor: palette.common.success.main,
          textColor: Colors.white,
          iconColor: Colors.white,
          actionColor: Colors.white,
        );
      case SnackbarType.error:
        return _SnackbarColors(
          backgroundColor: palette.common.error.main,
          textColor: Colors.white,
          iconColor: Colors.white,
          actionColor: Colors.white,
        );
      case SnackbarType.warning:
        return _SnackbarColors(
          backgroundColor: palette.common.warning.main,
          textColor: Colors.white,
          iconColor: Colors.white,
          actionColor: Colors.white,
        );
      case SnackbarType.info:
        return _SnackbarColors(
          backgroundColor: palette.common.info.main,
          textColor: Colors.white,
          iconColor: Colors.white,
          actionColor: Colors.white,
        );
    }
  }

  IconData? _getTypeIcon() {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_outline;
      case SnackbarType.error:
        return Icons.error_outline;
      case SnackbarType.warning:
        return Icons.warning_amber_outlined;
      case SnackbarType.info:
        return Icons.info_outline;
    }
  }
}

/// Helper class for snackbar colors
class _SnackbarColors {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color actionColor;

  const _SnackbarColors({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.actionColor,
  });
}

/// Snackbar type enumeration
enum SnackbarType {
  success,
  error,
  warning,
  info,
}

/// Snackbar position enumeration
enum SnackbarPosition {
  top,
  bottom,
}
