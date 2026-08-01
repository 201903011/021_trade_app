import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/theme/use_theme.dart';

class StockRowCard extends StatelessWidget {
  const StockRowCard({
    super.key,
    required this.stock,
    required this.onTap,
    required this.onRemove,
  });

  final StockModel stock;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: baseTheme.cardColor,
          border: Border(
            bottom: BorderSide(color: baseTheme.dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // Symbol + name
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

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: baseTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stock.name,
                    style: baseTheme.textTheme.bodySmall?.copyWith(
                      color: baseTheme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Price + change
            Obx(() {
              final price = stock.lastPrice.value;
              final change = stock.change.value;
              final changePct = stock.changePercent.value;
              final isPositive = change >= 0;
              final color = isPositive ? const Color(0xFF36B37E) : const Color(0xFFFF5630);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${price.toStringAsFixed(2)}',
                    style: baseTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${isPositive ? '+' : ''}${change.toStringAsFixed(2)} (${isPositive ? '+' : ''}${changePct.toStringAsFixed(2)}%)',
                      style: baseTheme.textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(width: 25),

            // Remove button
            GestureDetector(
              onTap: onRemove,
              child: Icon(Icons.delete, size: 25, color: customTheme.palette.common.error.light),
            ),
          ],
        ),
      ),
    );
  }
}
