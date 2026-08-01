import 'package:flutter/material.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';
import 'package:minimals/theme/use_theme.dart';

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

class _AddStockPickerSheet extends StatefulWidget {
  const _AddStockPickerSheet({
    required this.controller,
    required this.watchlistId,
  });

  final WatchListMainController controller;
  final String watchlistId;

  @override
  State<_AddStockPickerSheet> createState() => _AddStockPickerSheetState();
}

class _AddStockPickerSheetState extends State<_AddStockPickerSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

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
                  color: baseTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Text('Add Stocks',
                      style: baseTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: baseTheme.dividerColor, thickness: 0.5),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: StockModel.allStocks.length,
                itemBuilder: (_, i) {
                  final stock = StockModel.allStocks[i];
                  final isAdded = widget.controller.isStockInWatchlist(widget.watchlistId, stock.symbol);

                  return ListTile(
                    onTap: () {
                      if (isAdded) {
                        widget.controller.removeStock(widget.watchlistId, stock.symbol);
                      } else {
                        widget.controller.addStock(widget.watchlistId, stock.symbol);
                      }
                      setState(() {});
                    },
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: customTheme.palette.common.primary.lighter,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: stock != null && stock.imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                stock.imageUrl,
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.show_chart_rounded, size: 22, color: customTheme.palette.common.primary.light),
                              ),
                            )
                          : Icon(Icons.show_chart_rounded, size: 22, color: customTheme.palette.common.primary.main),
                    ),
                    title: Text(
                      stock.symbol,
                      style: baseTheme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      stock.name,
                      style: baseTheme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isAdded ? baseTheme.primaryColor : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isAdded ? baseTheme.primaryColor : baseTheme.dividerColor,
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
