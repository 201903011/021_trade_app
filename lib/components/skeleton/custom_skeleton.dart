import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum SkeletonVariant {
  text,
  circular,
  rectangular,
  rounded,
}

enum SkeletonAnimation {
  pulse,
  wave,
  none,
}

/// A generic, themeable skeleton loader component
class CustomSkeleton extends StatefulWidget {
  /// Skeleton variant (text, circular, rectangular, rounded)
  final SkeletonVariant variant;

  /// Animation type (pulse, wave, none)
  final SkeletonAnimation animation;

  /// Width of the skeleton
  final double? width;

  /// Height of the skeleton
  final double? height;

  /// Custom border radius
  final BorderRadius? borderRadius;

  /// Custom base color
  final Color? baseColor;

  /// Custom highlight color
  final Color? highlightColor;

  /// Animation duration
  final Duration duration;

  /// Number of lines for text variant
  final int lines;

  /// Spacing between lines for text variant
  final double lineSpacing;

  const CustomSkeleton({
    super.key,
    this.variant = SkeletonVariant.rectangular,
    this.animation = SkeletonAnimation.pulse,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1000),
    this.lines = 1,
    this.lineSpacing = 8,
  });

  /// Factory constructor for text skeleton
  factory CustomSkeleton.text({
    Key? key,
    int lines = 3,
    double lineSpacing = 8,
    double? width,
    double height = 16,
    SkeletonAnimation animation = SkeletonAnimation.pulse,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return CustomSkeleton(
      key: key,
      variant: SkeletonVariant.text,
      animation: animation,
      width: width,
      height: height,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      lines: lines,
      lineSpacing: lineSpacing,
    );
  }

  /// Factory constructor for circular skeleton (avatars)
  factory CustomSkeleton.circular({
    Key? key,
    required double size,
    SkeletonAnimation animation = SkeletonAnimation.pulse,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return CustomSkeleton(
      key: key,
      variant: SkeletonVariant.circular,
      animation: animation,
      width: size,
      height: size,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
    );
  }

  /// Factory constructor for rectangular skeleton
  factory CustomSkeleton.rectangular({
    Key? key,
    double? width,
    double? height,
    SkeletonAnimation animation = SkeletonAnimation.pulse,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return CustomSkeleton(
      key: key,
      variant: SkeletonVariant.rectangular,
      animation: animation,
      width: width,
      height: height,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
    );
  }

  /// Factory constructor for rounded skeleton
  factory CustomSkeleton.rounded({
    Key? key,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    SkeletonAnimation animation = SkeletonAnimation.pulse,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return CustomSkeleton(
      key: key,
      variant: SkeletonVariant.rounded,
      animation: animation,
      width: width,
      height: height,
      borderRadius: borderRadius,
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
    );
  }

  @override
  State<CustomSkeleton> createState() => _CustomSkeletonState();
}

class _CustomSkeletonState extends State<CustomSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    if (widget.animation != SkeletonAnimation.none) {
      _animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _animationController.repeat(reverse: true);
    } else {
      _animation = AlwaysStoppedAnimation(0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    final skeletonBaseColor = widget.baseColor ?? (theme.isDark ? Colors.grey[700]! : Colors.grey[300]!);
    final skeletonHighlightColor = widget.highlightColor ?? (theme.isDark ? Colors.grey[600]! : Colors.grey[100]!);

    if (widget.variant == SkeletonVariant.text) {
      return _buildTextSkeleton(skeletonBaseColor, skeletonHighlightColor);
    }

    return _buildSingleSkeleton(skeletonBaseColor, skeletonHighlightColor);
  }

  Widget _buildTextSkeleton(Color baseColor, Color highlightColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.lines, (index) {
        final isLast = index == widget.lines - 1;
        final lineWidth = widget.width ?? (isLast ? (MediaQuery.of(context).size.width * 0.6) : double.infinity);

        return Container(
          margin: EdgeInsets.only(
            bottom: isLast ? 0 : widget.lineSpacing,
          ),
          child: _buildSingleSkeleton(
            baseColor,
            highlightColor,
            width: lineWidth,
            height: widget.height ?? 16,
          ),
        );
      }),
    );
  }

  Widget _buildSingleSkeleton(
    Color baseColor,
    Color highlightColor, {
    double? width,
    double? height,
  }) {
    final skeletonWidth = width ?? widget.width;
    final skeletonHeight = height ?? widget.height;
    final skeletonBorderRadius = _getBorderRadius();

    Widget skeleton = Container(
      width: skeletonWidth,
      height: skeletonHeight,
      decoration: BoxDecoration(
        borderRadius: skeletonBorderRadius,
        color: baseColor,
      ),
    );

    if (widget.animation == SkeletonAnimation.none) {
      return skeleton;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        Color currentColor;

        switch (widget.animation) {
          case SkeletonAnimation.pulse:
            currentColor = Color.lerp(baseColor, highlightColor, _animation.value)!;
            break;
          case SkeletonAnimation.wave:
            // For wave animation, we'd need a more complex gradient implementation
            currentColor = Color.lerp(baseColor, highlightColor, _animation.value)!;
            break;
          case SkeletonAnimation.none:
            currentColor = baseColor;
            break;
        }

        return Container(
          width: skeletonWidth,
          height: skeletonHeight,
          decoration: BoxDecoration(
            borderRadius: skeletonBorderRadius,
            color: currentColor,
          ),
        );
      },
    );
  }

  BorderRadius? _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius;

    switch (widget.variant) {
      case SkeletonVariant.circular:
        final size = widget.width ?? widget.height ?? 40;
        return BorderRadius.circular(size / 2);
      case SkeletonVariant.rounded:
        return BorderRadius.circular(8);
      case SkeletonVariant.text:
        return BorderRadius.circular(4);
      case SkeletonVariant.rectangular:
        return null;
    }
  }
}
