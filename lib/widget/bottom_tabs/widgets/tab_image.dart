import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimals/theme/use_theme.dart';

class TabImg extends StatelessWidget {
  const TabImg({super.key, required this.imgPath, this.isActive = false, this.isRoyale = false});
  final String imgPath;
  final bool isActive;
  final bool isRoyale;
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    if (isActive) {
      return Container(
        width: 64,
        height: 24,
        // margin: const EdgeInsets.only(top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: customTheme.palette.background.defaultColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: customTheme.palette.background.defaultColor,
            width: 2.0, // Border width
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            imgPath,
            width: 24,
            height: 24,
            color: customTheme.palette.common.primary.main,
          ),
        ),
      );
    } else {
      return SvgPicture.asset(
        imgPath,
        width: 24,
        height: 24,
        color: isActive ? customTheme.palette.common.primary.main : customTheme.palette.text.secondary,
      );
    }
  }
}
