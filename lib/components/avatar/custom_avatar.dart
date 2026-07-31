import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum AvatarVariant {
  circular,
  rounded,
  square,
}

enum AvatarSize {
  small,
  medium,
  large,
  extraLarge,
}

/// A generic, themeable avatar component
class CustomAvatar extends StatelessWidget {
  /// The image to display in the avatar
  final ImageProvider? image;

  /// The child widget (usually Text for initials)
  final Widget? child;

  /// The background color
  final Color? backgroundColor;

  /// The foreground color (for text/icons)
  final Color? foregroundColor;

  /// Avatar variant (circular, rounded, square)
  final AvatarVariant variant;

  /// Avatar size (small, medium, large, extraLarge)
  final AvatarSize size;

  /// Custom radius override
  final double? radius;

  /// Custom border color
  final Color? borderColor;

  /// Custom border width
  final double borderWidth;

  /// Whether the avatar is clickable
  final VoidCallback? onTap;

  /// Custom placeholder icon when no image or child is provided
  final IconData? placeholderIcon;

  /// Whether to show an online indicator
  final bool showOnlineIndicator;

  /// Online indicator color
  final Color? onlineIndicatorColor;

  /// Custom minimum size
  final double? minRadius;

  /// Custom maximum size
  final double? maxRadius;

  const CustomAvatar({
    super.key,
    this.image,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.variant = AvatarVariant.circular,
    this.size = AvatarSize.medium,
    this.radius,
    this.borderColor,
    this.borderWidth = 0,
    this.onTap,
    this.placeholderIcon,
    this.showOnlineIndicator = false,
    this.onlineIndicatorColor,
    this.minRadius,
    this.maxRadius,
  });

  /// Factory constructor for user avatar with initials
  factory CustomAvatar.initials({
    Key? key,
    required String initials,
    AvatarVariant variant = AvatarVariant.circular,
    AvatarSize size = AvatarSize.medium,
    Color? backgroundColor,
    Color? foregroundColor,
    double? radius,
    Color? borderColor,
    double borderWidth = 0,
    VoidCallback? onTap,
    bool showOnlineIndicator = false,
    Color? onlineIndicatorColor,
  }) {
    return CustomAvatar(
      key: key,
      child: Text(initials),
      variant: variant,
      size: size,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      showOnlineIndicator: showOnlineIndicator,
      onlineIndicatorColor: onlineIndicatorColor,
    );
  }

  /// Factory constructor for avatar with icon
  factory CustomAvatar.icon({
    Key? key,
    required IconData icon,
    AvatarVariant variant = AvatarVariant.circular,
    AvatarSize size = AvatarSize.medium,
    Color? backgroundColor,
    Color? foregroundColor,
    double? radius,
    Color? borderColor,
    double borderWidth = 0,
    VoidCallback? onTap,
    bool showOnlineIndicator = false,
    Color? onlineIndicatorColor,
  }) {
    return CustomAvatar(
      key: key,
      child: Icon(icon),
      variant: variant,
      size: size,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      showOnlineIndicator: showOnlineIndicator,
      onlineIndicatorColor: onlineIndicatorColor,
    );
  }

  /// Factory constructor for network image avatar
  factory CustomAvatar.network({
    Key? key,
    required String imageUrl,
    AvatarVariant variant = AvatarVariant.circular,
    AvatarSize size = AvatarSize.medium,
    Color? backgroundColor,
    Color? foregroundColor,
    double? radius,
    Color? borderColor,
    double borderWidth = 0,
    VoidCallback? onTap,
    IconData? placeholderIcon,
    bool showOnlineIndicator = false,
    Color? onlineIndicatorColor,
  }) {
    return CustomAvatar(
      key: key,
      image: NetworkImage(imageUrl),
      variant: variant,
      size: size,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      placeholderIcon: placeholderIcon,
      showOnlineIndicator: showOnlineIndicator,
      onlineIndicatorColor: onlineIndicatorColor,
    );
  }

  /// Factory constructor for asset image avatar
  factory CustomAvatar.asset({
    Key? key,
    required String assetPath,
    AvatarVariant variant = AvatarVariant.circular,
    AvatarSize size = AvatarSize.medium,
    Color? backgroundColor,
    Color? foregroundColor,
    double? radius,
    Color? borderColor,
    double borderWidth = 0,
    VoidCallback? onTap,
    IconData? placeholderIcon,
    bool showOnlineIndicator = false,
    Color? onlineIndicatorColor,
  }) {
    return CustomAvatar(
      key: key,
      image: AssetImage(assetPath),
      variant: variant,
      size: size,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      placeholderIcon: placeholderIcon,
      showOnlineIndicator: showOnlineIndicator,
      onlineIndicatorColor: onlineIndicatorColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);
    final isClickable = onTap != null;

    // Get size-based dimensions
    final avatarRadius = _getAvatarRadius();
    final avatarBackgroundColor = _getBackgroundColor(theme);
    final avatarForegroundColor = _getForegroundColor(theme);

    // Build the avatar content
    Widget avatarChild;
    if (image != null) {
      avatarChild = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image!,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (child != null) {
      avatarChild = Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: foregroundColor ?? avatarForegroundColor,
            size: _getIconSize(),
          ),
        ),
        child: DefaultTextStyle(
          style: theme.typography.subtitle1.copyWith(
            color: foregroundColor ?? avatarForegroundColor,
            fontSize: _getFontSize(),
            fontWeight: FontWeight.w600,
          ),
          child: child!,
        ),
      );
    } else {
      // Default placeholder
      avatarChild = Icon(
        placeholderIcon ?? Icons.person,
        color: foregroundColor ?? avatarForegroundColor,
        size: _getIconSize(),
      );
    }

    // Build the avatar container
    Widget avatar = Container(
      width: avatarRadius * 2,
      height: avatarRadius * 2,
      decoration: BoxDecoration(
        color: backgroundColor ?? avatarBackgroundColor,
        borderRadius: _getBorderRadius(avatarRadius),
        border: borderWidth > 0
            ? Border.all(
                color: borderColor ?? theme.palette.common.divider,
                width: borderWidth,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: _getBorderRadius(avatarRadius),
        child: avatarChild,
      ),
    );

    // Add online indicator if needed
    if (showOnlineIndicator) {
      final indicatorSize = avatarRadius * 0.3;
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: indicatorSize,
              height: indicatorSize,
              decoration: BoxDecoration(
                color: onlineIndicatorColor ?? theme.success,
                borderRadius: _getBorderRadius(indicatorSize / 2),
                border: Border.all(
                  color: theme.palette.background.paper,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Make clickable if needed
    if (isClickable) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: _getBorderRadius(avatarRadius),
          child: avatar,
        ),
      );
    }

    return avatar;
  }

  double _getAvatarRadius() {
    if (radius != null) return radius!;

    switch (size) {
      case AvatarSize.small:
        return 16;
      case AvatarSize.medium:
        return 24;
      case AvatarSize.large:
        return 32;
      case AvatarSize.extraLarge:
        return 48;
    }
  }

  double _getFontSize() {
    switch (size) {
      case AvatarSize.small:
        return 12;
      case AvatarSize.medium:
        return 16;
      case AvatarSize.large:
        return 20;
      case AvatarSize.extraLarge:
        return 28;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AvatarSize.small:
        return 16;
      case AvatarSize.medium:
        return 20;
      case AvatarSize.large:
        return 24;
      case AvatarSize.extraLarge:
        return 32;
    }
  }

  BorderRadius _getBorderRadius(double radius) {
    switch (variant) {
      case AvatarVariant.circular:
        return BorderRadius.circular(radius);
      case AvatarVariant.rounded:
        return BorderRadius.circular(radius * 0.25);
      case AvatarVariant.square:
        return BorderRadius.zero;
    }
  }

  Color _getBackgroundColor(UseTheme theme) {
    switch (variant) {
      case AvatarVariant.circular:
      case AvatarVariant.rounded:
        return theme.palette.background.neutral;
      case AvatarVariant.square:
        return theme.palette.background.paper;
    }
  }

  Color _getForegroundColor(UseTheme theme) {
    return theme.palette.text.primary;
  }
}
