import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/screens/funds/widgets/add_withdraw_sheet.dart';
import 'package:minimals/screens/order/controller/order_controller.dart';
import 'package:minimals/screens/order/widgets/info_row.dart';
import 'package:minimals/screens/order/widgets/ltt_ltp_row.dart';
import 'package:minimals/screens/order/widgets/market_depth_card.dart';
import 'package:minimals/screens/order/widgets/market_limit_toggle.dart';
import 'package:minimals/screens/order/widgets/order_input_row.dart';
import 'package:minimals/screens/order/widgets/total_amt_card.dart';
import 'package:minimals/theme/use_theme.dart';

/// Navigate to the Order screen pre-filled with [stock].
void navigateToOrder(StockModel stock, {bool isBuy = true}) {
  Get.toNamed(
    Routes.order,
    arguments: {'symbol': stock.symbol, 'isBuy': isBuy},
  );
}

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final ctrl = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Obx(() {
      final stock = ctrl.stock;
      final isBuy = ctrl.isBuy.value;
      final accentColor = isBuy ? const Color(0xFF36B37E) : const Color(0xFFFF5630);

      return Scaffold(
        backgroundColor: customTheme.palette.background.defaultColor,
        appBar: AppBar(
          backgroundColor: customTheme.palette.background.defaultColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: customTheme.palette.text.primary),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: baseTheme.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: stock.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          stock.imageUrl,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(Icons.show_chart_rounded, size: 22, color: baseTheme.primaryColor),
                        ),
                      )
                    : Icon(Icons.show_chart_rounded, size: 22, color: baseTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: customTheme.palette.text.primary),
                  ),
                  Text(
                    stock.name,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: customTheme.palette.text.secondary),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (ctrl.stock.change.value >= 0 ? const Color(0xFF36B37E) : const Color(0xFFFF5630)).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${ctrl.stock.changePercent.value >= 0 ? '+' : ''}${ctrl.stock.changePercent.value.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ctrl.stock.change.value >= 0 ? const Color(0xFF36B37E) : const Color(0xFFFF5630),
                      ),
                    ),
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LttLtpRow(stock: stock, theme: baseTheme),
              const SizedBox(height: 16),
              MarketDepthCard(stock: stock, theme: baseTheme),
              const SizedBox(height: 16),
              // Fixed BUY/SELL mode badge — not switchable on this screen
              // Obx(() {
              //   final isBuyMode = ctrl.isBuy.value;
              //   final modeColor = isBuyMode ? const Color(0xFF36B37E) : const Color(0xFFFF5630);
              //   return Container(
              //     height: 44,
              //     decoration: BoxDecoration(
              //       color: modeColor.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: modeColor.withOpacity(0.35)),
              //     ),
              //     alignment: Alignment.center,
              //     child: Text(
              //       isBuyMode ? 'BUY' : 'SELL',
              //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: modeColor, letterSpacing: 1.2),
              //     ),
              //   );
              // }),
              const SizedBox(height: 12),
              Obx(() {
                if (ctrl.isBuy.value) {
                  return InfoRow(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Wallet Balance',
                    value: '₹${ctrl.availableBalance.value.toStringAsFixed(2)}',
                    theme: baseTheme,
                  );
                } else {
                  return InfoRow(
                    icon: Icons.bar_chart_rounded,
                    label: 'Holdings',
                    value: '${ctrl.heldQuantity.value.toStringAsFixed(ctrl.heldQuantity.value == ctrl.heldQuantity.value.floorToDouble() ? 0 : 2)} shares',
                    theme: baseTheme,
                  );
                }
              }),
              const SizedBox(height: 16),
              MarketLimitToggle(ctrl: ctrl),
              const SizedBox(height: 16),
              OrderInputRow(
                ctrl: ctrl,
                theme: baseTheme,
              ),
              // Limit price field shown only in Limit mode
              Obx(() {
                if (ctrl.isMarket.value) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextField(
                    controller: ctrl.limitPriceCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => ctrl.errorMsg.value = '',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: customTheme.palette.text.primary),
                    decoration: InputDecoration(
                      labelText: 'Limit Price',
                      prefixText: '\u20b9 ',
                      labelStyle: TextStyle(color: customTheme.palette.text.secondary),
                      filled: true,
                      fillColor: customTheme.palette.background.paper,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: baseTheme.dividerColor)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: baseTheme.dividerColor)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3366FF), width: 1.5)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                );
              }),
              Obx(() {
                if (ctrl.errorMsg.value.isEmpty) return const SizedBox(height: 8);
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 14, color: Color(0xFFFF5630)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(ctrl.errorMsg.value, style: const TextStyle(color: Color(0xFFFF5630), fontSize: 12)),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              TotalAmtCard(ctrl: ctrl, theme: baseTheme, customTheme: customTheme),
              const SizedBox(height: 32),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          final isBuyMode = ctrl.isBuy.value;
          final noHoldings = ctrl.heldQuantity.value <= 0;
          final insufficientFunds = isBuyMode && !ctrl.hasSufficientBalance;
          final disabled = ctrl.isSubmitting.value || (!isBuyMode && noHoldings);

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: disabled
                      ? null
                      : insufficientFunds
                          ? () async {
                              final controller = Get.isRegistered<FundsMainController>() ? Get.find<FundsMainController>() : Get.put(FundsMainController());
                              showAddWithdrawSheet(context, controller, isAdd: true);
                            }
                          : () async {
                              final ok = await ctrl.submit();
                              if (ok) {
                                Get.back();
                                Get.snackbar(
                                  'Order Placed',
                                  '${ctrl.isBuy.value ? 'Bought' : 'Sold'} ${ctrl.qtyCtrl.text} ${stock.symbol} @ ₹${stock.lastPrice.value.toStringAsFixed(2)}',
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: customTheme.palette.common.primary.main,
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 3),
                                  margin: const EdgeInsets.all(12),
                                  borderRadius: 10,
                                );
                              }
                            },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: disabled
                        ? baseTheme.disabledColor
                        : insufficientFunds
                            ? const Color(0xFFFF8C00)
                            : accentColor,
                    disabledBackgroundColor: baseTheme.disabledColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: ctrl.isSubmitting.value
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(
                          insufficientFunds
                              ? 'Add Funds'
                              : isBuyMode
                                  ? 'Place Buy Order'
                                  : 'Place Sell Order',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
