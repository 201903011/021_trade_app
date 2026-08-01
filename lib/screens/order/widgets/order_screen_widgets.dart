import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/order/controller/order_controller.dart';

class LttLtpRow extends StatelessWidget {
  const LttLtpRow({required this.stock, required this.theme});
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

class MarketDepthCard extends StatelessWidget {
  const MarketDepthCard({required this.stock, required this.theme});
  final StockModel stock;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text('Market Depth', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Expanded(child: Text('Buying at', style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                SizedBox(width: 56, child: Text('Qty.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                Expanded(child: Text('Selling at', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
                SizedBox(width: 56, child: Text('Qty.', textAlign: TextAlign.right, style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5)))),
              ],
            ),
          ),
          const Divider(height: 1),
          ...List.generate(5, (i) => DepthRow(stock: stock, index: i, theme: theme, isFirst: i == 0)),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class DepthRow extends StatelessWidget {
  const DepthRow({required this.stock, required this.index, required this.theme, required this.isFirst});
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

class OrderInputRow extends StatelessWidget {
  const OrderInputRow({required this.ctrl, required this.theme, required this.customTheme});
  final OrderController ctrl;
  final ThemeData theme;
  final dynamic customTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No. of stocks', style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
              const SizedBox(height: 6),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.dividerColor),
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
              Text('Price', style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
              const SizedBox(height: 6),
              Obx(() => Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      border: Border.all(color: theme.dividerColor),
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

class StepperBtn extends StatelessWidget {
  const StepperBtn({required this.icon, required this.color, required this.onTap});
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

class TotalAmtCard extends StatelessWidget {
  const TotalAmtCard({required this.ctrl, required this.theme, required this.customTheme});
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
            Text('Total Investment Amt.', style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
            const SizedBox(height: 4),
            Text('₹${value.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: customTheme.palette.text.primary)),
          ],
        ),
      );
    });
  }
}

class MarketLimitToggle extends StatelessWidget {
  const MarketLimitToggle({required this.ctrl});
  final OrderController ctrl;

  static const _kMarketColor = Color(0xFF36B37E);
  static const _kLimitColor = Color(0xFF3366FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() => Container(
          height: 44,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(children: [
            ModeTab(label: 'Market', isActive: ctrl.isMarket.value, color: _kMarketColor, onTap: () => ctrl.isMarket.value = true),
            ModeTab(label: 'Limit', isActive: !ctrl.isMarket.value, color: _kLimitColor, onTap: () => ctrl.isMarket.value = false),
          ]),
        ));
  }
}

class ModeTab extends StatelessWidget {
  const ModeTab({required this.label, required this.isActive, required this.color, required this.onTap});
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

class InfoRow extends StatelessWidget {
  const InfoRow({required this.icon, required this.label, required this.value, required this.theme});
  final IconData icon;
  final String label;
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.primaryColor),
          const SizedBox(width: 8),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
          const Spacer(),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
