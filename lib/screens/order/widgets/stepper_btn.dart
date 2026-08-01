import 'package:flutter/material.dart';

class StepperBtn extends StatelessWidget {
  const StepperBtn({required this.icon, required this.color, required this.onTap, super.key});

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
