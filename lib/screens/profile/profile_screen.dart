import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/screens/funds/widgets/add_withdraw_sheet.dart';
import 'package:minimals/services/log_out_services.dart';
import 'package:minimals/theme/use_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = useTheme(context).customTheme;
    final storage = GetStorage();

    // Read stored user data
    Map<String, dynamic> userData = {};
    try {
      final raw = storage.read<String>(StorageKeys.userProfileData);
      if (raw != null && raw.isNotEmpty) {
        userData = Map<String, dynamic>.from(jsonDecode(raw));
      }
    } catch (_) {}

    final name = userData['name']?.toString() ?? userData['full_name']?.toString() ?? 'Trader';
    final email = userData['email']?.toString() ?? '';
    final photo = userData['profile_image']?.toString() ?? '';

    // Get or lazily create FundsMainController so wallet shows live balance
    final fundsCtrl = Get.isRegistered<FundsMainController>() ? Get.find<FundsMainController>() : Get.put(FundsMainController());

    return Scaffold(
      backgroundColor: customTheme.palette.background.defaultColor,
      appBar: AppBar(
        backgroundColor: customTheme.palette.background.defaultColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: customTheme.palette.text.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: customTheme.palette.text.primary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          // ── Avatar header ────────────────────────────────────────────────
          Container(
            color: customTheme.palette.background.paper,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.primaryColor.withOpacity(0.3), width: 2),
                  ),
                  child: ClipOval(
                    child: photo.isNotEmpty ? Image.network(photo, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _avatarPlaceholder(theme, name)) : _avatarPlaceholder(theme, name),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      if (email.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(email, style: theme.textTheme.bodySmall?.copyWith(color: customTheme.palette.text.secondary)),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Navigation menu ──────────────────────────────────────────────
          _SectionHeader('Portfolio', theme),
          _MenuTile(
            icon: Icons.show_chart_rounded,
            label: 'Holdings',
            subtitle: 'Your stocks & P&L',
            color: const Color(0xFF36B37E),
            onTap: () => Get.offNamedUntil(Routes.holdings, (r) => false),
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.bookmark_rounded,
            label: 'Watchlists',
            subtitle: 'Manage your watchlists',
            color: const Color(0xFF3366FF),
            onTap: () => Get.offNamedUntil(Routes.watchlist, (r) => false),
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.receipt_long_rounded,
            label: 'Past Orders',
            subtitle: 'Order history',
            color: const Color(0xFFFFAB00),
            onTap: () => Get.offNamedUntil(Routes.funds, (r) => false),
            theme: theme,
          ),

          const SizedBox(height: 8),

          _SectionHeader('Settings', theme),
          _MenuTile(
            icon: Icons.settings_rounded,
            label: 'App Settings',
            subtitle: 'Theme, notifications & more',
            color: const Color(0xFF637381),
            onTap: () => Get.toNamed(Routes.settings),
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.help_outline_rounded,
            label: 'Help & Support',
            subtitle: 'FAQs and contact',
            color: const Color(0xFF00B8D9),
            onTap: () => Get.snackbar('Help', 'Help centre — coming soon', snackPosition: SnackPosition.BOTTOM),
            theme: theme,
          ),

          const SizedBox(height: 8),

          // ── Logout ───────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: OutlinedButton.icon(
              onPressed: () => _confirmLogout(context),
              icon: const Icon(Icons.logout_rounded, size: 18, color: Color(0xFFFF5630)),
              label: const Text('Log Out', style: TextStyle(color: Color(0xFFFF5630), fontWeight: FontWeight.w700)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF5630), width: 1),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarPlaceholder(ThemeData theme, String name) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'T';
    return Container(
      color: theme.primaryColor.withOpacity(0.12),
      alignment: Alignment.center,
      child: Text(initial, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: theme.primaryColor)),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              final logoutService = GetIt.instance<LogOutServices>();
              logoutService.logOut(context, () {});
            },
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFFF5630)),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, this.theme);
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Text(title.toUpperCase(), style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.8, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5))),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.theme,
  });
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(label, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6), fontSize: 11)),
      trailing: Icon(Icons.chevron_right_rounded, color: theme.dividerColor, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}
