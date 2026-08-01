import 'package:flutter/material.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/order/widgets/depth_row.dart';

class MarketDepthCard extends StatefulWidget {
  const MarketDepthCard({required this.stock, required this.theme, super.key});

  final StockModel stock;
  final ThemeData theme;

  @override
  State<MarketDepthCard> createState() => _MarketDepthCardState();
}

class _MarketDepthCardState extends State<MarketDepthCard> {
  bool isViewMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.theme.dividerColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Text('Market Depth', style: widget.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isViewMore = !isViewMore;
                    });
                  },
                  child: Text(
                    isViewMore ? 'View Less' : 'View More',
                    style: widget.theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: widget.theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isViewMore,
            child: Column(
              children: [
                Divider(height: 1, color: widget.theme.dividerColor),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(child: Text('Buying at', style: TextStyle(fontSize: 11, color: widget.theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                      SizedBox(width: 56, child: Text('Qty.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: widget.theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                      Expanded(child: Text('Selling at', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: widget.theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                      SizedBox(width: 56, child: Text('Qty.', textAlign: TextAlign.right, style: TextStyle(fontSize: 11, color: widget.theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                    ],
                  ),
                ),
                Divider(height: 1, color: widget.theme.dividerColor),
                ...List.generate(5, (i) => DepthRow(stock: widget.stock, index: i, theme: widget.theme, isFirst: i == 0)),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
