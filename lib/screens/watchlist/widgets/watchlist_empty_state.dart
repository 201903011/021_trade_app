import 'package:flutter/material.dart';
import 'package:minimals/components/index.dart';
import 'package:minimals/theme/overrides/index.dart';
import 'package:minimals/theme/use_theme.dart';

class WatchlistEmptyState extends StatelessWidget {
  const WatchlistEmptyState({super.key, required this.onAddTap});

  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: customTheme.palette.common.primary.main.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 40,
                color: customTheme.palette.common.primary.main,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No stocks yet',
              style: baseTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Add stocks to track their live prices here.',
              textAlign: TextAlign.center,
              style: baseTheme.textTheme.bodySmall?.copyWith(
                color: baseTheme.textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              onPressed: onAddTap,
              variant: ButtonVariant.outlined,
              icon: Icons.add_rounded,
              text: 'Add Stocks',
              size: ButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }
}
