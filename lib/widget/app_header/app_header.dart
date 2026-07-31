import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/theme/use_theme.dart';

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCrownShow;
  final bool isbellIconShow;

  AppHeaderBar({
    super.key,
    required this.title,
    this.isCrownShow = false,
    this.isbellIconShow = false,
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
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: customTheme.palette.text.primary,
        ),
      ),
      actions: <Widget>[
        if (isCrownShow) _buildIcon(context, Icons.emoji_events_outlined, () {}, margin: const EdgeInsets.only(right: 6)),
        if (isbellIconShow) _buildIcon(context, Icons.notifications_none_rounded, () {}, margin: const EdgeInsets.only(right: 6)),
        _buildIconProfile(context, userProfileData['profile_image']?.toString() ?? '', () {}, margin: const EdgeInsets.only(left: 4, right: 12)),
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
