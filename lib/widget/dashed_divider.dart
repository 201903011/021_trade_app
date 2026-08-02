import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        const dashWidth = 5.0;
        const dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(
              count,
              (_) => Padding(
                    padding: const EdgeInsets.only(right: dashSpace),
                    child: Container(width: dashWidth, height: 1, color: color),
                  )),
        );
      },
    );
  }
}
