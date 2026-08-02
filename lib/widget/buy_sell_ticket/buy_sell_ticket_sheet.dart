import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/widget/buy_sell_ticket/buy_sell_controller.dart';

/// Call this to open the Buy/Sell bottom sheet from anywhere in the app.
void showBuySellTicket(BuildContext context, StockModel stock) {
  final tag = 'bst_${stock.symbol}_${DateTime.now().millisecondsSinceEpoch}';
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _BuySellSheet(stock: stock, tag: tag),
  ).then((_) {
    // Clean up controller after sheet closes
    if (Get.isRegistered<BuySellController>(tag: tag)) {
      Get.delete<BuySellController>(tag: tag);
    }
  });
}

class _BuySellSheet extends StatelessWidget {
  const _BuySellSheet({required this.stock, required this.tag});

  final StockModel stock;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(BuySellController(stock: stock), tag: tag);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(stock.symbol, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    Text(stock.name, style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
                  ],
                ),
                const Spacer(),
                Obx(() => Text(
                      '₹${stock.lastPrice.value.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Buy/Sell toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Row(children: [
                    _ToggleTab(label: 'BUY', isActive: ctrl.isBuy.value, activeColor: const Color(0xFF36B37E), onTap: () => ctrl.isBuy.value = true),
                    _ToggleTab(label: 'SELL', isActive: !ctrl.isBuy.value, activeColor: const Color(0xFFFF5630), onTap: () => ctrl.isBuy.value = false),
                  ]),
                )),
          ),

          const SizedBox(height: 12),

          // Live order value
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              final qty = double.tryParse(ctrl.qtyCtrl.text.trim()) ?? 0;
              final val = (qty * stock.lastPrice.value);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Value', style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
                  Text('₹${val.toStringAsFixed(2)}', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                ],
              );
            }),
          ),

          const SizedBox(height: 12),

          // Quantity input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: ctrl.qtyCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => ctrl.errorMsg.value = '',
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),

          // Error text
          Obx(() {
            if (ctrl.errorMsg.value.isEmpty) return const SizedBox(height: 4);
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: Text(ctrl.errorMsg.value, style: const TextStyle(color: Color(0xFFFF5630), fontSize: 12)),
            );
          }),

          const SizedBox(height: 16),

          // Submit button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: Obx(() => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: ctrl.isSubmitting.value
                        ? null
                        : () async {
                            final ok = await ctrl.submit();
                            if (ok && context.mounted) {
                              Navigator.of(context).pop();
                              Get.snackbar(
                                'Order Placed',
                                '${ctrl.isBuy.value ? 'Bought' : 'Sold'} ${ctrl.qtyCtrl.text} ${stock.symbol} @ ₹${stock.lastPrice.value.toStringAsFixed(2)}',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: const Color(0xFF36B37E),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ctrl.isBuy.value ? const Color(0xFF36B37E) : const Color(0xFFFF5630),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: ctrl.isSubmitting.value
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Text(
                            ctrl.isBuy.value ? 'Place Buy Order' : 'Place Sell Order',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class _ToggleTab extends StatelessWidget {
  const _ToggleTab({
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: isActive ? Colors.white : theme.textTheme.bodySmall?.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
