import 'package:flutter/material.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';

void showAddStockPickerSheet(
  BuildContext context,
  WatchListMainController controller,
  String watchlistId,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _AddStockPickerSheet(
      controller: controller,
      watchlistId: watchlistId,
    ),
  );
}

class _AddStockPickerSheet extends StatelessWidget {
  const _AddStockPickerSheet({
    required this.controller,
    required this.watchlistId,
  });

  final WatchListMainController controller;
  final String watchlistId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollCtrl) {
        return Column(
          children: [
            // Handle
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Text('Add Stocks', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: StockModel.allStocks.length,
                itemBuilder: (_, i) {
                  final stock = StockModel.allStocks[i];
                  final isAdded = controller.isStockInWatchlist(watchlistId, stock.symbol);

                  return ListTile(
                    onTap: () {
                      if (isAdded) {
                        controller.removeStock(watchlistId, stock.symbol);
                      } else {
                        controller.addStock(watchlistId, stock.symbol);
                      }
                    },
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          stock.symbol.substring(0, 2),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      stock.symbol,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      stock.name,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isAdded ? theme.primaryColor : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isAdded ? theme.primaryColor : theme.dividerColor,
                          width: 1.5,
                        ),
                      ),
                      child: isAdded ? const Icon(Icons.check_rounded, size: 16, color: Colors.white) : const Icon(Icons.add_rounded, size: 16, color: Colors.transparent),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
