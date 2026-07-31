import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable navigation bar component
class CustomNavigationBar extends StatelessWidget {
  final List<NavigationBarItem> items;
  final int currentIndex;
  final Function(int) onItemTapped;
  final NavigationBarType type;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double elevation;
  final bool showLabels;
  final EdgeInsetsGeometry? padding;

  const CustomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTapped,
    this.type = NavigationBarType.fixed,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.showLabels = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? palette.background.paper,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: palette.common.divider.withOpacity(0.3),
                  blurRadius: elevation,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildNavigationItem(item, index, palette);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(NavigationBarItem item, int index, dynamic palette) {
    final isSelected = index == currentIndex;
    final selectedColor = selectedItemColor ?? palette.common.primary.main;
    final unselectedColor = unselectedItemColor ?? palette.text.secondary;

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isSelected && type == NavigationBarType.filled ? selectedColor.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isSelected ? item.selectedIcon ?? item.icon : item.icon,
                      color: isSelected ? selectedColor : unselectedColor,
                      size: 24,
                    ),
                  ),
                  if (showLabels) ...[
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: isSelected ? selectedColor : unselectedColor,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      child: Text(
                        item.label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ],
              ),
              if (item.badge != null)
                Positioned(
                  right: 0,
                  top: 0,
                  child: item.badge!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigation bar with bottom sheet variant
class CustomBottomNavigationBar extends StatelessWidget {
  final List<NavigationBarItem> items;
  final int currentIndex;
  final Function(int) onItemTapped;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double elevation;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTapped,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return BottomNavigationBar(
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: item.selectedIcon != null ? Icon(item.selectedIcon!) : null,
                label: item.label,
              ))
          .toList(),
      currentIndex: currentIndex,
      onTap: onItemTapped,
      backgroundColor: backgroundColor ?? palette.background.paper,
      selectedItemColor: selectedItemColor ?? palette.common.primary.main,
      unselectedItemColor: unselectedItemColor ?? palette.text.secondary,
      elevation: elevation,
      type: items.length > 3 ? BottomNavigationBarType.shifting : BottomNavigationBarType.fixed,
    );
  }
}

/// Data class for navigation bar items
class NavigationBarItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final Widget? badge;

  const NavigationBarItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
  });

  NavigationBarItem copyWith({
    IconData? icon,
    IconData? selectedIcon,
    String? label,
    Widget? badge,
  }) {
    return NavigationBarItem(
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      label: label ?? this.label,
      badge: badge ?? this.badge,
    );
  }
}

/// Navigation bar type enumeration
enum NavigationBarType {
  fixed,
  filled,
  shifting,
}
