import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';
import 'package:minimals/screens/watchlist/widgets/add_stock_picker_sheet.dart';
import 'package:minimals/screens/watchlist/widgets/buy_sell_ticket_sheet.dart';
import 'package:minimals/screens/watchlist/widgets/stock_row_card.dart';
import 'package:minimals/screens/watchlist/widgets/watchlist_empty_state.dart';
import 'package:minimals/screens/watchlist/widgets/watchlist_options_menu.dart';
import 'package:minimals/screens/watchlist/widgets/watchlist_tab_bar.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';

class WatchlistMain extends StatelessWidget {
  WatchlistMain({super.key});
  final watchingController = Get.put(WatchListMainController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppHeaderBar(
            title: 'Watchlist',
            extraActions: [
              WatchlistOptionsMenu(controller: watchingController),
            ],
          ),
          body: Column(
            children: [
              WatchlistTabBar(controller: watchingController),
              Expanded(
                child: Obx(() {
                  final wl = watchingController.currentWatchlist;
                  if (wl == null) {
                    return WatchlistEmptyState(
                      onAddTap: () => watchingController.createWatchlist('Watchlist 1'),
                    );
                  }

                  final stocks = watchingController.stocksForWatchlist(wl);

                  if (stocks.isEmpty) {
                    return WatchlistEmptyState(
                      onAddTap: () => showAddStockPickerSheet(context, watchingController, wl.id),
                    );
                  }

                  return ReorderableListView.builder(
                    itemCount: stocks.length,
                    onReorder: (oldIndex, newIndex) => watchingController.reorderStocks(wl.id, oldIndex, newIndex),
                    proxyDecorator: (child, index, animation) => Material(
                      elevation: 4,
                      color: Colors.transparent,
                      child: child,
                    ),
                    itemBuilder: (_, i) {
                      final stock = stocks[i];
                      return StockRowCard(
                        key: ValueKey('${wl.id}_${stock.symbol}'),
                        stock: stock,
                        onTap: () => showBuySellTicket(context, stock),
                        onRemove: () => watchingController.removeStock(wl.id, stock.symbol),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          floatingActionButton: Obx(() {
            final wl = watchingController.currentWatchlist;
            if (wl == null) return const SizedBox.shrink();
            return FloatingActionButton(
              onPressed: () => showAddStockPickerSheet(context, watchingController, wl.id),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add_rounded, color: Colors.white),
            );
          }),
          bottomNavigationBar: const AppBottomTabs(),
        ),
        AppLoader(isLoading: watchingController.isLoading),
      ],
    );
  }
}
