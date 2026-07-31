import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/theme/shadows.dart';

/// A customizable accordion/expansion panel component that follows MUI accordion design
class CustomAccordion extends StatefulWidget {
  final List<AccordionItem> items;
  final bool expandedHeaderHeight;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final bool allowMultipleExpanded;
  final Function(String, bool)? onExpansionChanged;
  final String? expandedPanelId; // For controlled accordion

  const CustomAccordion({
    super.key,
    required this.items,
    this.expandedHeaderHeight = false,
    this.contentPadding,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.allowMultipleExpanded = false,
    this.onExpansionChanged,
    this.expandedPanelId,
  });

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  late List<AccordionItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(CustomAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
    }
  }

  void _handleExpansionChanged(String panelId, bool isExpanded) {
    setState(() {
      if (widget.allowMultipleExpanded) {
        // Multiple panels can be expanded
        final index = _items.indexWhere((item) => item.id == panelId);
        if (index != -1) {
          _items[index] = _items[index].copyWith(isExpanded: isExpanded);
        }
      } else {
        // Only one panel can be expanded (controlled behavior)
        for (int i = 0; i < _items.length; i++) {
          if (_items[i].id == panelId) {
            _items[i] = _items[i].copyWith(isExpanded: isExpanded);
          } else {
            _items[i] = _items[i].copyWith(isExpanded: false);
          }
        }
      }
    });

    widget.onExpansionChanged?.call(panelId, isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final useTheme = UseTheme(context);
    final palette = useTheme.palette;
    final shadows = AppShadows.createShadows(useTheme.theme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);

    return Column(
      children: _items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isExpanded = widget.expandedPanelId != null ? widget.expandedPanelId == item.id : item.isExpanded;

        return Container(
          margin: index > 0 ? const EdgeInsets.only(top: 1) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: isExpanded ? palette.background.paper : Colors.transparent,
            borderRadius: isExpanded ? BorderRadius.circular(widget.borderRadius) : null,
            boxShadow: isExpanded ? shadows[8] : null, // Equivalent to theme.customShadows.z8
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              expansionTileTheme: ExpansionTileThemeData(
                backgroundColor: Colors.transparent,
                collapsedBackgroundColor: Colors.transparent,
                tilePadding: EdgeInsets.only(
                  left: useTheme.theme.textTheme.bodyMedium?.fontSize != null ? useTheme.theme.textTheme.bodyMedium!.fontSize! * 2 : 16.0,
                  right: useTheme.theme.textTheme.bodyMedium?.fontSize != null ? useTheme.theme.textTheme.bodyMedium!.fontSize! * 1 : 8.0,
                ),
                iconColor: isExpanded ? palette.common.primary.main : palette.text.secondary,
                collapsedIconColor: palette.text.secondary,
                textColor: isExpanded ? palette.common.primary.main : palette.text.primary,
                collapsedTextColor: palette.text.primary,
              ),
            ),
            child: ExpansionTile(
              key: Key(item.id),
              title: _buildTitle(item, isExpanded, palette),
              subtitle: item.subtitle != null ? _buildSubtitle(item, palette) : null,
              leading: item.icon != null
                  ? Icon(
                      item.icon,
                      color: isExpanded ? palette.common.primary.main : palette.text.secondary,
                    )
                  : null,
              initiallyExpanded: isExpanded,
              onExpansionChanged: (expanded) => _handleExpansionChanged(item.id, expanded),
              children: [
                Container(
                  width: double.infinity,
                  padding: widget.contentPadding ?? const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: palette.background.neutral,
                    border: Border(
                      top: BorderSide(color: palette.common.divider),
                    ),
                  ),
                  child: item.content,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTitle(AccordionItem item, bool isExpanded, dynamic palette) {
    return Text(
      item.title,
      style: TextStyle(
        fontWeight: isExpanded ? FontWeight.w600 : FontWeight.w500,
        color: isExpanded ? palette.common.primary.main : palette.text.primary,
      ),
    );
  }

  Widget _buildSubtitle(AccordionItem item, dynamic palette) {
    return Text(
      item.subtitle!,
      style: TextStyle(color: palette.text.secondary),
    );
  }
}

/// Data class for accordion items
class AccordionItem {
  final String id;
  final String title;
  final String? subtitle;
  final Widget content;
  final IconData? icon;
  final bool isExpanded;

  const AccordionItem({
    required this.id,
    required this.title,
    required this.content,
    this.subtitle,
    this.icon,
    this.isExpanded = false,
  });

  AccordionItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    Widget? content,
    IconData? icon,
    bool? isExpanded,
  }) {
    return AccordionItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
