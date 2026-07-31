import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

enum TooltipPosition {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// A generic, themeable tooltip component
class CustomTooltip extends StatefulWidget {
  /// The child widget that triggers the tooltip
  final Widget child;

  /// The message to display in the tooltip
  final String message;

  /// The position of the tooltip relative to the child
  final TooltipPosition position;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom text color override
  final Color? textColor;

  /// Custom text style override
  final TextStyle? textStyle;

  /// Custom padding override
  final EdgeInsetsGeometry? padding;

  /// Custom margin override
  final EdgeInsetsGeometry? margin;

  /// Custom border radius override
  final BorderRadius? borderRadius;

  /// Whether to show the tooltip arrow
  final bool showArrow;

  /// Custom arrow size
  final double arrowSize;

  /// Whether the tooltip should be shown on hover (web/desktop)
  final bool showOnHover;

  /// Whether the tooltip should be shown on tap (mobile)
  final bool showOnTap;

  /// Whether the tooltip should be shown on long press
  final bool showOnLongPress;

  /// Duration to wait before showing tooltip on hover
  final Duration waitDuration;

  /// Duration the tooltip stays visible
  final Duration showDuration;

  /// Custom elevation for shadow
  final double elevation;

  /// Whether to prefer showing above the widget
  final bool preferBelow;

  /// Vertical offset from the widget
  final double verticalOffset;

  /// Whether the tooltip should be modal (blocks interaction)
  final bool modal;

  const CustomTooltip({
    super.key,
    required this.child,
    required this.message,
    this.position = TooltipPosition.top,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.padding,
    this.margin,
    this.borderRadius,
    this.showArrow = true,
    this.arrowSize = 8.0,
    this.showOnHover = true,
    this.showOnTap = false,
    this.showOnLongPress = true,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(seconds: 2),
    this.elevation = 4.0,
    this.preferBelow = false,
    this.verticalOffset = 24.0,
    this.modal = false,
  });

  /// Factory constructor for simple tooltip
  factory CustomTooltip.simple({
    Key? key,
    required Widget child,
    required String message,
    TooltipPosition position = TooltipPosition.top,
    bool showOnHover = true,
    bool showOnTap = false,
    Duration waitDuration = const Duration(milliseconds: 500),
  }) {
    return CustomTooltip(
      key: key,
      child: child,
      message: message,
      position: position,
      showOnHover: showOnHover,
      showOnTap: showOnTap,
      waitDuration: waitDuration,
    );
  }

  /// Factory constructor for rich tooltip with custom styling
  factory CustomTooltip.rich({
    Key? key,
    required Widget child,
    required String message,
    TooltipPosition position = TooltipPosition.top,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double elevation = 4.0,
    bool showArrow = true,
    bool showOnHover = true,
    bool showOnTap = false,
    Duration waitDuration = const Duration(milliseconds: 500),
  }) {
    return CustomTooltip(
      key: key,
      child: child,
      message: message,
      position: position,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      borderRadius: borderRadius,
      elevation: elevation,
      showArrow: showArrow,
      showOnHover: showOnHover,
      showOnTap: showOnTap,
      waitDuration: waitDuration,
    );
  }

  @override
  State<CustomTooltip> createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;
  bool _isTooltipVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.showOnTap ? _showTooltip : null,
      onLongPress: widget.showOnLongPress ? _showTooltip : null,
      child: MouseRegion(
        onEnter: widget.showOnHover ? (_) => _showTooltip() : null,
        onExit: widget.showOnHover ? (_) => _hideTooltip() : null,
        child: widget.child,
      ),
    );
  }

  void _showTooltip() {
    if (_isTooltipVisible) return;

    _isTooltipVisible = true;

    // Capture the RenderBox from the current context before creating overlay
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    _overlayEntry = _createOverlayEntry(renderBox);

    Future.delayed(widget.waitDuration, () {
      if (_isTooltipVisible && mounted) {
        Overlay.of(context).insert(_overlayEntry!);

        if (widget.showDuration != Duration.zero) {
          Future.delayed(widget.showDuration, () {
            _hideTooltip();
          });
        }
      }
    });
  }

  void _hideTooltip() {
    if (!_isTooltipVisible) return;

    _isTooltipVisible = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(RenderBox targetRenderBox) {
    final theme = UseTheme(context);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: widget.modal ? _hideTooltip : null,
        behavior: widget.modal ? HitTestBehavior.opaque : HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned.fill(
              child: _TooltipPositioned(
                target: targetRenderBox,
                position: widget.position,
                verticalOffset: widget.verticalOffset,
                preferBelow: widget.preferBelow,
                child: _TooltipContent(
                  message: widget.message,
                  backgroundColor: widget.backgroundColor ?? theme.palette.background.paper,
                  textColor: widget.textColor ?? theme.palette.text.primary,
                  textStyle: widget.textStyle,
                  padding: widget.padding,
                  margin: widget.margin,
                  borderRadius: widget.borderRadius,
                  showArrow: widget.showArrow,
                  arrowSize: widget.arrowSize,
                  position: widget.position,
                  elevation: widget.elevation,
                  theme: theme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }
}

class _TooltipPositioned extends StatelessWidget {
  final RenderBox target;
  final TooltipPosition position;
  final double verticalOffset;
  final bool preferBelow;
  final Widget child;

  const _TooltipPositioned({
    required this.target,
    required this.position,
    required this.verticalOffset,
    required this.preferBelow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final targetPosition = target.localToGlobal(Offset.zero);
    final targetSize = target.size;

    double left = 0;
    double top = 0;

    switch (position) {
      case TooltipPosition.top:
        left = targetPosition.dx + (targetSize.width / 2);
        top = targetPosition.dy - verticalOffset;
        break;
      case TooltipPosition.bottom:
        left = targetPosition.dx + (targetSize.width / 2);
        top = targetPosition.dy + targetSize.height + verticalOffset;
        break;
      case TooltipPosition.left:
        left = targetPosition.dx - verticalOffset;
        top = targetPosition.dy + (targetSize.height / 2);
        break;
      case TooltipPosition.right:
        left = targetPosition.dx + targetSize.width + verticalOffset;
        top = targetPosition.dy + (targetSize.height / 2);
        break;
      case TooltipPosition.topLeft:
        left = targetPosition.dx;
        top = targetPosition.dy - verticalOffset;
        break;
      case TooltipPosition.topRight:
        left = targetPosition.dx + targetSize.width;
        top = targetPosition.dy - verticalOffset;
        break;
      case TooltipPosition.bottomLeft:
        left = targetPosition.dx;
        top = targetPosition.dy + targetSize.height + verticalOffset;
        break;
      case TooltipPosition.bottomRight:
        left = targetPosition.dx + targetSize.width;
        top = targetPosition.dy + targetSize.height + verticalOffset;
        break;
    }

    return Positioned(
      left: left,
      top: top,
      child: child,
    );
  }
}

class _TooltipContent extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final bool showArrow;
  final double arrowSize;
  final TooltipPosition position;
  final double elevation;
  final UseTheme theme;

  const _TooltipContent({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.textStyle,
    this.padding,
    this.margin,
    this.borderRadius,
    required this.showArrow,
    required this.arrowSize,
    required this.position,
    required this.elevation,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final defaultBorderRadius = BorderRadius.circular(8);

    Widget content = Container(
      padding: padding ?? defaultPadding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? defaultBorderRadius,
        boxShadow: [
          BoxShadow(
            color: theme.palette.action.disabled.withOpacity(0.1),
            blurRadius: elevation,
            offset: Offset(0, elevation / 2),
          ),
        ],
      ),
      child: Text(
        message,
        style: (textStyle ?? theme.typography.body2).copyWith(
          color: textColor,
        ),
      ),
    );

    if (showArrow) {
      content = Stack(
        children: [
          // Arrow
          Positioned(
            child: _buildArrow(),
          ),
          // Content with arrow spacing
          Padding(
            padding: _getArrowPadding(),
            child: content,
          ),
        ],
      );
    }

    // Center the tooltip based on position
    return Transform.translate(
      offset: _getCenteringOffset(content),
      child: content,
    );
  }

  Widget _buildArrow() {
    return CustomPaint(
      painter: _ArrowPainter(
        color: backgroundColor,
        direction: _getArrowDirection(),
        size: arrowSize,
      ),
      size: Size(arrowSize * 2, arrowSize * 2),
    );
  }

  EdgeInsetsGeometry _getArrowPadding() {
    switch (position) {
      case TooltipPosition.top:
      case TooltipPosition.topLeft:
      case TooltipPosition.topRight:
        return EdgeInsets.only(bottom: arrowSize);
      case TooltipPosition.bottom:
      case TooltipPosition.bottomLeft:
      case TooltipPosition.bottomRight:
        return EdgeInsets.only(top: arrowSize);
      case TooltipPosition.left:
        return EdgeInsets.only(right: arrowSize);
      case TooltipPosition.right:
        return EdgeInsets.only(left: arrowSize);
    }
  }

  AxisDirection _getArrowDirection() {
    switch (position) {
      case TooltipPosition.top:
      case TooltipPosition.topLeft:
      case TooltipPosition.topRight:
        return AxisDirection.down;
      case TooltipPosition.bottom:
      case TooltipPosition.bottomLeft:
      case TooltipPosition.bottomRight:
        return AxisDirection.up;
      case TooltipPosition.left:
        return AxisDirection.right;
      case TooltipPosition.right:
        return AxisDirection.left;
    }
  }

  Offset _getCenteringOffset(Widget content) {
    // This is a simplified centering - in a real implementation,
    // you'd measure the content size to center properly
    switch (position) {
      case TooltipPosition.top:
      case TooltipPosition.bottom:
        return const Offset(-50, 0); // Approximate centering
      case TooltipPosition.left:
      case TooltipPosition.right:
        return const Offset(0, -25); // Approximate centering
      case TooltipPosition.topLeft:
      case TooltipPosition.bottomLeft:
        return Offset.zero;
      case TooltipPosition.topRight:
      case TooltipPosition.bottomRight:
        return const Offset(-100, 0); // Approximate right alignment
    }
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final AxisDirection direction;
  final double size;

  _ArrowPainter({
    required this.color,
    required this.direction,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    switch (direction) {
      case AxisDirection.up:
        path.moveTo(size, 0);
        path.lineTo(0, size);
        path.lineTo(size * 2, size);
        break;
      case AxisDirection.down:
        path.moveTo(0, 0);
        path.lineTo(size * 2, 0);
        path.lineTo(size, size);
        break;
      case AxisDirection.left:
        path.moveTo(size, 0);
        path.lineTo(0, size);
        path.lineTo(size, size * 2);
        break;
      case AxisDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size, size);
        path.lineTo(0, size * 2);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
