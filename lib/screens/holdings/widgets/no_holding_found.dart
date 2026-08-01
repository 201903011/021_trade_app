import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

class NoHoldingFound extends StatelessWidget {
  const NoHoldingFound({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: baseTheme.primaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.show_chart_rounded, size: 40, color: baseTheme.primaryColor),
                ),
                const SizedBox(height: 20),
                Text('No Holdings Yet', style: baseTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                  'Buy stocks from the Market or Watchlist\nto see them here.',
                  textAlign: TextAlign.center,
                  style: baseTheme.textTheme.bodyMedium?.copyWith(color: baseTheme.textTheme.bodyMedium?.color?.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    ;
  }
}
