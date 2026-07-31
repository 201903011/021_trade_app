import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable tabs component
class CustomTabs extends StatefulWidget {
  final List<TabItem> tabs;
  final int initialIndex;
  final Function(int)? onTabChanged;
  final TabPosition position;
  final TabVariant variant;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? backgroundColor;
  final double? indicatorWeight;
  final EdgeInsetsGeometry? padding;
  final bool scrollable;

  const CustomTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
    this.position = TabPosition.top,
    this.variant = TabVariant.line,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.backgroundColor,
    this.indicatorWeight,
    this.padding,
    this.scrollable = false,
  });

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
    _controller.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _controller.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.onTabChanged != null) {
      widget.onTabChanged!(_controller.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    final tabBar = _buildTabBar(palette);
    final tabBarView = _buildTabBarView();

    switch (widget.position) {
      case TabPosition.top:
        return Column(
          children: [
            tabBar,
            Expanded(child: tabBarView),
          ],
        );
      case TabPosition.bottom:
        return Column(
          children: [
            Expanded(child: tabBarView),
            tabBar,
          ],
        );
      case TabPosition.left:
        return Row(
          children: [
            RotatedBox(quarterTurns: 1, child: tabBar),
            Expanded(child: tabBarView),
          ],
        );
      case TabPosition.right:
        return Row(
          children: [
            Expanded(child: tabBarView),
            RotatedBox(quarterTurns: 3, child: tabBar),
          ],
        );
    }
  }

  Widget _buildTabBar(dynamic palette) {
    final indicatorColor = widget.indicatorColor ?? palette.common.primary.main;
    final labelColor = widget.labelColor ?? palette.common.primary.main;
    final unselectedLabelColor = widget.unselectedLabelColor ?? palette.text.secondary;

    Widget tabBar;

    switch (widget.variant) {
      case TabVariant.line:
        tabBar = TabBar(
          controller: _controller,
          isScrollable: widget.scrollable,
          indicatorColor: indicatorColor,
          indicatorWeight: widget.indicatorWeight ?? 2.0,
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          tabs: widget.tabs.map((tab) => _buildTab(tab)).toList(),
        );
        break;
      case TabVariant.pill:
        tabBar = _buildPillTabs(palette);
        break;
      case TabVariant.card:
        tabBar = _buildCardTabs(palette);
        break;
    }

    return Container(
      color: widget.backgroundColor,
      padding: widget.padding,
      child: tabBar,
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _controller,
      children: widget.tabs.map((tab) => tab.content).toList(),
    );
  }

  Widget _buildTab(TabItem tab) {
    return Tab(
      text: tab.label,
      icon: tab.icon != null ? Icon(tab.icon) : null,
    );
  }

  Widget _buildPillTabs(dynamic palette) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _controller.index;

          return GestureDetector(
            onTap: () => _controller.animateTo(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? (widget.indicatorColor ?? palette.common.primary.main) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.indicatorColor ?? palette.common.primary.main,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (tab.icon != null) ...[
                    Icon(
                      tab.icon,
                      size: 16,
                      color: isSelected ? Colors.white : palette.text.secondary,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    tab.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : palette.text.secondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCardTabs(dynamic palette) {
    return Row(
      children: widget.tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final isSelected = index == _controller.index;
        final isFirst = index == 0;
        final isLast = index == widget.tabs.length - 1;

        return Expanded(
          child: GestureDetector(
            onTap: () => _controller.animateTo(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? (widget.indicatorColor ?? palette.common.primary.main) : palette.background.neutral,
                borderRadius: BorderRadius.only(
                  topLeft: isFirst ? const Radius.circular(8) : Radius.zero,
                  bottomLeft: isFirst ? const Radius.circular(8) : Radius.zero,
                  topRight: isLast ? const Radius.circular(8) : Radius.zero,
                  bottomRight: isLast ? const Radius.circular(8) : Radius.zero,
                ),
                border: Border.all(color: palette.common.divider),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (tab.icon != null) ...[
                      Icon(
                        tab.icon,
                        size: 16,
                        color: isSelected ? Colors.white : palette.text.secondary,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      tab.label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : palette.text.secondary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Data class for tab items
class TabItem {
  final String label;
  final Widget content;
  final IconData? icon;
  final Widget? badge;

  const TabItem({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
  });

  TabItem copyWith({
    String? label,
    Widget? content,
    IconData? icon,
    Widget? badge,
  }) {
    return TabItem(
      label: label ?? this.label,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      badge: badge ?? this.badge,
    );
  }
}

/// Tab position enumeration
enum TabPosition {
  top,
  bottom,
  left,
  right,
}

/// Tab variant enumeration
enum TabVariant {
  line,
  pill,
  card,
}
