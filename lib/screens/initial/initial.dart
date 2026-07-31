import 'package:flutter/material.dart';
import 'package:minimals/components/index.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoadingScreen()),
    );
  }
}
