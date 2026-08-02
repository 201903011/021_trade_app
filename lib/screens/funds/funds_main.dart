import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minimals/models/transaction_model.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/screens/funds/widgets/add_withdraw_sheet.dart';
import 'package:minimals/screens/funds/widgets/transaction_filter_sheet.dart';
import 'package:minimals/widget/app_header/app_header.dart';
import 'package:minimals/widget/app_loader.dart';
import 'package:minimals/widget/bottom_tabs/bottom_tabs_view.dart';

class FundsMain extends StatelessWidget {
  FundsMain({super.key});
  final fundsMainController = Get.put(FundsMainController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppHeaderBar(title: 'Funds', showWalletBalance: true),
          body: RefreshIndicator(
            onRefresh: fundsMainController.reload,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── Wallet balance card ──────────────────────────────────────
                SliverToBoxAdapter(
                  child: Obx(() => Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.primaryColor,
                              theme.primaryColor.withOpacity(0.75),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.account_balance_wallet_rounded, color: Colors.white70, size: 16),
                                const SizedBox(width: 6),
                                Text('Available Balance', style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '₹${fundsMainController.walletBalance.value.toStringAsFixed(2)}',
                              style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 16),
                            // Add / Withdraw buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => showAddWithdrawSheet(context, fundsMainController, isAdd: true),
                                    icon: const Icon(Icons.add_rounded, size: 16),
                                    label: const Text('Add Funds'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: theme.primaryColor,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => showAddWithdrawSheet(context, fundsMainController, isAdd: false),
                                    icon: const Icon(Icons.remove_rounded, size: 16),
                                    label: const Text('Withdraw'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.white54),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),

                // ── Transaction History header ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Row(
                          children: [
                            Text('Transaction History', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                            const SizedBox(width: 8),
                            if (fundsMainController.transactions.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${fundsMainController.transactions.length}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            // Active filter chip
                            Obx(() {
                              final label = fundsMainController.activeFilterLabel;
                              if (label == null) return const SizedBox.shrink();
                              return GestureDetector(
                                onTap: () => fundsMainController.clearFilter(),
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
                                initialFrom: fundsMainController.filterFrom.value,
                                initialTo: fundsMainController.filterTo.value,
                                onApply: (from, to) {
                                  if (from == null && to == null) {
                                    fundsMainController.clearFilter();
                                  } else {
                                    fundsMainController.setDateFilter(from, to);
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

                // ── Transaction list ──────────────────────────────────────────
                Obx(() {
                  final txnList = fundsMainController.transactions;
                  if (txnList.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.receipt_long_outlined, size: 48, color: theme.dividerColor),
                            const SizedBox(height: 12),
                            Text('No transactions yet', style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.5))),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _TransactionTile(transaction: txnList[i], theme: theme),
                      childCount: txnList.length,
                    ),
                  );
                }),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomTabs(),
        ),
        AppLoader(isLoading: fundsMainController.isLoading),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction, required this.theme});

  final TransactionModel transaction;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isAdd = transaction.type == TransactionType.add;
    final color = isAdd ? const Color(0xFF36B37E) : const Color(0xFFFF5630);
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
            child: Icon(
              isAdd ? Icons.add_rounded : Icons.remove_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description ?? (isAdd ? 'Added' : 'Withdrew'),
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  fmt.format(transaction.createdAt),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isAdd ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}',
            style: theme.textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
