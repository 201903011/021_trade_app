import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A breadcrumb navigation component
class CustomBreadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final String separator;
  final double fontSize;
  final Color? activeColor;
  final Color? inactiveColor;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment alignment;

  const CustomBreadcrumb({
    super.key,
    required this.items,
    this.separator = '/',
    this.fontSize = 14.0,
    this.activeColor,
    this.inactiveColor,
    this.padding,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: alignment,
        children: _buildBreadcrumbItems(palette),
      ),
    );
  }

  List<Widget> _buildBreadcrumbItems(dynamic palette) {
    final List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;
      final isActive = isLast || item.isActive;

      // Add breadcrumb item
      widgets.add(
        _BreadcrumbItemWidget(
          item: item,
          isActive: isActive,
          fontSize: fontSize,
          activeColor: activeColor ?? palette.common.primary.main,
          inactiveColor: inactiveColor ?? palette.text.secondary,
        ),
      );

      // Add separator if not last item
      if (!isLast) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              separator,
              style: TextStyle(
                fontSize: fontSize,
                color: inactiveColor ?? palette.text.secondary,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}

class _BreadcrumbItemWidget extends StatelessWidget {
  final BreadcrumbItem item;
  final bool isActive;
  final double fontSize;
  final Color activeColor;
  final Color inactiveColor;

  const _BreadcrumbItemWidget({
    required this.item,
    required this.isActive,
    required this.fontSize,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      item.label,
      style: TextStyle(
        fontSize: fontSize,
        color: isActive ? activeColor : inactiveColor,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        decoration: item.onTap != null && !isActive ? TextDecoration.underline : TextDecoration.none,
      ),
    );

    if (item.onTap != null && !isActive) {
      return GestureDetector(
        onTap: item.onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: textWidget,
        ),
      );
    }

    return textWidget;
  }
}

/// Data class for breadcrumb items
class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  const BreadcrumbItem({
    required this.label,
    this.onTap,
    this.isActive = false,
  });

  BreadcrumbItem copyWith({
    String? label,
    VoidCallback? onTap,
    bool? isActive,
  }) {
    return BreadcrumbItem(
      label: label ?? this.label,
      onTap: onTap ?? this.onTap,
      isActive: isActive ?? this.isActive,
    );
  }
}
