import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/locale/index.dart';

/// Language selector widget
class LanguageSelector extends StatelessWidget {
  final bool showFlags;
  final bool showLabels;
  final MainAxisAlignment alignment;
  final EdgeInsets padding;

  const LanguageSelector({
    super.key,
    this.showFlags = true,
    this.showLabels = true,
    this.alignment = MainAxisAlignment.center,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (controller) {
        return Padding(
          padding: padding,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 8.0,
            children: allLangs.map((lang) {
              final isSelected = controller.currentLang.value == lang.value;

              return GestureDetector(
                onTap: () => controller.changeLanguage(lang.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.3),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showFlags && lang.icon.isNotEmpty) ...[
                        // For now, show a placeholder flag icon
                        // You can replace this with actual flag images
                        Icon(
                          Icons.flag,
                          size: 20,
                          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                        if (showLabels) const SizedBox(width: 8),
                      ],
                      if (showLabels)
                        Text(
                          lang.label,
                          style: TextStyle(
                            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

/// Dropdown language selector
class LanguageDropdown extends StatelessWidget {
  final bool showFlags;
  final String? hint;
  final EdgeInsets padding;

  const LanguageDropdown({
    super.key,
    this.showFlags = true,
    this.hint,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (controller) {
        return Padding(
          padding: padding,
          child: DropdownButtonFormField<String>(
            value: controller.currentLang.value,
            hint: Text(hint ?? controller.translate('language')),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
            ),
            items: allLangs.map((lang) {
              return DropdownMenuItem<String>(
                value: lang.value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showFlags && lang.icon.isNotEmpty) ...[
                      Icon(
                        Icons.flag,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(lang.label),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.changeLanguage(newValue);
              }
            },
          ),
        );
      },
    );
  }
}

/// Language selector dialog
class LanguageSelectorDialog extends StatelessWidget {
  final String? title;
  final bool showFlags;

  const LanguageSelectorDialog({
    super.key,
    this.title,
    this.showFlags = true,
  });

  static Future<void> show(
    BuildContext context, {
    String? title,
    bool showFlags = true,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => LanguageSelectorDialog(
        title: title,
        showFlags: showFlags,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (controller) {
        return AlertDialog(
          title: Text(title ?? controller.translate('language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: allLangs.map((lang) {
              final isSelected = controller.currentLang.value == lang.value;

              return ListTile(
                leading: showFlags && lang.icon.isNotEmpty
                    ? Icon(
                        Icons.flag,
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                      )
                    : null,
                title: Text(
                  lang.label,
                  style: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : null,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                onTap: () {
                  controller.changeLanguage(lang.value);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(controller.translate('close')),
            ),
          ],
        );
      },
    );
  }
}
