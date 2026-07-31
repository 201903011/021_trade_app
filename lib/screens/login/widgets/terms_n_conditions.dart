import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

class TermsNConditions extends StatelessWidget {
  const TermsNConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Privacy Policy • T & C ',
          style: baseTheme.textTheme.bodyMedium?.copyWith(
            color: customTheme.palette.common.primary.dark,
          ),
        ),
      ],
    );
  }
}
