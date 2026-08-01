import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/theme/use_theme.dart';

class HoldingsSortBar extends StatelessWidget {
  const HoldingsSortBar({super.key, required this.controller});

  final HoldingMainController controller;

  void _showSortSheet(BuildContext context, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => _SortBottomSheet(controller: controller, theme: theme),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _showSortSheet(context, baseTheme),
                child: Row(
                  children: [
                    Icon(Icons.sort_rounded, size: 18, color: customTheme.palette.text.secondary),
                    const SizedBox(width: 4),
                    Text('Sort',
                        style: baseTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: controller.toggleDisplayMode,
                child: Row(
                  children: [
                    Icon(Icons.swap_horiz_rounded, size: 16, color: customTheme.palette.common.primary.main),
                    const SizedBox(width: 4),
                    Text(
                      controller.displayModeLabel,
                      style: baseTheme.textTheme.bodySmall?.copyWith(color: customTheme.palette.common.primary.main, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _SortBottomSheet extends StatefulWidget {
  const _SortBottomSheet({required this.controller, required this.theme});
  final HoldingMainController controller;
  final ThemeData theme;

  @override
  State<_SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<_SortBottomSheet> {
  late String _selectedField;
  late bool _ascending;

  @override
  void initState() {
    super.initState();
    _selectedField = widget.controller.sortField.value;
    _ascending = widget.controller.sortAscending.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    const options = [
      ('currentValue', 'Current Value'),
      ('returns', 'Returns %'),
      ('dayChange', 'Day Change %'),
      ('stockName', 'Stock name'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sort by', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...options.map((opt) {
            final isSelected = _selectedField == opt.$1;
            return Column(
              children: [
                InkWell(
                  onTap: () => setState(() => _selectedField = opt.$1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? const Color(0xFF36B37E) : theme.dividerColor,
                              width: isSelected ? 6 : 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(opt.$2, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                        if (isSelected) ...[
                          const SizedBox(width: 12),
                          _DirectionChip(
                            label: '↓ High to low',
                            selected: !_ascending,
                            onTap: () => setState(() => _ascending = false),
                          ),
                          const SizedBox(width: 8),
                          _DirectionChip(
                            label: '↑ Low to high',
                            selected: _ascending,
                            onTap: () => setState(() => _ascending = true),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
              ],
            );
          }),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.controller.setSortField(_selectedField);
                widget.controller.sortAscending.value = _ascending;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF36B37E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectionChip extends StatelessWidget {
  const _DirectionChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? theme.customTheme.palette.common.primary.lighter : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? customTheme.palette.common.primary.main : baseTheme.dividerColor),
        ),
        child:
            Text(label, style: baseTheme.textTheme.labelSmall?.copyWith(color: selected ? customTheme.palette.common.primary.main : baseTheme.textTheme.bodySmall?.color, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
