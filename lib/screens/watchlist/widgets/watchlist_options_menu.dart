import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';

class WatchlistOptionsMenu extends StatelessWidget {
  const WatchlistOptionsMenu({super.key, required this.controller});

  final WatchListMainController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.watchlists.isEmpty) return const SizedBox.shrink();

      final wl = controller.currentWatchlist!;

      return PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert_rounded),
        onSelected: (value) {
          if (value == 'rename') _showRenameDialog(context, wl.id, wl.name);
          if (value == 'delete') _showDeleteConfirm(context, wl.id, wl.name);
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'rename', child: Text('Rename')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      );
    });
  }

  void _showRenameDialog(BuildContext context, String id, String currentName) {
    final ctrl = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rename Watchlist'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Watchlist name'),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final name = ctrl.text.trim();
              if (name.isNotEmpty) {
                controller.renameWatchlist(id, name);
                Get.back();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, String id, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Watchlist'),
        content: Text('Delete "$name"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.deleteWatchlist(id);
              Get.back();
            },
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFFF5630)),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
