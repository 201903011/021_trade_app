import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/screens/holdings/widgets/holding_action_sheet.dart';
import 'package:minimals/screens/holdings/widgets/holding_row_card.dart';
import 'package:minimals/screens/holdings/widgets/holdings_sort_bar.dart';
import 'package:minimals/screens/holdings/widgets/holdings_summary_header.dart';
import 'package:minimals/screens/holdings/widgets/no_holding_found.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';

class HoldingMain extends StatelessWidget {
  HoldingMain({super.key});
  final holdingController = Get.put(HoldingMainController());

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Stack(
      children: [
        Scaffold(
          appBar: AppHeaderBar(title: 'Holdings', showWalletBalance: true),
          body: RefreshIndicator(
            onRefresh: holdingController.reload,
            child: Obx(() {
              final sorted = holdingController.sortedHoldings();

              if (!holdingController.isLoading.value && sorted.isEmpty) {
                return const NoHoldingFound();
              }

              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: HoldingsSummaryHeader(controller: holdingController),
                  ),
                  SliverToBoxAdapter(
                    child: HoldingsSortBar(controller: holdingController),
                  ),
                  SliverToBoxAdapter(child: Divider(height: 0.5, color: baseTheme.dividerColor)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) {
                        final h = sorted[i];
                        final stock = StockModel.stockMap[h.symbol];
                        if (stock == null) return const SizedBox.shrink();
                        return HoldingRowCard(
                          key: ValueKey(h.symbol),
                          holding: h,
                          onTap: () => showHoldingActionSheet(context, h, stock),
                        );
                      },
                      childCount: sorted.length,
                    ),
                  ),
                ],
              );
            }),
          ),
          bottomNavigationBar: const AppBottomTabs(),
        ),
        AppLoader(isLoading: holdingController.isLoading),
      ],
    );
  }
}
