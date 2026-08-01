import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';

class DepthRow extends StatelessWidget {
  const DepthRow({required this.stock, required this.index, required this.theme, required this.isFirst, super.key});

  final StockModel stock;
  final int index;
  final ThemeData theme;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bid = stock.bids[index];
      final ask = stock.asks[index];

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '₹${bid.price.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isFirst ? FontWeight.w700 : FontWeight.w500,
                  color: const Color(0xFF36B37E),
                ),
              ),
            ),
            SizedBox(
              width: 56,
              child: Text(
                '${bid.qty.value}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isFirst ? FontWeight.w700 : FontWeight.w400,
                  color: isFirst ? const Color(0xFF36B37E) : theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '₹${ask.price.value.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isFirst ? FontWeight.w700 : FontWeight.w500,
                  color: const Color(0xFFFF5630),
                ),
              ),
            ),
            SizedBox(
              width: 56,
              child: Text(
                '${ask.qty.value}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isFirst ? FontWeight.w700 : FontWeight.w400,
                  color: isFirst ? const Color(0xFFFF5630) : theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
