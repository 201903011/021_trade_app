import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/widget/dashed_divider.dart';

class HoldingsSummaryHeader extends StatelessWidget {
  const HoldingsSummaryHeader({super.key, required this.controller});

  final HoldingMainController controller;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Obx(() {
      final holdings = controller.holdings;
      double totalInvested = 0;
      double totalCurrent = 0;
      double totalDayChange = 0;
      for (final h in holdings) {
        totalInvested += h.investedValue;
        totalCurrent += h.currentValue;
        totalDayChange += h.dayChange;
      }
      final totalPnl = double.parse((totalCurrent - totalInvested).toStringAsFixed(2));
      final totalPnlPct = totalInvested == 0 ? 0.0 : double.parse(((totalPnl / totalInvested) * 100).toStringAsFixed(2));
      final dayChangePct = totalInvested == 0 ? 0.0 : double.parse(((totalDayChange / totalInvested) * 100).toStringAsFixed(2));

      final isPnlPos = totalPnl >= 0;
      final isDayPos = totalDayChange >= 0;
      final pnlColor = isPnlPos ? const Color(0xFF36B37E) : const Color(0xFFFF5630);
      final dayColor = isDayPos ? const Color(0xFF36B37E) : const Color(0xFFFF5630);

      return Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: baseTheme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Placeholder ▼ dropdown — no filter logic
                  Row(
                    children: [
                      Text(
                        'HOLDINGS (${holdings.length})',
                        style: baseTheme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: customTheme.palette.text.secondary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Static icon buttons — eye has no hide functionality per spec
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '₹${totalCurrent.toStringAsFixed(2)}',
                style: baseTheme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
              ),
              const SizedBox(height: 12),
              DashedDivider(color: baseTheme.dividerColor),
              const SizedBox(height: 12),
              _SummaryRow(
                label: '1D returns',
                value: '${isDayPos ? '+' : ''}₹${totalDayChange.toStringAsFixed(2)} (${isDayPos ? '+' : ''}${dayChangePct.toStringAsFixed(2)}%)',
                valueColor: dayColor,
                theme: baseTheme,
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: 'Total returns',
                value: '${isPnlPos ? '+' : ''}₹${totalPnl.toStringAsFixed(2)} (${isPnlPos ? '+' : ''}${totalPnlPct.toStringAsFixed(2)}%)',
                valueColor: pnlColor,
                theme: baseTheme,
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: 'Invested',
                value: '₹${totalInvested.toStringAsFixed(2)}',
                theme: baseTheme,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, required this.theme, this.valueColor});
  final String label;
  final String value;
  final ThemeData theme;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
