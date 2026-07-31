import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum ChipVariant {
  filled,
  outlined,
  elevated,
}

enum ChipSize {
  small,
  medium,
  large,
}

/// A generic, themeable chip component
class CustomChip extends StatelessWidget {
  /// The label text
  final String label;

  /// Chip variant (filled, outlined, elevated)
  final ChipVariant variant;

  /// Chip size (small, medium, large)
  final ChipSize size;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom text color override
  final Color? textColor;

  /// Custom border color override (for outlined variant)
  final Color? borderColor;

  /// Whether the chip is selected
  final bool selected;

  /// Callback when chip is tapped
  final VoidCallback? onTap;

  /// Callback when chip is deleted (shows delete icon)
  final VoidCallback? onDeleted;

  /// Custom avatar/icon widget
  final Widget? avatar;

  /// Custom delete icon
  final IconData? deleteIcon;

  /// Whether the chip is disabled
  final bool disabled;

  /// Custom padding override
  final EdgeInsetsGeometry? padding;

  /// Custom margin override
  final EdgeInsetsGeometry? margin;

  /// Custom border radius override
  final BorderRadius? borderRadius;

  /// Custom elevation override (for elevated variant)
  final double? elevation;

  const CustomChip({
    super.key,
    required this.label,
    this.variant = ChipVariant.filled,
    this.size = ChipSize.medium,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.selected = false,
    this.onTap,
    this.onDeleted,
    this.avatar,
    this.deleteIcon,
    this.disabled = false,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
  });

  /// Factory constructor for filter chip
  factory CustomChip.filter({
    Key? key,
    required String label,
    bool selected = false,
    VoidCallback? onTap,
    ChipSize size = ChipSize.medium,
    Color? backgroundColor,
    Color? textColor,
    Widget? avatar,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    return CustomChip(
      key: key,
      label: label,
      variant: ChipVariant.outlined,
      size: size,
      backgroundColor: backgroundColor,
      textColor: textColor,
      selected: selected,
      onTap: onTap,
      avatar: avatar,
      disabled: disabled,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
    );
  }

  /// Factory constructor for choice chip
  factory CustomChip.choice({
    Key? key,
    required String label,
    bool selected = false,
    VoidCallback? onTap,
    ChipSize size = ChipSize.medium,
    Color? backgroundColor,
    Color? textColor,
    Widget? avatar,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    return CustomChip(
      key: key,
      label: label,
      variant: ChipVariant.filled,
      size: size,
      backgroundColor: backgroundColor,
      textColor: textColor,
      selected: selected,
      onTap: onTap,
      avatar: avatar,
      disabled: disabled,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
    );
  }

  /// Factory constructor for action chip
  factory CustomChip.action({
    Key? key,
    required String label,
    VoidCallback? onTap,
    ChipSize size = ChipSize.medium,
    Color? backgroundColor,
    Color? textColor,
    Widget? avatar,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    return CustomChip(
      key: key,
      label: label,
      variant: ChipVariant.elevated,
      size: size,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onTap: onTap,
      avatar: avatar,
      disabled: disabled,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
    );
  }

  /// Factory constructor for input chip (with delete functionality)
  factory CustomChip.input({
    Key? key,
    required String label,
    VoidCallback? onDeleted,
    ChipSize size = ChipSize.medium,
    Color? backgroundColor,
    Color? textColor,
    Widget? avatar,
    IconData? deleteIcon,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    return CustomChip(
      key: key,
      label: label,
      variant: ChipVariant.filled,
      size: size,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onDeleted: onDeleted,
      avatar: avatar,
      deleteIcon: deleteIcon,
      disabled: disabled,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);
    final isClickable = onTap != null;
    final isDeletable = onDeleted != null;

    // Get size-based dimensions
    final chipPadding = _getChipPadding();
    final chipMargin = _getChipMargin();
    final chipBorderRadius = _getChipBorderRadius();
    final chipElevation = _getChipElevation();
    final fontSize = _getFontSize();
    final iconSize = _getIconSize();

    // Get variant and state-based styling
    final chipBackgroundColor = _getBackgroundColor(theme);
    final chipTextColor = _getTextColor(theme);
    final chipBorder = _getBorder(theme);

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (avatar != null) ...[
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: avatar,
          ),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: theme.typography.body2.copyWith(
            fontSize: fontSize,
            color: textColor ?? chipTextColor,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        if (isDeletable) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: disabled ? null : onDeleted,
            child: Icon(
              deleteIcon ?? Icons.close,
              size: iconSize,
              color: disabled ? theme.palette.action.disabled : textColor ?? chipTextColor,
            ),
          ),
        ],
      ],
    );

    final chipWidget = Container(
      margin: margin ?? chipMargin,
      padding: padding ?? chipPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? chipBackgroundColor,
        borderRadius: borderRadius ?? chipBorderRadius,
        border: chipBorder,
        boxShadow: variant == ChipVariant.elevated
            ? [
                BoxShadow(
                  color: theme.palette.action.disabled.withOpacity(0.1),
                  blurRadius: chipElevation,
                  offset: Offset(0, chipElevation / 2),
                ),
              ]
            : null,
      ),
      child: content,
    );

    if (isClickable && !disabled) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? chipBorderRadius,
          hoverColor: theme.palette.action.hover.withOpacity(0.04),
          splashColor: theme.palette.action.selected.withOpacity(0.1),
          child: chipWidget,
        ),
      );
    }

    return chipWidget;
  }

  EdgeInsetsGeometry _getChipPadding() {
    switch (size) {
      case ChipSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case ChipSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ChipSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  EdgeInsetsGeometry _getChipMargin() {
    switch (size) {
      case ChipSize.small:
        return const EdgeInsets.all(2);
      case ChipSize.medium:
        return const EdgeInsets.all(4);
      case ChipSize.large:
        return const EdgeInsets.all(6);
    }
  }

  BorderRadius _getChipBorderRadius() {
    switch (size) {
      case ChipSize.small:
        return BorderRadius.circular(12);
      case ChipSize.medium:
        return BorderRadius.circular(16);
      case ChipSize.large:
        return BorderRadius.circular(20);
    }
  }

  double _getChipElevation() {
    if (elevation != null) return elevation!;

    switch (size) {
      case ChipSize.small:
        return 1;
      case ChipSize.medium:
        return 2;
      case ChipSize.large:
        return 4;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ChipSize.small:
        return 12;
      case ChipSize.medium:
        return 14;
      case ChipSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ChipSize.small:
        return 16;
      case ChipSize.medium:
        return 18;
      case ChipSize.large:
        return 20;
    }
  }

  Color _getBackgroundColor(UseTheme theme) {
    if (disabled) {
      return theme.palette.action.disabledBackground;
    }

    switch (variant) {
      case ChipVariant.filled:
        if (selected) {
          return theme.primary;
        }
        return theme.palette.background.neutral;
      case ChipVariant.outlined:
        if (selected) {
          return theme.primary.withOpacity(0.08);
        }
        return Colors.transparent;
      case ChipVariant.elevated:
        return theme.palette.background.paper;
    }
  }

  Color _getTextColor(UseTheme theme) {
    if (disabled) {
      return theme.palette.text.disabled;
    }

    switch (variant) {
      case ChipVariant.filled:
        if (selected) {
          return theme.palette.common.primary.contrastText;
        }
        return theme.palette.text.primary;
      case ChipVariant.outlined:
        if (selected) {
          return theme.primary;
        }
        return theme.palette.text.primary;
      case ChipVariant.elevated:
        return theme.palette.text.primary;
    }
  }

  Border? _getBorder(UseTheme theme) {
    switch (variant) {
      case ChipVariant.outlined:
        return Border.all(
          color: disabled
              ? theme.palette.action.disabled
              : selected
                  ? theme.primary
                  : borderColor ?? theme.palette.common.divider,
          width: selected ? 2 : 1,
        );
      case ChipVariant.filled:
      case ChipVariant.elevated:
        return null;
    }
  }
}
