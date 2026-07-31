import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum CardVariant {
  elevated,
  outlined,
  filled,
}

enum CardSize {
  small,
  medium,
  large,
}

/// A generic, themeable card component
class CustomCard extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;

  /// Card variant (elevated, outlined, filled)
  final CardVariant variant;

  /// Card size (small, medium, large)
  final CardSize size;

  /// Whether the card is clickable
  final VoidCallback? onTap;

  /// Custom padding override
  final EdgeInsetsGeometry? padding;

  /// Custom margin override
  final EdgeInsetsGeometry? margin;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom border radius override
  final BorderRadius? borderRadius;

  /// Custom elevation override
  final double? elevation;

  /// Custom shadow color override
  final Color? shadowColor;

  /// Whether the card should have a hover effect
  final bool enableHover;

  /// Custom width
  final double? width;

  /// Custom height
  final double? height;

  const CustomCard({
    super.key,
    required this.child,
    this.variant = CardVariant.elevated,
    this.size = CardSize.medium,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.enableHover = true,
    this.width,
    this.height,
  });

  /// Factory constructor for elevated card
  factory CustomCard.elevated({
    Key? key,
    required Widget child,
    CardSize size = CardSize.medium,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? elevation,
    Color? shadowColor,
    bool enableHover = true,
    double? width,
    double? height,
  }) {
    return CustomCard(
      key: key,
      variant: CardVariant.elevated,
      size: size,
      onTap: onTap,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      elevation: elevation,
      shadowColor: shadowColor,
      enableHover: enableHover,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Factory constructor for outlined card
  factory CustomCard.outlined({
    Key? key,
    required Widget child,
    CardSize size = CardSize.medium,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool enableHover = true,
    double? width,
    double? height,
  }) {
    return CustomCard(
      key: key,
      variant: CardVariant.outlined,
      size: size,
      onTap: onTap,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      enableHover: enableHover,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Factory constructor for filled card
  factory CustomCard.filled({
    Key? key,
    required Widget child,
    CardSize size = CardSize.medium,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool enableHover = true,
    double? width,
    double? height,
  }) {
    return CustomCard(
      key: key,
      variant: CardVariant.filled,
      size: size,
      onTap: onTap,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      enableHover: enableHover,
      width: width,
      height: height,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);
    final isClickable = onTap != null;

    // Get size-based dimensions
    final cardPadding = _getCardPadding();
    final cardMargin = _getCardMargin();
    final cardBorderRadius = _getBorderRadius();
    final cardElevation = _getElevation();

    // Get variant-based styling
    final cardBackgroundColor = _getBackgroundColor(theme);
    final cardBorder = _getBorder(theme);

    final cardWidget = Container(
      width: width,
      height: height,
      margin: margin ?? cardMargin,
      decoration: BoxDecoration(
        color: backgroundColor ?? cardBackgroundColor,
        borderRadius: borderRadius ?? cardBorderRadius,
        border: cardBorder,
        boxShadow: variant == CardVariant.elevated
            ? [
                BoxShadow(
                  color: shadowColor ?? theme.palette.action.disabled.withOpacity(0.1),
                  blurRadius: cardElevation,
                  offset: Offset(0, cardElevation / 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding ?? cardPadding,
        child: child,
      ),
    );

    if (isClickable) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? cardBorderRadius,
          hoverColor: enableHover ? theme.palette.action.hover.withOpacity(0.04) : null,
          splashColor: theme.palette.action.selected.withOpacity(0.1),
          child: cardWidget,
        ),
      );
    }

    return cardWidget;
  }

  EdgeInsetsGeometry _getCardPadding() {
    switch (size) {
      case CardSize.small:
        return const EdgeInsets.all(12);
      case CardSize.medium:
        return const EdgeInsets.all(16);
      case CardSize.large:
        return const EdgeInsets.all(24);
    }
  }

  EdgeInsetsGeometry _getCardMargin() {
    switch (size) {
      case CardSize.small:
        return const EdgeInsets.all(4);
      case CardSize.medium:
        return const EdgeInsets.all(8);
      case CardSize.large:
        return const EdgeInsets.all(12);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (size) {
      case CardSize.small:
        return BorderRadius.circular(8);
      case CardSize.medium:
        return BorderRadius.circular(12);
      case CardSize.large:
        return BorderRadius.circular(16);
    }
  }

  double _getElevation() {
    if (elevation != null) return elevation!;

    switch (size) {
      case CardSize.small:
        return 2;
      case CardSize.medium:
        return 4;
      case CardSize.large:
        return 8;
    }
  }

  Color _getBackgroundColor(UseTheme theme) {
    switch (variant) {
      case CardVariant.elevated:
      case CardVariant.outlined:
        return theme.palette.background.paper;
      case CardVariant.filled:
        return theme.palette.background.neutral;
    }
  }

  Border? _getBorder(UseTheme theme) {
    switch (variant) {
      case CardVariant.outlined:
        return Border.all(
          color: theme.palette.common.divider,
          width: 1,
        );
      case CardVariant.elevated:
      case CardVariant.filled:
        return null;
    }
  }
}
