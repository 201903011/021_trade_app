import 'dart:convert';
import 'package:minimals/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
    var userProfileData = jsonDecode(storage.read<String>(StorageKeys.userProfileData) ?? '{}');
    return AppBar(
      // backgroundColor: AppColors.white,
      // surfaceTintColor: AppColors.white,
      title: Row(
        children: [
          Text(
            title,
            // style: AppTextStyles.medium24.copyWith(color: AppColors.charcoal),
          ),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
      actions: <Widget>[
        _buildIconProfile(userProfileData['profile_image'] ?? "", () async {
          // Get.toNamed(Routes.profileMain);
        }, margin: const EdgeInsets.symmetric(horizontal: 8), withBackground: false),
      ],
    );
  }

  Widget _buildIcon(String assetPath, VoidCallback onTap, {EdgeInsets? margin, bool withBackground = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: withBackground ? const EdgeInsets.all(4) : EdgeInsets.zero,
        decoration: withBackground
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                ),
              )
            : null,
        child: Icon(Icons.search),
      ),
    );
  }

  Widget _buildIconProfile(String assetPath, VoidCallback onTap, {EdgeInsets? margin, bool withBackground = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        margin: margin,
        padding: withBackground ? const EdgeInsets.all(4) : EdgeInsets.zero,
        child: Icon(Icons.person, size: 36),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
