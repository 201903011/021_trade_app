import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/theme/use_theme.dart';

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCrownShow;
  final bool isbellIconShow;
  final bool showWalletBalance;
  final List<Widget>? extraActions;

  AppHeaderBar({
    super.key,
    required this.title,
    this.isCrownShow = false,
    this.isbellIconShow = false,
    this.showWalletBalance = false,
    this.extraActions,
  });

  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final customTheme = theme.customTheme;

    Map<String, dynamic> userProfileData = {};
    try {
      final rawProfileData = storage.read<String>(StorageKeys.userProfileData);
      if (rawProfileData != null && rawProfileData.isNotEmpty) {
        userProfileData = Map<String, dynamic>.from(jsonDecode(rawProfileData));
      }
    } catch (_) {
      userProfileData = {};
    }

    return AppBar(
      backgroundColor: customTheme.palette.background.defaultColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: customTheme.palette.text.primary,
        ),
      ),
      actions: <Widget>[
        if (isbellIconShow) _buildIcon(context, Icons.notifications_none_rounded, () {}, margin: const EdgeInsets.only(right: 6)),
        if (showWalletBalance) _WalletChip(margin: const EdgeInsets.only(right: 6)),
        if (extraActions != null) ...extraActions!,
        _buildIconProfile(context, userProfileData['profile_image']?.toString() ?? '', () => Get.toNamed(Routes.profile), margin: const EdgeInsets.only(left: 4, right: 12)),
      ],
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, VoidCallback onTap, {EdgeInsets? margin}) {
    final customTheme = useTheme(context).customTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        margin: margin,
        decoration: BoxDecoration(
          color: customTheme.palette.background.defaultColor,
          shape: BoxShape.circle,
          border: Border.all(color: customTheme.palette.common.divider, width: 1),
        ),
        child: Icon(icon, size: 20, color: customTheme.palette.text.primary),
      ),
    );
  }

  Widget _buildIconProfile(BuildContext context, String assetPath, VoidCallback onTap, {EdgeInsets? margin}) {
    final customTheme = useTheme(context).customTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        margin: margin,
        decoration: BoxDecoration(
          color: customTheme.palette.background.defaultColor,
          shape: BoxShape.circle,
          border: Border.all(color: customTheme.palette.common.divider, width: 1),
        ),
        child: Center(
          child: assetPath.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    assetPath,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(Icons.person, size: 22, color: customTheme.palette.text.primary),
                  ),
                )
              : Icon(Icons.person, size: 22, color: customTheme.palette.text.primary),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

/// Compact wallet balance chip shown in the AppBar.
/// Reads [FundsMainController] if registered; loads once from repo otherwise.
class _WalletChip extends StatelessWidget {
  const _WalletChip({this.margin});
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double? balance;
    if (Get.isRegistered<FundsMainController>()) {
      balance = Get.find<FundsMainController>().walletBalance.value;
    }

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.funds),
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.primaryColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet_rounded, size: 14, color: theme.primaryColor),
            const SizedBox(width: 4),
            balance != null
                ? Obx(() {
                    final b = Get.find<FundsMainController>().walletBalance.value;
                    return Text(
                      '₹${b >= 100000 ? '${(b / 100000).toStringAsFixed(1)}L' : b >= 1000 ? '${(b / 1000).toStringAsFixed(1)}K' : b.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: theme.primaryColor),
                    );
                  })
                : Text(
                    'Wallet',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.primaryColor),
                  ),
          ],
        ),
      ),
    );
  }
}
