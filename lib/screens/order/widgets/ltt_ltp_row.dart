import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';

class LttLtpRow extends StatelessWidget {
  const LttLtpRow({required this.stock, required this.theme, super.key});

  final StockModel stock;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final lttStr = '${now.day} ${_month(now.month)} ${now.year} · ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} hrs';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LTT', style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5))),
            const SizedBox(height: 2),
            Text(lttStr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: theme.textTheme.bodyMedium?.color)),
          ],
        ),
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('LTP', style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5))),
                const SizedBox(height: 2),
                Text('₹${stock.lastPrice.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: theme.textTheme.bodyMedium?.color)),
              ],
            )),
      ],
    );
  }

  String _month(int m) => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];
}
