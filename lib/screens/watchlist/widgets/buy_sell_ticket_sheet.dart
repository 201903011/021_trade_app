import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/theme/use_theme.dart';

void showBuySellTicket(BuildContext context, StockModel stock) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _BuySellTicketSheet(stock: stock),
  );
}

class _BuySellTicketSheet extends StatefulWidget {
  const _BuySellTicketSheet({required this.stock});
  final StockModel stock;

  @override
  State<_BuySellTicketSheet> createState() => _BuySellTicketSheetState();
}

class _BuySellTicketSheetState extends State<_BuySellTicketSheet> {
  bool _isBuy = true;
  final _qtyCtrl = TextEditingController(text: '1');

  @override
  void dispose() {
    _qtyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;
    final stock = widget.stock;

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
              decoration: BoxDecoration(
                color: baseTheme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header: symbol + price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.symbol,
                      style: baseTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      stock.name,
                      style: baseTheme.textTheme.bodySmall?.copyWith(
                        color: baseTheme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Obx(() => Text(
                      '₹${stock.lastPrice.value.toStringAsFixed(2)}',
                      style: baseTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Buy / Sell toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: baseTheme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: baseTheme.dividerColor),
              ),
              child: Row(
                children: [
                  _ToggleTab(
                    label: 'BUY',
                    isActive: _isBuy,
                    activeColor: const Color(0xFF36B37E),
                    onTap: () => setState(() => _isBuy = true),
                  ),
                  _ToggleTab(
                    label: 'SELL',
                    isActive: !_isBuy,
                    activeColor: const Color(0xFFFF5630),
                    onTap: () => setState(() => _isBuy = false),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Quantity input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Place Order button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isBuy ? const Color(0xFF36B37E) : const Color(0xFFFF5630),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  _isBuy ? 'Place Buy Order' : 'Place Sell Order',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
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
