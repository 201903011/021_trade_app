import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';

/// A single row in the market overview. Uses an [AnimatedContainer] to flash
/// green (price up) or red (price down) on each tick, then fades back.
/// Only this widget rebuilds when its stock's price changes.
class MarketStockRow extends StatefulWidget {
  const MarketStockRow({super.key, required this.stock, required this.onTap});

  final StockModel stock;
  final VoidCallback onTap;

  @override
  State<MarketStockRow> createState() => _MarketStockRowState();
}

class _MarketStockRowState extends State<MarketStockRow> with SingleTickerProviderStateMixin {
  late AnimationController _flashCtrl;
  late Animation<Color?> _flashColor;
  double _prevPrice = 0;
  bool _up = true;

  @override
  void initState() {
    super.initState();
    _prevPrice = widget.stock.lastPrice.value;
    _flashCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _flashColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.transparent,
    ).animate(_flashCtrl);

    // Listen to price changes and trigger flash
    ever(widget.stock.lastPrice, (double newPrice) {
      if (!mounted) return;
      _up = newPrice >= _prevPrice;
      _prevPrice = newPrice;
      _flashColor = ColorTween(
        begin: _up ? const Color(0xFF36B37E).withOpacity(0.25) : const Color(0xFFFF5630).withOpacity(0.25),
        end: Colors.transparent,
      ).animate(_flashCtrl);
      _flashCtrl.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _flashCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _flashCtrl,
        builder: (_, child) => Container(
          color: _flashColor.value ?? Colors.transparent,
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Symbol badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: widget.stock.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.stock.imageUrl,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(Icons.show_chart_rounded, size: 22, color: theme.primaryColor),
                        ),
                      )
                    : Icon(Icons.show_chart_rounded, size: 22, color: theme.primaryColor),
              ),
              const SizedBox(width: 12),

              // Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.stock.symbol,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.stock.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Price + change — only this rebuilds on tick
              Obx(() {
                final price = widget.stock.lastPrice.value;
                final change = widget.stock.change.value;
                final pct = widget.stock.changePercent.value;
                final isPos = change >= 0;
                final color = isPos ? const Color(0xFF36B37E) : const Color(0xFFFF5630);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${price.toStringAsFixed(2)}',
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPos ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                          color: color,
                          size: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${isPos ? '+' : ''}${pct.toStringAsFixed(2)}%',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
