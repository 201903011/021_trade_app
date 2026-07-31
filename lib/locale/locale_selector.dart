import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/locale/index.dart';

/// Compact locale selector for headers and toolbars
class LocaleSelector extends StatelessWidget {
  final bool showLabel;
  final Color? iconColor;
  final double iconSize;
  final EdgeInsets padding;
  final String? tooltip;

  const LocaleSelector({
    super.key,
    this.showLabel = true,
    this.iconColor,
    this.iconSize = 20,
    this.padding = const EdgeInsets.all(8.0),
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (controller) {
        final currentLang = allLangs.firstWhere(
          (lang) => lang.value == controller.currentLang.value,
          orElse: () => allLangs.first,
        );

        return PopupMenuButton<String>(
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tooltip: tooltip ?? 't_language'.tr,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language,
                  size: iconSize,
                  color: iconColor ?? Theme.of(context).iconTheme.color,
                ),
                if (showLabel) ...[
                  const SizedBox(width: 4),
                  Text(
                    currentLang.label,
                    style: TextStyle(
                      color: iconColor ?? Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 12,
                    ),
                  ),
                ],
                if (showLabel)
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: iconColor ?? Theme.of(context).iconTheme.color,
                  ),
              ],
            ),
          ),
          itemBuilder: (context) => allLangs.map((lang) {
            final isSelected = controller.currentLang.value == lang.value;
            return PopupMenuItem<String>(
              value: lang.value,
              child: Row(
                children: [
                  Icon(
                    Icons.flag,
                    size: 18,
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    lang.label,
                    style: TextStyle(
                      color: isSelected ? Theme.of(context).primaryColor : null,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            );
          }).toList(),
          onSelected: (String value) {
            controller.changeLanguage(value);
          },
        );
      },
    );
  }
}
