import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/order/controller/order_controller.dart';

class TotalAmtCard extends StatelessWidget {
  const TotalAmtCard({required this.ctrl, required this.theme, required this.customTheme, super.key});

  final OrderController ctrl;
  final ThemeData theme;
  final dynamic customTheme;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final qty = double.tryParse(ctrl.qtyCtrl.text.trim()) ?? 0;
      final price = ctrl.isMarket.value ? ctrl.stock.lastPrice.value : (double.tryParse(ctrl.limitPriceCtrl.text.trim()) ?? ctrl.stock.lastPrice.value);
      final value = qty * price;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: customTheme.palette.background.paper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total ${ctrl.isBuy.value ? 'Investment' : 'Redeem'} Amt.', style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
            const SizedBox(height: 4),
            Text('₹${value.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: customTheme.palette.text.primary)),
          ],
        ),
      );
    });
  }
}
