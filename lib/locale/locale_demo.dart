import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/locale/index.dart';

/// Demo screen showing how to use the new locale system
class LocaleDemo extends StatelessWidget with LocaleMixin {
  const LocaleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('demo.title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              LanguageSelectorDialog.show(context);
            },
          ),
        ],
      ),
      body: GetBuilder<LocaleController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current language info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Language Info',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text('Language: ${controller.currentLang.label}'),
                        Text('Locale: ${controller.currentLang.locale}'),
                        Text('Direction: ${controller.textDirection}'),
                        Text('Is RTL: ${controller.isRTL}'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Demo translations
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Demo Translations',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(tr('demo.introduction')),
                        const SizedBox(height: 16),
                        Text(
                          '${tr('docs.hi')}! ${tr('docs.description')}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Language selector widgets
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Language Selectors',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Text('Horizontal Selector:'),
                        const LanguageSelector(),
                        const SizedBox(height: 16),
                        Text('Dropdown Selector:'),
                        const LanguageDropdown(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Common translations
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Common Translations',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: ['login', 'logout', 'welcome', 'home', 'settings', 'save', 'cancel', 'submit', 'delete', 'edit', 'search', 'filter', 'loading', 'success', 'error']
                              .map((key) => Chip(
                                    label: Text('$key: ${tr(key)}'),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Direction test
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Direction Test',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${tr('previous')} ←'),
                              Text(tr('home')),
                              Text('→ ${tr('next')}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
