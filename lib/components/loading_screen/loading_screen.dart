import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

class LoadingScreen extends StatefulWidget {
  final Widget? logo;
  final Color? backgroundColor;
  final double logoSize;

  const LoadingScreen({
    Key? key,
    this.logo,
    this.backgroundColor,
    this.logoSize = 64.0,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _firstRingController;
  late AnimationController _secondRingController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  late Animation<double> _firstRingScaleAnimation;
  late Animation<double> _firstRingRotationAnimation;
  late Animation<double> _firstRingOpacityAnimation;

  late Animation<double> _secondRingScaleAnimation;
  late Animation<double> _secondRingRotationAnimation;
  late Animation<double> _secondRingOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // First ring animation controller
    _firstRingController = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    );

    // Second ring animation controller
    _secondRingController = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    );

    // Logo animations
    _logoScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 0.9), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    _logoOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.48), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.48, end: 0.48), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.48, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    // First ring animations
    _firstRingScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.6, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.6), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.6, end: 1.6), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _firstRingController,
      curve: Curves.linear,
    ));

    _firstRingRotationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 270, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0, end: 270), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 270, end: 270), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _firstRingController,
      curve: Curves.linear,
    ));

    _firstRingOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.25, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.25), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _firstRingController,
      curve: Curves.linear,
    ));

    // Second ring animations
    _secondRingScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.2), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _secondRingController,
      curve: Curves.linear,
    ));

    _secondRingRotationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 270), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 270, end: 270), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 270, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0, end: 0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _secondRingController,
      curve: Curves.linear,
    ));

    _secondRingOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.25), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.25, end: 0.25), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.25, end: 0.25), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.25, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _secondRingController,
      curve: Curves.linear,
    ));

    // Start animations
    _logoController.repeat();
    _firstRingController.repeat();
    _secondRingController.repeat();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _firstRingController.dispose();
    _secondRingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final primaryColor = theme.customTheme.palette.common.primary;

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Second ring (outer)
          AnimatedBuilder(
            animation: _secondRingController,
            builder: (context, child) {
              return Transform.scale(
                scale: _secondRingScaleAnimation.value,
                child: Transform.rotate(
                  angle: _secondRingRotationAnimation.value * (3.14159 / 180),
                  child: Opacity(
                    opacity: _secondRingOpacityAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor.main.withOpacity(0.24),
                          width: 8,
                        ),
                        borderRadius: BorderRadius.circular(30), // 25% of 120
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // First ring (middle)
          AnimatedBuilder(
            animation: _firstRingController,
            builder: (context, child) {
              return Transform.scale(
                scale: _firstRingScaleAnimation.value,
                child: Transform.rotate(
                  angle: _firstRingRotationAnimation.value * (3.14159 / 180),
                  child: Opacity(
                    opacity: _firstRingOpacityAnimation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor.main.withOpacity(0.24),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(25), // 25% of 100
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Logo (center)
          AnimatedBuilder(
            animation: _logoController,
            builder: (context, child) {
              return Transform.scale(
                scale: _logoScaleAnimation.value,
                child: Opacity(
                  opacity: _logoOpacityAnimation.value,
                  child: widget.logo ??
                      Container(
                        width: widget.logoSize,
                        height: widget.logoSize,
                        decoration: BoxDecoration(
                          color: primaryColor.main,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.flutter_dash,
                          size: widget.logoSize * 0.6,
                          color: Colors.white,
                        ),
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
