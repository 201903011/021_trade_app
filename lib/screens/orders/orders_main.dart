import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minimals/models/order_model.dart';
import 'package:minimals/screens/funds/widgets/transaction_filter_sheet.dart';
import 'package:minimals/screens/orders/controller/orders_controller.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';

class OrdersMain extends StatelessWidget {
  OrdersMain({super.key});

  final ordersController = Get.put(OrdersMainController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppHeaderBar(title: 'Orders', showWalletBalance: true),
          body: RefreshIndicator(
            onRefresh: ordersController.reload,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── Past Orders header ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Row(
                          children: [
                            Text('Past Orders', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                            const SizedBox(width: 8),
                            if (ordersController.orders.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${ordersController.orders.length}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            // Active filter chip
                            Obx(() {
                              final label = ordersController.activeFilterLabel;
                              if (label == null) return const SizedBox.shrink();
                              return GestureDetector(
                                onTap: () => ordersController.clearFilter(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: theme.primaryColor.withOpacity(0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w600)),
                                      const SizedBox(width: 4),
                                      Icon(Icons.close_rounded, size: 14, color: theme.primaryColor),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            // Filter icon button
                            GestureDetector(
                              onTap: () => TransactionFilterSheet.show(
                                context: context,
                                initialFrom: ordersController.filterFrom.value,
                                initialTo: ordersController.filterTo.value,
                                onApply: (from, to) {
                                  if (from == null && to == null) {
                                    ordersController.clearFilter();
                                  } else {
                                    ordersController.setDateFilter(from, to);
                                  }
                                },
                              ),
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: theme.dividerColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.filter_list_rounded, size: 18, color: theme.textTheme.bodySmall?.color),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),

                // ── Order list ──────────────────────────────────────────
                Obx(() {
                  final orders = ordersController.orders;
                  if (orders.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.receipt_long_outlined, size: 48, color: theme.dividerColor),
                            const SizedBox(height: 12),
                            Text('No orders yet', style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.5))),
                            const SizedBox(height: 4),
                            Text(
                              'Your buy & sell orders will appear here',
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.35)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _OrderTile(order: orders[i], theme: theme),
                      childCount: orders.length,
                    ),
                  );
                }),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomTabs(),
        ),
        AppLoader(isLoading: ordersController.isLoading),
      ],
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order, required this.theme});

  final OrderModel order;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isBuy = order.side == OrderSide.buy;
    final color = isBuy ? const Color(0xFF36B37E) : const Color(0xFFFF5630);
    final isLimit = order.orderType == OrderType.limit;
    final fmt = DateFormat('dd MMM yy, hh:mm a');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor, width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(isBuy ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${isBuy ? 'BUY' : 'SELL'} ${order.symbol}', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                    if (isLimit) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3366FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('LIMIT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF3366FF))),
                      ),
                    ],
                  ],
                ),
                Text('${order.quantity.toStringAsFixed(order.quantity == order.quantity.floorToDouble() ? 0 : 2)} shares @ ₹${order.price.toStringAsFixed(2)}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
                Text(fmt.format(order.createdAt), style: theme.textTheme.labelSmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.4))),
              ],
            ),
          ),
          Text(
            '${isBuy ? '-' : '+'}₹${order.orderValue.toStringAsFixed(2)}',
            style: theme.textTheme.titleSmall?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
