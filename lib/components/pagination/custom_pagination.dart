import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable pagination component
class CustomPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final int maxVisiblePages;
  final bool showFirstLast;
  final bool showPrevNext;
  final String previousText;
  final String nextText;
  final String firstText;
  final String lastText;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? disabledColor;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxVisiblePages = 5,
    this.showFirstLast = true,
    this.showPrevNext = true,
    this.previousText = 'Previous',
    this.nextText = 'Next',
    this.firstText = 'First',
    this.lastText = 'Last',
    this.padding,
    this.spacing = 8.0,
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPaginationItems(palette),
      ),
    );
  }

  List<Widget> _buildPaginationItems(dynamic palette) {
    final List<Widget> items = [];
    final activeColor = this.activeColor ?? palette.common.primary.main;
    final inactiveColor = this.inactiveColor ?? palette.text.secondary;

    // First button
    if (showFirstLast && totalPages > maxVisiblePages) {
      items.add(_buildNavigationButton(
        text: firstText,
        onPressed: currentPage > 1 ? () => onPageChanged(1) : null,
        palette: palette,
      ));
      items.add(SizedBox(width: spacing));
    }

    // Previous button
    if (showPrevNext) {
      items.add(_buildNavigationButton(
        text: previousText,
        onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        palette: palette,
      ));
      items.add(SizedBox(width: spacing));
    }

    // Page numbers
    final pageNumbers = _calculateVisiblePages();
    for (int i = 0; i < pageNumbers.length; i++) {
      final pageNumber = pageNumbers[i];

      if (pageNumber == -1) {
        // Ellipsis
        items.add(_buildEllipsis(palette));
      } else {
        items.add(_buildPageButton(
          pageNumber: pageNumber,
          isActive: pageNumber == currentPage,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          palette: palette,
        ));
      }

      if (i < pageNumbers.length - 1) {
        items.add(SizedBox(width: spacing));
      }
    }

    // Next button
    if (showPrevNext) {
      items.add(SizedBox(width: spacing));
      items.add(_buildNavigationButton(
        text: nextText,
        onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
        palette: palette,
      ));
    }

    // Last button
    if (showFirstLast && totalPages > maxVisiblePages) {
      items.add(SizedBox(width: spacing));
      items.add(_buildNavigationButton(
        text: lastText,
        onPressed: currentPage < totalPages ? () => onPageChanged(totalPages) : null,
        palette: palette,
      ));
    }

    return items;
  }

  Widget _buildPageButton({
    required int pageNumber,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
    required dynamic palette,
  }) {
    return GestureDetector(
      onTap: () => onPageChanged(pageNumber),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          border: Border.all(
            color: isActive ? activeColor : palette.common.divider,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            pageNumber.toString(),
            style: TextStyle(
              color: isActive ? Colors.white : inactiveColor,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required String text,
    required VoidCallback? onPressed,
    required dynamic palette,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: palette.common.divider),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: onPressed != null ? palette.text.primary : palette.action.disabled,
        ),
      ),
    );
  }

  Widget _buildEllipsis(dynamic palette) {
    return Container(
      width: 40,
      height: 40,
      child: Center(
        child: Text(
          '...',
          style: TextStyle(
            color: palette.text.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  List<int> _calculateVisiblePages() {
    if (totalPages <= maxVisiblePages) {
      return List.generate(totalPages, (index) => index + 1);
    }

    final List<int> pages = [];
    final half = maxVisiblePages ~/ 2;

    if (currentPage <= half + 1) {
      // Show pages from start
      pages.addAll(List.generate(maxVisiblePages - 1, (index) => index + 1));
      pages.add(-1); // ellipsis
      pages.add(totalPages);
    } else if (currentPage >= totalPages - half) {
      // Show pages from end
      pages.add(1);
      pages.add(-1); // ellipsis
      pages.addAll(List.generate(
        maxVisiblePages - 1,
        (index) => totalPages - (maxVisiblePages - 2) + index,
      ));
    } else {
      // Show pages around current
      pages.add(1);
      pages.add(-1); // ellipsis

      final start = currentPage - (half - 1);
      final end = currentPage + (half - 1);
      pages.addAll(List.generate(end - start + 1, (index) => start + index));

      pages.add(-1); // ellipsis
      pages.add(totalPages);
    }

    return pages;
  }
}
