import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/order/controller/order_controller.dart';
import 'package:minimals/screens/order/widgets/stepper_btn.dart';
import 'package:minimals/theme/use_theme.dart';

class OrderInputRow extends StatelessWidget {
  const OrderInputRow({required this.ctrl, required this.theme, super.key});

  final OrderController ctrl;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            children: [
              Text('No. of stocks', style: TextStyle(fontSize: 12, color: baseTheme.textTheme.bodySmall?.color?.withOpacity(0.6))),
              const SizedBox(height: 6),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: baseTheme.dividerColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    StepperBtn(
                      icon: Icons.remove,
                      color: const Color(0xFFFF5630),
                      onTap: () {
                        final v = (double.tryParse(ctrl.qtyCtrl.text.trim()) ?? 1) - 1;
                        if (v >= 1) ctrl.qtyCtrl.text = v.toStringAsFixed(v == v.floorToDouble() ? 0 : 2);
                        ctrl.errorMsg.value = '';
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 26,
                        child: TextField(
                          controller: ctrl.qtyCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.center,
                          onChanged: (_) => ctrl.errorMsg.value = '',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: customTheme.palette.text.primary),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    StepperBtn(
                      icon: Icons.add,
                      color: const Color(0xFF36B37E),
                      onTap: () {
                        final v = (double.tryParse(ctrl.qtyCtrl.text.trim()) ?? 0) + 1;
                        ctrl.qtyCtrl.text = v.toStringAsFixed(v == v.floorToDouble() ? 0 : 2);
                        ctrl.errorMsg.value = '';
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: TextStyle(fontSize: 12, color: baseTheme.textTheme.bodySmall?.color?.withOpacity(0.6))),
              const SizedBox(height: 6),
              Obx(() => Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: baseTheme.cardColor,
                      border: Border.all(color: baseTheme.dividerColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '₹${ctrl.stock.lastPrice.value.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: customTheme.palette.text.primary),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
