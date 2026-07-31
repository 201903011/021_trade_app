import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable modal/dialog component
class CustomModal extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool dismissible;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double borderRadius;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const CustomModal({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.dismissible = true,
    this.padding,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.showCloseButton = true,
    this.onClose,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
    bool dismissible = true,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    Color? backgroundColor,
    double borderRadius = 12.0,
    bool showCloseButton = true,
    VoidCallback? onClose,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => CustomModal(
        title: title,
        actions: actions,
        dismissible: dismissible,
        padding: padding,
        width: width,
        height: height,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        showCloseButton: showCloseButton,
        onClose: onClose,
        child: child,
      ),
    );
  }

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
    bool dismissible = true,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    double borderRadius = 12.0,
    bool showCloseButton = true,
    VoidCallback? onClose,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: dismissible,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      builder: (context) => CustomBottomSheet(
        title: title,
        actions: actions,
        padding: padding,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        showCloseButton: showCloseButton,
        onClose: onClose,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: width,
        height: height,
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 800,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? palette.background.paper,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null || showCloseButton) _buildHeader(context, palette),
            Flexible(
              child: Padding(
                padding: padding ?? const EdgeInsets.all(24),
                child: child,
              ),
            ),
            if (actions != null && actions!.isNotEmpty) _buildActions(palette),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic palette) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: palette.common.divider),
        ),
      ),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: palette.text.primary,
                ),
              ),
            ),
          if (showCloseButton)
            IconButton(
              onPressed: () {
                if (onClose != null) {
                  onClose!();
                } else {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.close,
                color: palette.text.secondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActions(dynamic palette) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: palette.common.divider),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!.asMap().entries.map((entry) {
          final index = entry.key;
          final action = entry.value;
          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 8 : 0),
            child: action,
          );
        }).toList(),
      ),
    );
  }
}

/// Bottom sheet variant of the modal
class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.padding,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.showCloseButton = true,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? palette.background.paper,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: palette.common.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          if (title != null || showCloseButton) _buildBottomSheetHeader(context, palette),
          Flexible(
            child: Padding(
              padding: padding ?? const EdgeInsets.all(24),
              child: child,
            ),
          ),
          if (actions != null && actions!.isNotEmpty) _buildActions(palette),
          // Safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context, dynamic palette) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: palette.text.primary,
                ),
              ),
            ),
          if (showCloseButton)
            IconButton(
              onPressed: () {
                if (onClose != null) {
                  onClose!();
                } else {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.close,
                color: palette.text.secondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActions(dynamic palette) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!.asMap().entries.map((entry) {
          final index = entry.key;
          final action = entry.value;
          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 8 : 0),
            child: action,
          );
        }).toList(),
      ),
    );
  }
}
