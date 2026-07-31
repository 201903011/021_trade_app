import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum BadgeVariant {
  filled,
  outlined,
  dot,
}

enum BadgeSize {
  small,
  medium,
  large,
}

enum BadgeColor {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  default_,
}

/// A generic, themeable badge component
class CustomBadge extends StatelessWidget {
  /// The content to display inside the badge
  final String? content;

  /// The child widget to anchor the badge to
  final Widget child;

  /// Badge variant (filled, outlined, dot)
  final BadgeVariant variant;

  /// Badge size (small, medium, large)
  final BadgeSize size;

  /// Badge color theme
  final BadgeColor color;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom text color override
  final Color? textColor;

  /// Custom border color override
  final Color? borderColor;

  /// Whether the badge is visible
  final bool visible;

  /// Custom position offset
  final Offset? offset;

  /// Whether to show the badge as a notification indicator
  final bool showZero;

  /// Maximum count to display (shows 99+ if count exceeds)
  final int? maxCount;

  /// Custom padding override
  final EdgeInsetsGeometry? padding;

  /// Custom border radius override
  final BorderRadius? borderRadius;

  /// Whether the badge should be positioned absolutely
  final bool positioned;

  /// Position alignment
  final AlignmentGeometry alignment;

  const CustomBadge({
    super.key,
    this.content,
    required this.child,
    this.variant = BadgeVariant.filled,
    this.size = BadgeSize.medium,
    this.color = BadgeColor.primary,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.visible = true,
    this.offset,
    this.showZero = false,
    this.maxCount,
    this.padding,
    this.borderRadius,
    this.positioned = true,
    this.alignment = Alignment.topRight,
  });

  /// Factory constructor for notification badge
  factory CustomBadge.notification({
    Key? key,
    required Widget child,
    required int count,
    BadgeSize size = BadgeSize.small,
    BadgeColor color = BadgeColor.error,
    Color? backgroundColor,
    Color? textColor,
    bool visible = true,
    bool showZero = false,
    int maxCount = 99,
    Offset? offset,
    AlignmentGeometry alignment = Alignment.topRight,
  }) {
    String displayContent;
    if (count == 0 && !showZero) {
      displayContent = '';
    } else if (count > maxCount) {
      displayContent = '$maxCount+';
    } else {
      displayContent = count.toString();
    }

    return CustomBadge(
      key: key,
      content: displayContent,
      child: child,
      variant: BadgeVariant.filled,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      textColor: textColor,
      visible: visible && (count > 0 || showZero),
      offset: offset,
      alignment: alignment,
    );
  }

  /// Factory constructor for dot badge
  factory CustomBadge.dot({
    Key? key,
    required Widget child,
    BadgeSize size = BadgeSize.small,
    BadgeColor color = BadgeColor.primary,
    Color? backgroundColor,
    bool visible = true,
    Offset? offset,
    AlignmentGeometry alignment = Alignment.topRight,
  }) {
    return CustomBadge(
      key: key,
      child: child,
      variant: BadgeVariant.dot,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      visible: visible,
      offset: offset,
      alignment: alignment,
    );
  }

  /// Factory constructor for status badge
  factory CustomBadge.status({
    Key? key,
    required String label,
    required Widget child,
    BadgeVariant variant = BadgeVariant.filled,
    BadgeSize size = BadgeSize.medium,
    BadgeColor color = BadgeColor.primary,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    bool visible = true,
    Offset? offset,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry alignment = Alignment.topRight,
  }) {
    return CustomBadge(
      key: key,
      content: label,
      child: child,
      variant: variant,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      visible: visible,
      offset: offset,
      padding: padding,
      alignment: alignment,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return child;
    }

    final theme = UseTheme(context);

    // Get size-based dimensions
    final badgePadding = _getBadgePadding();
    final badgeBorderRadius = _getBadgeBorderRadius();
    final fontSize = _getFontSize();
    final minSize = _getMinSize();

    // Get color-based styling
    final badgeBackgroundColor = _getBackgroundColor(theme);
    final badgeTextColor = _getTextColor(theme);
    final badgeBorder = _getBorder(theme);

    Widget badgeWidget;

    if (variant == BadgeVariant.dot) {
      badgeWidget = Container(
        width: minSize,
        height: minSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? badgeBackgroundColor,
          borderRadius: BorderRadius.circular(minSize / 2),
          border: badgeBorder,
        ),
      );
    } else {
      final hasContent = content != null && content!.isNotEmpty;

      badgeWidget = Container(
        constraints: BoxConstraints(
          minWidth: minSize,
          minHeight: minSize,
        ),
        padding: padding ?? badgePadding,
        decoration: BoxDecoration(
          color: backgroundColor ?? badgeBackgroundColor,
          borderRadius: borderRadius ?? badgeBorderRadius,
          border: badgeBorder,
        ),
        child: hasContent
            ? Center(
                child: Text(
                  content!,
                  style: theme.typography.caption.copyWith(
                    fontSize: fontSize,
                    color: textColor ?? badgeTextColor,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : null,
      );
    }

    if (!positioned) {
      return badgeWidget;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned.fill(
          child: Align(
            alignment: alignment,
            child: Transform.translate(
              offset: offset ?? _getDefaultOffset(),
              child: badgeWidget,
            ),
          ),
        ),
      ],
    );
  }

  EdgeInsetsGeometry _getBadgePadding() {
    if (variant == BadgeVariant.dot) {
      return EdgeInsets.zero;
    }

    switch (size) {
      case BadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 4, vertical: 1);
      case BadgeSize.medium:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case BadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 3);
    }
  }

  BorderRadius _getBadgeBorderRadius() {
    switch (size) {
      case BadgeSize.small:
        return BorderRadius.circular(8);
      case BadgeSize.medium:
        return BorderRadius.circular(10);
      case BadgeSize.large:
        return BorderRadius.circular(12);
    }
  }

  double _getFontSize() {
    switch (size) {
      case BadgeSize.small:
        return 10;
      case BadgeSize.medium:
        return 12;
      case BadgeSize.large:
        return 14;
    }
  }

  double _getMinSize() {
    switch (size) {
      case BadgeSize.small:
        return 16;
      case BadgeSize.medium:
        return 20;
      case BadgeSize.large:
        return 24;
    }
  }

  Offset _getDefaultOffset() {
    final offsetValue = _getMinSize() / 2;
    return Offset(offsetValue, -offsetValue);
  }

  Color _getBackgroundColor(UseTheme theme) {
    switch (color) {
      case BadgeColor.primary:
        return theme.primary;
      case BadgeColor.secondary:
        return theme.secondary;
      case BadgeColor.success:
        return theme.success;
      case BadgeColor.warning:
        return theme.warning;
      case BadgeColor.error:
        return theme.error;
      case BadgeColor.info:
        return theme.info;
      case BadgeColor.default_:
        return theme.palette.background.neutral;
    }
  }

  Color _getTextColor(UseTheme theme) {
    switch (color) {
      case BadgeColor.primary:
        return theme.palette.common.primary.contrastText;
      case BadgeColor.secondary:
        return theme.palette.common.secondary.contrastText;
      case BadgeColor.success:
        return theme.palette.common.success.contrastText;
      case BadgeColor.warning:
        return theme.palette.common.warning.contrastText;
      case BadgeColor.error:
        return theme.palette.common.error.contrastText;
      case BadgeColor.info:
        return theme.palette.common.info.contrastText;
      case BadgeColor.default_:
        return theme.palette.text.primary;
    }
  }

  Border? _getBorder(UseTheme theme) {
    switch (variant) {
      case BadgeVariant.outlined:
        return Border.all(
          color: borderColor ?? _getBackgroundColor(theme),
          width: 1,
        );
      case BadgeVariant.filled:
      case BadgeVariant.dot:
        return null;
    }
  }
}
