import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minimals/theme/use_theme.dart';

class TransactionFilterSheet extends StatefulWidget {
  const TransactionFilterSheet({
    super.key,
    required this.initialFrom,
    required this.initialTo,
    required this.onApply,
  });

  final DateTime? initialFrom;
  final DateTime? initialTo;
  final void Function(DateTime? from, DateTime? to) onApply;

  static void show({
    required BuildContext context,
    DateTime? initialFrom,
    DateTime? initialTo,
    required void Function(DateTime? from, DateTime? to) onApply,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => TransactionFilterSheet(
        initialFrom: initialFrom,
        initialTo: initialTo,
        onApply: onApply,
      ),
    );
  }

  @override
  State<TransactionFilterSheet> createState() => _TransactionFilterSheetState();
}

enum _FilterOption { today, thisWeek, thisMonth, last3Months, custom, all }

class _TransactionFilterSheetState extends State<TransactionFilterSheet> {
  late _FilterOption _selected;
  DateTime? _customFrom;
  DateTime? _customTo;

  @override
  void initState() {
    super.initState();
    // Determine initial selection based on current filter state
    final from = widget.initialFrom;
    final to = widget.initialTo;
    if (from == null && to == null) {
      _selected = _FilterOption.all;
    } else {
      _selected = _FilterOption.custom;
      _customFrom = from;
      _customTo = to;
    }
  }

  DateTime get _todayStart => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get _todayEnd => _todayStart.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));

  DateTime get _monday => _todayStart.subtract(Duration(days: _todayStart.weekday - 1));

  DateTime get _weekEnd => _monday.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));

  DateTime get _monthStart => DateTime(DateTime.now().year, DateTime.now().month, 1);

  DateTime get _monthEnd => DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59, 999);

  DateTime get _threeMonthsAgo => DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);

  void _apply() {
    switch (_selected) {
      case _FilterOption.today:
        widget.onApply(_todayStart, _todayEnd);
      case _FilterOption.thisWeek:
        widget.onApply(_monday, _weekEnd);
      case _FilterOption.thisMonth:
        widget.onApply(_monthStart, _monthEnd);
      case _FilterOption.last3Months:
        widget.onApply(_threeMonthsAgo, DateTime.now());
      case _FilterOption.custom:
        widget.onApply(_customFrom, _customTo);
      case _FilterOption.all:
        widget.onApply(null, null);
    }
    Navigator.pop(context);
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? (_customFrom ?? now.subtract(const Duration(days: 30))) : (_customTo ?? now),
      firstDate: DateTime(2020),
      lastDate: now,
      helpText: isFrom ? 'Select From Date' : 'Select To Date',
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _customFrom = DateTime(picked.year, picked.month, picked.day);
          _selected = _FilterOption.custom;
        } else {
          _customTo = DateTime(picked.year, picked.month, picked.day, 23, 59, 59, 999);
          _selected = _FilterOption.custom;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;

    final dateFmt = DateFormat('dd MMM yyyy');

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filter by Date', style: baseTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),

          // ── Predefined options ──────────────────────────────────────────
          _FilterTile(
            label: 'Today',
            selected: _selected == _FilterOption.today,
            onTap: () => setState(() {
              _selected = _FilterOption.today;
            }),
          ),
          _FilterTile(
            label: 'This Week',
            selected: _selected == _FilterOption.thisWeek,
            onTap: () => setState(() {
              _selected = _FilterOption.thisWeek;
            }),
          ),
          _FilterTile(
            label: 'This Month',
            selected: _selected == _FilterOption.thisMonth,
            onTap: () => setState(() {
              _selected = _FilterOption.thisMonth;
            }),
          ),
          _FilterTile(
            label: 'Last 3 Months',
            selected: _selected == _FilterOption.last3Months,
            onTap: () => setState(() {
              _selected = _FilterOption.last3Months;
            }),
          ),
          _FilterTile(
            label: 'All Time',
            selected: _selected == _FilterOption.all,
            onTap: () => setState(() {
              _selected = _FilterOption.all;
            }),
            showDivider: false,
          ),

          // ── Custom Range ────────────────────────────────────────────────
          const SizedBox(height: 4),
          _FilterTile(
            label: 'Custom Range',
            selected: _selected == _FilterOption.custom,
            onTap: () => setState(() {
              _selected = _FilterOption.custom;
            }),
            showDivider: false,
          ),
          if (_selected == _FilterOption.custom) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DateButton(
                    label: 'From',
                    date: _customFrom,
                    dateFmt: dateFmt,
                    onTap: () => _pickDate(isFrom: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DateButton(
                    label: 'To',
                    date: _customTo,
                    dateFmt: dateFmt,
                    onTap: () => _pickDate(isFrom: false),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),

          // ── Apply button ────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _apply,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF36B37E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterTile extends StatelessWidget {
  const _FilterTile({
    required this.label,
    required this.selected,
    required this.onTap,
    this.showDivider = true,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
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
                      color: selected ? const Color(0xFF36B37E) : baseTheme.dividerColor,
                      width: selected ? 6 : 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(label, style: baseTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: baseTheme.dividerColor),
      ],
    );
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({
    required this.label,
    required this.date,
    required this.dateFmt,
    required this.onTap,
  });

  final String label;
  final DateTime? date;
  final DateFormat dateFmt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    final hasDate = date != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasDate ? customTheme.palette.common.primary.main : baseTheme.dividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: baseTheme.textTheme.labelSmall?.copyWith(color: baseTheme.textTheme.bodySmall?.color?.withOpacity(0.6))),
            const SizedBox(height: 2),
            Text(
              hasDate ? dateFmt.format(date!) : 'Select',
              style: baseTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: hasDate ? customTheme.palette.common.primary.main : baseTheme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
