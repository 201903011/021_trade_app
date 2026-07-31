import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/models/watchlist_model.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';

class WatchlistTabBar extends StatelessWidget {
  const WatchlistTabBar({super.key, required this.controller});

  final WatchListMainController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(bottom: BorderSide(color: theme.dividerColor, width: 0.5)),
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
                primaryColor: primary,
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
                    border: Border.all(color: theme.dividerColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded, size: 16, color: theme.textTheme.bodySmall?.color),
                      const SizedBox(width: 4),
                      Text(
                        'New',
                        style: theme.textTheme.labelSmall,
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
            onPressed: () {
              final name = nameCtrl.text.trim();
              if (name.isNotEmpty) {
                controller.createWatchlist(name);
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
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
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
