import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A block component used to display variants and combinations of components
/// Equivalent to the React MUI Block component
class Block extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? minHeight;
  final Color? backgroundColor;

  const Block({
    super.key,
    this.title,
    required this.child,
    this.padding,
    this.minHeight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final useTheme = UseTheme(context);
    final palette = useTheme.palette;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // 1.5 * 8 = 12 (equivalent to borderRadius: 1.5)
        border: Border.all(
          color: palette.common.divider,
          width: 1,
        ),
        color: backgroundColor ?? palette.background.paper.withOpacity(0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) _buildHeader(title!, palette),
          Container(
            padding: padding ?? const EdgeInsets.all(40), // 5 * 8 = 40 (equivalent to p: 5)
            constraints: BoxConstraints(
              minHeight: minHeight ?? 180,
            ),
            width: double.infinity,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, dynamic palette) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0), // Standard header padding
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: palette.text.primary,
        ),
      ),
    );
  }
}

/// A label component for displaying section titles
/// Equivalent to the React MUI Label component
class Label extends StatelessWidget {
  final String title;
  final Color? color;

  const Label({
    super.key,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final useTheme = UseTheme(context);
    final palette = useTheme.palette;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // gutterBottom equivalent
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: color ?? palette.text.secondary,
        ),
      ),
    );
  }
}
