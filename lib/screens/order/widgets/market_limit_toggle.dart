import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/components/radio/custom_radio.dart';
import 'package:minimals/screens/order/controller/order_controller.dart';

class MarketLimitToggle extends StatelessWidget {
  const MarketLimitToggle({required this.ctrl, super.key});

  final OrderController ctrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() => Row(children: [
          Expanded(
            child: CustomRadio<bool>(
              label: 'Market',
              value: ctrl.isMarket.value,
              groupValue: true,
              onChanged: (v) {
                if (v == false) ctrl.isMarket.value = true;
              },
            ),
          ),
          Expanded(
            child: CustomRadio<bool>(
              label: 'Limit',
              value: ctrl.isMarket.value,
              groupValue: false,
              onChanged: (v) {
                if (v == true) ctrl.isMarket.value = false;
              },
            ),
          ),
        ]));
  }
}

class ModeTab extends StatelessWidget {
  const ModeTab({required this.label, required this.isActive, required this.color, required this.onTap, super.key});

  final String label;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: double.infinity,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Theme.of(context).textTheme.bodySmall?.color,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
