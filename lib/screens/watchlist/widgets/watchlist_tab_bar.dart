import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';
import 'package:minimals/theme/use_theme.dart';

class WatchlistTabBar extends StatelessWidget {
  const WatchlistTabBar({super.key, required this.controller});

  final WatchListMainController controller;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Container(
      height: 54 + 15,
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: baseTheme.dividerColor, width: 0.5)),
      ),
      child: Obx(() {
        final watchlists = controller.watchlists;
        final selected = controller.selectedIndex.value;

        return ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            ...List.generate(watchlists.length, (i) {
              final isActive = i == selected;
              return _TabChip(
                label: watchlists[i].name,
                isActive: isActive,
                primaryColor: customTheme.palette.common.primary.main,
                onTap: () => controller.selectWatchlist(i),
              );
            }),
            // "+" add watchlist button
            Center(
              child: GestureDetector(
                onTap: () => _showCreateDialog(context),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: baseTheme.dividerColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded, size: 16, color: baseTheme.textTheme.bodySmall?.color),
                      const SizedBox(width: 4),
                      Text(
                        'New',
                        style: baseTheme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Watchlist'),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Watchlist name'),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isNotEmpty) {
                await controller.createWatchlist(name);
                Get.back();
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.isActive,
    required this.primaryColor,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final Color primaryColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? primaryColor : theme.dividerColor,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: isActive ? Colors.white : theme.textTheme.bodySmall?.color,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
