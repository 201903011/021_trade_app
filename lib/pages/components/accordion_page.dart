import 'package:flutter/material.dart';
import 'package:minimals/components/accordion/index.dart';
import 'package:minimals/components/block/index.dart';
import 'package:minimals/theme/use_theme.dart';

/// Accordion page demonstrating Simple and Controlled accordion variants
/// Equivalent to the React MUI accordion.tsx
class AccordionPage extends StatefulWidget {
  const AccordionPage({super.key});

  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  String? controlledExpandedPanel;

  // Mock data similar to the React version
  final List<AccordionItem> _accordions = [
    AccordionItem(
      id: 'panel1',
      title: 'Accordion 1',
      subtitle: 'Nulla facilisi morbi tempus iaculis',
      content: const Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse '
        'malesuada lacus ex, sit amet blandit leo lobortis eget.',
      ),
      icon: Icons.expand_more,
    ),
    AccordionItem(
      id: 'panel2',
      title: 'Accordion 2',
      subtitle: 'Donec placerat, lectus sed mattis',
      content: const Text(
        'Donec placerat, lectus sed mattis semper, neque lectus feugiat lectus, '
        'varius fermentum mi mi eget elit. Suspendisse potenti.',
      ),
      icon: Icons.expand_more,
    ),
    AccordionItem(
      id: 'panel3',
      title: 'Accordion 3',
      subtitle: 'Morbi mattis ullamcorper velit',
      content: const Text(
        'Morbi mattis ullamcorper velit. Phasellus gravida semper nisi. '
        'Nullam vel sem. Pellentesque libero tortor, tincidunt et.',
      ),
      icon: Icons.expand_more,
    ),
    AccordionItem(
      id: 'panel4',
      title: 'Accordion 4 (Disabled)',
      subtitle: 'Sed non urna facilisis',
      content: const Text(
        'This accordion is disabled and cannot be expanded.',
      ),
      icon: Icons.expand_more,
    ),
  ];

  void _handleControlledChange(String panelId, bool isExpanded) {
    setState(() {
      controlledExpandedPanel = isExpanded ? panelId : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final useTheme = UseTheme(context);
    final palette = useTheme.palette;

    return Scaffold(
      backgroundColor: useTheme.isDark ? palette.background.defaultColor : const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with breadcrumbs
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 8),
              decoration: BoxDecoration(
                color: useTheme.isDark ? palette.background.paper.withOpacity(0.1) : const Color(0xFFEEEEEE),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to components page
                        },
                        child: Text(
                          'Components',
                          style: TextStyle(
                            color: palette.common.primary.main,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        ' / ',
                        style: TextStyle(color: palette.text.secondary),
                      ),
                      Text(
                        'Accordion',
                        style: TextStyle(color: palette.text.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Page title
                  Text(
                    'Accordion',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: palette.text.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // External link
                  TextButton.icon(
                    onPressed: () {
                      // Open MUI documentation
                    },
                    icon: Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: palette.common.primary.main,
                    ),
                    label: Text(
                      'https://mui.com/components/accordion',
                      style: TextStyle(
                        color: palette.common.primary.main,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Simple Accordion Block
                  Block(
                    title: 'Simple',
                    child: CustomAccordion(
                      items: _accordions.map((item) {
                        // Disable the 4th accordion (index 3)
                        if (item.id == 'panel4') {
                          return AccordionItem(
                            id: item.id,
                            title: item.title,
                            subtitle: item.subtitle,
                            content: item.content,
                            icon: item.icon,
                            isExpanded: false,
                          );
                        }
                        return item;
                      }).toList(),
                      allowMultipleExpanded: true,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Controlled Accordion Block
                  Block(
                    title: 'Controlled',
                    child: CustomAccordion(
                      items: _accordions.map((item) {
                        // Disable the 4th accordion (index 3)
                        if (item.id == 'panel4') {
                          return AccordionItem(
                            id: item.id,
                            title: item.title,
                            subtitle: item.subtitle,
                            content: item.content,
                            icon: item.icon,
                            isExpanded: false,
                          );
                        }
                        return item;
                      }).toList(),
                      allowMultipleExpanded: false,
                      expandedPanelId: controlledExpandedPanel,
                      onExpansionChanged: _handleControlledChange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
