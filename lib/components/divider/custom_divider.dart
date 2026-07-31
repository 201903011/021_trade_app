import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum DividerVariant {
  horizontal,
  vertical,
  dashed,
}

enum DividerThickness {
  thin,
  medium,
  thick,
}

/// A generic, themeable divider component
class CustomDivider extends StatelessWidget {
  /// Divider variant (horizontal, vertical, dashed)
  final DividerVariant variant;

  /// Divider thickness (thin, medium, thick)
  final DividerThickness thickness;

  /// Custom color override
  final Color? color;

  /// Custom thickness override
  final double? customThickness;

  /// Indent from the start
  final double indent;

  /// Indent from the end
  final double endIndent;

  /// Height for horizontal dividers / width for vertical dividers
  final double? height;

  /// Custom margin
  final EdgeInsetsGeometry? margin;

  /// Dash length (for dashed variant)
  final double dashLength;

  /// Dash gap (for dashed variant)
  final double dashGap;

  const CustomDivider({
    super.key,
    this.variant = DividerVariant.horizontal,
    this.thickness = DividerThickness.thin,
    this.color,
    this.customThickness,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
    this.margin,
    this.dashLength = 4,
    this.dashGap = 2,
  });

  /// Factory constructor for horizontal divider
  factory CustomDivider.horizontal({
    Key? key,
    DividerThickness thickness = DividerThickness.thin,
    Color? color,
    double? customThickness,
    double indent = 0,
    double endIndent = 0,
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return CustomDivider(
      key: key,
      variant: DividerVariant.horizontal,
      thickness: thickness,
      color: color,
      customThickness: customThickness,
      indent: indent,
      endIndent: endIndent,
      height: height,
      margin: margin,
    );
  }

  /// Factory constructor for vertical divider
  factory CustomDivider.vertical({
    Key? key,
    DividerThickness thickness = DividerThickness.thin,
    Color? color,
    double? customThickness,
    double indent = 0,
    double endIndent = 0,
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return CustomDivider(
      key: key,
      variant: DividerVariant.vertical,
      thickness: thickness,
      color: color,
      customThickness: customThickness,
      indent: indent,
      endIndent: endIndent,
      height: height,
      margin: margin,
    );
  }

  /// Factory constructor for dashed divider
  factory CustomDivider.dashed({
    Key? key,
    DividerVariant variant = DividerVariant.horizontal,
    DividerThickness thickness = DividerThickness.thin,
    Color? color,
    double? customThickness,
    double indent = 0,
    double endIndent = 0,
    double? height,
    EdgeInsetsGeometry? margin,
    double dashLength = 4,
    double dashGap = 2,
  }) {
    return CustomDivider(
      key: key,
      variant: DividerVariant.dashed,
      thickness: thickness,
      color: color,
      customThickness: customThickness,
      indent: indent,
      endIndent: endIndent,
      height: height,
      margin: margin,
      dashLength: dashLength,
      dashGap: dashGap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    final dividerColor = color ?? theme.palette.common.divider;
    final dividerThickness = _getThickness();
    final dividerHeight = height ?? _getDefaultHeight();

    Widget dividerWidget;

    if (variant == DividerVariant.dashed) {
      dividerWidget = _buildDashedDivider(dividerColor, dividerThickness, dividerHeight);
    } else if (variant == DividerVariant.vertical) {
      dividerWidget = VerticalDivider(
        color: dividerColor,
        thickness: dividerThickness,
        width: dividerHeight,
        indent: indent,
        endIndent: endIndent,
      );
    } else {
      dividerWidget = Divider(
        color: dividerColor,
        thickness: dividerThickness,
        height: dividerHeight,
        indent: indent,
        endIndent: endIndent,
      );
    }

    if (margin != null) {
      return Container(
        margin: margin,
        child: dividerWidget,
      );
    }

    return dividerWidget;
  }

  double _getThickness() {
    if (customThickness != null) return customThickness!;

    switch (thickness) {
      case DividerThickness.thin:
        return 1;
      case DividerThickness.medium:
        return 2;
      case DividerThickness.thick:
        return 4;
    }
  }

  double _getDefaultHeight() {
    switch (thickness) {
      case DividerThickness.thin:
        return 1;
      case DividerThickness.medium:
        return 16;
      case DividerThickness.thick:
        return 24;
    }
  }

  Widget _buildDashedDivider(Color color, double thickness, double height) {
    return SizedBox(
      height: variant == DividerVariant.horizontal ? height : null,
      width: variant == DividerVariant.vertical ? height : null,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color,
          thickness: thickness,
          dashLength: dashLength,
          dashGap: dashGap,
          isVertical: variant == DividerVariant.vertical,
          indent: indent,
          endIndent: endIndent,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dashLength;
  final double dashGap;
  final bool isVertical;
  final double indent;
  final double endIndent;

  _DashedLinePainter({
    required this.color,
    required this.thickness,
    required this.dashLength,
    required this.dashGap,
    required this.isVertical,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final dashPattern = dashLength + dashGap;

    if (isVertical) {
      final startY = indent;
      final endY = size.height - endIndent;
      final x = size.width / 2;

      for (double y = startY; y < endY; y += dashPattern) {
        final dashEnd = (y + dashLength).clamp(startY, endY);
        canvas.drawLine(
          Offset(x, y),
          Offset(x, dashEnd),
          paint,
        );
      }
    } else {
      final startX = indent;
      final endX = size.width - endIndent;
      final y = size.height / 2;

      for (double x = startX; x < endX; x += dashPattern) {
        final dashEnd = (x + dashLength).clamp(startX, endX);
        canvas.drawLine(
          Offset(x, y),
          Offset(dashEnd, y),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    return other is _DashedLinePainter &&
        other.color == color &&
        other.thickness == thickness &&
        other.dashLength == dashLength &&
        other.dashGap == dashGap &&
        other.isVertical == isVertical &&
        other.indent == indent &&
        other.endIndent == endIndent;
  }

  @override
  int get hashCode {
    return Object.hash(
      color,
      thickness,
      dashLength,
      dashGap,
      isVertical,
      indent,
      endIndent,
    );
  }
}
