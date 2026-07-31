import 'package:flutter/material.dart';
import 'package:minimals/components/accordion/index.dart';
import 'package:minimals/components/block/index.dart';

/// Example showing how to use Simple and Controlled accordion variants
class AccordionExample extends StatefulWidget {
  const AccordionExample({super.key});

  @override
  State<AccordionExample> createState() => _AccordionExampleState();
}

class _AccordionExampleState extends State<AccordionExample> {
  String? controlledExpanded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accordion Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple Accordion Example (Multiple can be expanded)
            Block(
              title: 'Simple Accordion (Multiple Expansion)',
              child: CustomAccordion(
                allowMultipleExpanded: true,
                items: [
                  AccordionItem(
                    id: 'simple1',
                    title: 'General Settings',
                    subtitle: 'Application configuration',
                    icon: Icons.settings,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Configure your general application settings here.'),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Auto-save enabled'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AccordionItem(
                    id: 'simple2',
                    title: 'Privacy Settings',
                    subtitle: 'Data and privacy controls',
                    icon: Icons.privacy_tip,
                    content: const Text(
                      'Manage your privacy preferences and data sharing settings. '
                      'You can control what information is collected and how it is used.',
                    ),
                  ),
                  AccordionItem(
                    id: 'simple3',
                    title: 'Notifications',
                    subtitle: 'Email and push notifications',
                    icon: Icons.notifications,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Choose which notifications you want to receive:'),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Email notifications'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone_android, color: Colors.orange),
                            SizedBox(width: 8),
                            Text('Push notifications'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Controlled Accordion Example (Only one can be expanded)
            Block(
              title: 'Controlled Accordion (Single Expansion)',
              child: CustomAccordion(
                allowMultipleExpanded: false,
                expandedPanelId: controlledExpanded,
                onExpansionChanged: (panelId, isExpanded) {
                  setState(() {
                    controlledExpanded = isExpanded ? panelId : null;
                  });
                },
                items: [
                  AccordionItem(
                    id: 'controlled1',
                    title: 'Account Information',
                    subtitle: 'Personal details and profile',
                    icon: Icons.account_circle,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Manage your account information and profile settings.'),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Display Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AccordionItem(
                    id: 'controlled2',
                    title: 'Security Settings',
                    subtitle: 'Password and two-factor authentication',
                    icon: Icons.security,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Configure your security settings:'),
                        SizedBox(height: 12),
                        ListTile(
                          leading: Icon(Icons.password),
                          title: Text('Change Password'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        ListTile(
                          leading: Icon(Icons.phonelink_lock),
                          title: Text('Two-Factor Authentication'),
                          trailing: Switch(value: true, onChanged: null),
                        ),
                      ],
                    ),
                  ),
                  AccordionItem(
                    id: 'controlled3',
                    title: 'Billing & Subscription',
                    subtitle: 'Payment methods and plans',
                    icon: Icons.payment,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Plan: Premium'),
                        SizedBox(height: 8),
                        Text('Next billing date: March 15, 2024'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: null,
                          child: Text('Manage Subscription'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Usage Information
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usage Notes:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('• Simple Accordion: Multiple panels can be expanded simultaneously'),
                    Text('• Controlled Accordion: Only one panel can be expanded at a time'),
                    Text('• Both variants support icons, subtitles, and custom content'),
                    Text('• Theme styling is automatically applied based on the current theme'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
