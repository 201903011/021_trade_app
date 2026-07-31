import 'package:flutter/material.dart';
import 'package:minimals/components/button/index.dart';
import 'package:minimals/theme/overrides/button.dart';

/// Example usage of the CustomButton component
class ButtonExamples extends StatelessWidget {
  const ButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contained Button Examples
            const Text(
              'Contained Buttons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Primary contained buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton.contained(
                  text: 'Small',
                  size: ButtonSize.small,
                  onPressed: () {},
                ),
                CustomButton.contained(
                  text: 'Medium',
                  size: ButtonSize.medium,
                  onPressed: () {},
                ),
                CustomButton.contained(
                  text: 'Large',
                  size: ButtonSize.large,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Different color contained buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton.contained(
                  text: 'Primary',
                  color: ButtonColor.primary,
                  onPressed: () {},
                ),
                CustomButton.contained(
                  text: 'Secondary',
                  color: ButtonColor.secondary,
                  onPressed: () {},
                ),
                CustomButton.contained(
                  text: 'Error',
                  color: ButtonColor.error,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Outlined Button Examples
            const Text(
              'Outlined Buttons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton.outlined(
                  text: 'Primary',
                  color: ButtonColor.primary,
                  onPressed: () {},
                ),
                CustomButton.outlined(
                  text: 'Success',
                  color: ButtonColor.success,
                  onPressed: () {},
                ),
                CustomButton.outlined(
                  text: 'Warning',
                  color: ButtonColor.warning,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Text Button Examples
            const Text(
              'Text Buttons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton.text(
                  text: 'Primary',
                  color: ButtonColor.primary,
                  onPressed: () {},
                ),
                CustomButton.text(
                  text: 'Info',
                  color: ButtonColor.info,
                  onPressed: () {},
                ),
                CustomButton.text(
                  text: 'Secondary',
                  color: ButtonColor.secondary,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Special States
            const Text(
              'Special States',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Button with icon
            CustomButton.contained(
              text: 'With Icon',
              icon: Icons.star,
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            // Loading button
            CustomButton.contained(
              text: 'Loading',
              loading: true,
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            // Disabled button
            CustomButton.contained(
              text: 'Disabled',
              disabled: true,
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            // Full width button
            CustomButton.contained(
              text: 'Full Width Button',
              fullWidth: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
