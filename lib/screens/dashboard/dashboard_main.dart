import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/dashboard/controller/dashboard_controller.dart';
import 'package:minimals/screens/dashboard/widgets/market_stock_row.dart';
import 'package:minimals/services/market_feed_service.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';
import 'package:minimals/screens/order/order_screen.dart';

class DashboardMain extends StatelessWidget {
  DashboardMain({super.key});
  final controller = Get.put(DashboardMainController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppHeaderBar(title: 'Market', showWalletBalance: true),
          body: Column(
            children: [
              // Tick-rate info chip
              Container(
                color: theme.cardColor,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF36B37E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live · ${kTickIntervalMs ~/ 1000}s ticks',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF36B37E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${StockModel.allStocks.length} stocks',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: theme.dividerColor),
              Expanded(
                child: ListView.separated(
                  itemCount: StockModel.allStocks.length,
                  separatorBuilder: (_, __) => Divider(height: 1, color: theme.dividerColor),
                  itemBuilder: (_, i) {
                    final stock = StockModel.allStocks[i];
                    return MarketStockRow(
                      key: ValueKey(stock.symbol),
                      stock: stock,
                      onTap: () => _openTicket(context, stock),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: const AppBottomTabs(),
        ),
        AppLoader(isLoading: controller.isLoading),
      ],
    );
  }

  void _openTicket(BuildContext context, StockModel stock) {
    navigateToOrder(stock);
  }
}
