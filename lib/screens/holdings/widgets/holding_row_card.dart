import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/holding_model.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/theme/use_theme.dart';

class HoldingRowCard extends StatelessWidget {
  const HoldingRowCard({
    super.key,
    required this.holding,
    required this.onTap,
  });

  final HoldingModel holding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;
    final stock = StockModel.stockMap[holding.symbol];
    final controller = Get.find<HoldingMainController>();

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: baseTheme.dividerColor, width: 0.5)),
        ),
        child: Row(
          children: [
            // Stock logo badge
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: customTheme.palette.common.primary.lighter,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: stock != null && stock.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        stock.imageUrl,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.show_chart_rounded, size: 22, color: customTheme.palette.common.primary.light),
                      ),
                    )
                  : Icon(Icons.show_chart_rounded, size: 22, color: customTheme.palette.common.primary.main),
            ),
            const SizedBox(width: 12),

            // Stock name + qty
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock?.name ?? holding.symbol,
                    style: baseTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${holding.quantity.toStringAsFixed(holding.quantity == holding.quantity.floorToDouble() ? 0 : 2)} shares',
                    style: baseTheme.textTheme.bodyMedium?.copyWith(color: customTheme.palette.text.secondary, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Right column — reactive to displayMode
            if (stock != null)
              Obx(() {
                // Read live prices so Obx rebuilds on tick
                final _ = stock.lastPrice.value;
                final __ = stock.change.value;
                final mode = controller.displayMode.value;

                final double primaryVal;
                final double secondaryVal;
                final bool isPrimPos;
                final String primaryFmt;
                final String secondaryFmt;

                switch (mode) {
                  case 1: // Returns %
                    primaryVal = holding.pnl;
                    secondaryVal = holding.pnlPercent;
                    isPrimPos = primaryVal >= 0;
                    primaryFmt = '${isPrimPos ? '+' : ''}₹${primaryVal.toStringAsFixed(2)}';
                    secondaryFmt = '(${isPrimPos ? '+' : ''}${secondaryVal.toStringAsFixed(2)}%)';
                    break;
                  case 2: // Day Change %
                    primaryVal = holding.dayChange;
                    secondaryVal = holding.dayChangePercent;
                    isPrimPos = primaryVal >= 0;
                    primaryFmt = '${isPrimPos ? '+' : ''}₹${primaryVal.toStringAsFixed(2)}';
                    secondaryFmt = '(${isPrimPos ? '+' : ''}${secondaryVal.toStringAsFixed(2)}%)';
                    break;
                  default: // Current / Invested
                    primaryVal = holding.currentValue;
                    secondaryVal = holding.investedValue;
                    isPrimPos = holding.pnl >= 0;
                    primaryFmt = '₹${primaryVal.toStringAsFixed(2)}';
                    secondaryFmt = '(₹${secondaryVal.toStringAsFixed(2)})';
                }

                final primaryColor = mode == 0
                    ? (isPrimPos ? customTheme.palette.common.success.main : customTheme.palette.common.error.main)
                    : (isPrimPos ? customTheme.palette.common.success.main : customTheme.palette.common.error.main);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      primaryFmt,
                      style: baseTheme.textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      secondaryFmt,
                      style: baseTheme.textTheme.bodySmall?.copyWith(
                        color: customTheme.palette.text.secondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
}
