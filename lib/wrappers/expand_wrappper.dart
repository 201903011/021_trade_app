import 'package:flutter/material.dart';

class ExpanWrapper extends StatelessWidget {
  const ExpanWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: child,
        ),
      ],
    );
  }
}