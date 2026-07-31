import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable data table component
class CustomTable<T> extends StatelessWidget {
  final List<TableColumn<T>> columns;
  final List<T> data;
  final Function(T)? onRowTap;
  final Function(T)? onRowLongPress;
  final bool showHeader;
  final bool showBorders;
  final bool striped;
  final bool sortable;
  final EdgeInsetsGeometry? padding;
  final double rowHeight;
  final double headerHeight;
  final Color? headerColor;
  final Color? evenRowColor;
  final Color? oddRowColor;
  final Color? borderColor;
  final Widget? emptyWidget;

  const CustomTable({
    super.key,
    required this.columns,
    required this.data,
    this.onRowTap,
    this.onRowLongPress,
    this.showHeader = true,
    this.showBorders = true,
    this.striped = false,
    this.sortable = false,
    this.padding,
    this.rowHeight = 48.0,
    this.headerHeight = 56.0,
    this.headerColor,
    this.evenRowColor,
    this.oddRowColor,
    this.borderColor,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    if (data.isEmpty) {
      return emptyWidget ?? _buildEmptyState(palette);
    }

    return Container(
      padding: padding,
      decoration: showBorders
          ? BoxDecoration(
              border: Border.all(color: borderColor ?? palette.common.divider),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showHeader) _buildHeader(palette),
          _buildBody(palette),
        ],
      ),
    );
  }

  Widget _buildHeader(dynamic palette) {
    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        color: headerColor ?? palette.background.neutral,
        border: showBorders
            ? Border(
                bottom: BorderSide(color: borderColor ?? palette.common.divider),
              )
            : null,
      ),
      child: Row(
        children: columns.map((column) => _buildHeaderCell(column, palette)).toList(),
      ),
    );
  }

  Widget _buildHeaderCell(TableColumn<T> column, dynamic palette) {
    return Expanded(
      flex: column.flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: _getColumnAlignment(column.alignment),
          children: [
            Text(
              column.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: palette.text.primary,
                fontSize: 14,
              ),
            ),
            if (sortable && column.sortable) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.sort,
                size: 16,
                color: palette.text.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBody(dynamic palette) {
    return Column(
      children: data.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return _buildRow(item, index, palette);
      }).toList(),
    );
  }

  Widget _buildRow(T item, int index, dynamic palette) {
    final isEven = index % 2 == 0;
    Color? backgroundColor;

    if (striped) {
      backgroundColor = isEven ? (evenRowColor ?? palette.background.paper) : (oddRowColor ?? palette.background.neutral);
    }

    return GestureDetector(
      onTap: onRowTap != null ? () => onRowTap!(item) : null,
      onLongPress: onRowLongPress != null ? () => onRowLongPress!(item) : null,
      child: Container(
        height: rowHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: showBorders && index < data.length - 1
              ? Border(
                  bottom: BorderSide(color: borderColor ?? palette.common.divider),
                )
              : null,
        ),
        child: Row(
          children: columns.map((column) => _buildDataCell(column, item, palette)).toList(),
        ),
      ),
    );
  }

  Widget _buildDataCell(TableColumn<T> column, T item, dynamic palette) {
    return Expanded(
      flex: column.flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Align(
          alignment: _getAlignmentFromColumnAlignment(column.alignment),
          child: column.builder(item),
        ),
      ),
    );
  }

  Widget _buildEmptyState(dynamic palette) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.table_view_outlined,
            size: 64,
            color: palette.text.disabled,
          ),
          const SizedBox(height: 16),
          Text(
            'No data available',
            style: TextStyle(
              color: palette.text.secondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  MainAxisAlignment _getColumnAlignment(TableColumnAlignment alignment) {
    switch (alignment) {
      case TableColumnAlignment.left:
        return MainAxisAlignment.start;
      case TableColumnAlignment.center:
        return MainAxisAlignment.center;
      case TableColumnAlignment.right:
        return MainAxisAlignment.end;
    }
  }

  Alignment _getAlignmentFromColumnAlignment(TableColumnAlignment alignment) {
    switch (alignment) {
      case TableColumnAlignment.left:
        return Alignment.centerLeft;
      case TableColumnAlignment.center:
        return Alignment.center;
      case TableColumnAlignment.right:
        return Alignment.centerRight;
    }
  }
}

/// Data class for table columns
class TableColumn<T> {
  final String title;
  final Widget Function(T) builder;
  final int flex;
  final TableColumnAlignment alignment;
  final bool sortable;

  const TableColumn({
    required this.title,
    required this.builder,
    this.flex = 1,
    this.alignment = TableColumnAlignment.left,
    this.sortable = false,
  });
}

/// Table column alignment enumeration
enum TableColumnAlignment {
  left,
  center,
  right,
}
