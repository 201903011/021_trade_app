import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

class TabImg extends StatelessWidget {
  const TabImg({super.key, required this.icon, this.isActive = false, this.isRoyale = false});

  final IconData icon;
  final bool isActive;
  final bool isRoyale;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final customTheme = theme.customTheme;

    if (isActive) {
      return Container(
        width: 64,
        height: 24,
        decoration: BoxDecoration(
          color: customTheme.palette.background.defaultColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: customTheme.palette.background.defaultColor,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 24,
            color: customTheme.palette.common.primary.main,
          ),
        ),
      );
    }

    return Icon(
      icon,
      size: 24,
      color: customTheme.palette.text.secondary,
    );
  }
}
