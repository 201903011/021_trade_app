import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/components/button/custom_button.dart';
import 'package:minimals/models/holding_model.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/order/order_screen.dart';
import 'package:minimals/theme/overrides/button.dart';
import 'package:minimals/theme/use_theme.dart';

void showHoldingActionSheet(BuildContext context, HoldingModel holding, StockModel stock) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _HoldingActionSheet(holding: holding, stock: stock),
  );
}

class _HoldingActionSheet extends StatelessWidget {
  const _HoldingActionSheet({required this.holding, required this.stock});

  final HoldingModel holding;
  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Container(
      decoration: BoxDecoration(
        color: customTheme.palette.background.paper,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 4),
            width: 36,
            height: 4,
            decoration: BoxDecoration(color: baseTheme.dividerColor, borderRadius: BorderRadius.circular(2)),
          ),

          // Stock info card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: baseTheme.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            navigateToOrder(stock);
                          },
                          child: Row(
                            children: [
                              Text(stock.name, style: baseTheme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                              const SizedBox(width: 4),
                              Icon(Icons.chevron_right_rounded, size: 18, color: baseTheme.textTheme.bodyMedium?.color),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          final ltp = stock.lastPrice.value;
                          final chgPct = stock.changePercent.value;
                          final isPos = chgPct >= 0;
                          final color = isPos ? const Color(0xFF36B37E) : const Color(0xFFFF5630);
                          return Text(
                            'Mkt ₹${ltp.toStringAsFixed(2)} (${isPos ? '+' : ''}${chgPct.toStringAsFixed(2)}%)',
                            style: baseTheme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w500),
                          );
                        }),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        holding.quantity.toStringAsFixed(holding.quantity == holding.quantity.floorToDouble() ? 0 : 2),
                        style: baseTheme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Avg ₹${holding.avgPrice.toStringAsFixed(1)}',
                        style: baseTheme.textTheme.bodySmall?.copyWith(color: customTheme.palette.text.secondary, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //  Sell / Buy row
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton.contained(
                    text: 'Sell',
                    color: ButtonColor.error,
                    onPressed: () {
                      Navigator.pop(context);
                      navigateToOrder(stock, isBuy: false);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton.contained(
                    text: 'Buy',
                    color: ButtonColor.success,
                    onPressed: () {
                      Navigator.pop(context);
                      navigateToOrder(stock, isBuy: true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
