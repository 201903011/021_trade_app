import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable stepper component
class CustomStepper extends StatelessWidget {
  final List<StepperItem> steps;
  final int currentStep;
  final Axis direction;
  final Function(int)? onStepTapped;
  final EdgeInsetsGeometry? padding;
  final double stepSize;
  final double lineWidth;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? completedColor;
  final StepperType type;

  const CustomStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    this.direction = Axis.horizontal,
    this.onStepTapped,
    this.padding,
    this.stepSize = 32.0,
    this.lineWidth = 2.0,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.type = StepperType.numbered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: direction == Axis.horizontal ? _buildHorizontalStepper(palette) : _buildVerticalStepper(palette),
    );
  }

  Widget _buildHorizontalStepper(dynamic palette) {
    return Row(
      children: _buildStepperItems(palette, true),
    );
  }

  Widget _buildVerticalStepper(dynamic palette) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildStepperItems(palette, false),
    );
  }

  List<Widget> _buildStepperItems(dynamic palette, bool isHorizontal) {
    final List<Widget> items = [];
    final activeColor = this.activeColor ?? palette.common.primary.main;
    final inactiveColor = this.inactiveColor ?? palette.text.disabled;
    final completedColor = this.completedColor ?? palette.common.success.main;

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final isActive = i == currentStep;
      final isCompleted = i < currentStep;
      final isLast = i == steps.length - 1;

      if (isHorizontal) {
        // Add step circle and content
        items.add(
          Expanded(
            child: _buildStepItem(
              step: step,
              index: i,
              isActive: isActive,
              isCompleted: isCompleted,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              completedColor: completedColor,
              palette: palette,
              isHorizontal: true,
            ),
          ),
        );

        // Add connector line if not last
        if (!isLast) {
          items.add(_buildConnectorLine(
            isCompleted: isCompleted,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            completedColor: completedColor,
            isHorizontal: true,
          ));
        }
      } else {
        // Vertical layout
        items.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildStepCircle(
                    index: i,
                    isActive: isActive,
                    isCompleted: isCompleted,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    completedColor: completedColor,
                  ),
                  if (!isLast)
                    _buildConnectorLine(
                      isCompleted: isCompleted,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      completedColor: completedColor,
                      isHorizontal: false,
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
                  child: _buildStepLabel(step, isActive, palette),
                ),
              ),
            ],
          ),
        );
      }
    }

    return items;
  }

  Widget _buildStepItem({
    required StepperItem step,
    required int index,
    required bool isActive,
    required bool isCompleted,
    required Color activeColor,
    required Color inactiveColor,
    required Color completedColor,
    required dynamic palette,
    required bool isHorizontal,
  }) {
    return GestureDetector(
      onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepCircle(
            index: index,
            isActive: isActive,
            isCompleted: isCompleted,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            completedColor: completedColor,
          ),
          if (isHorizontal) ...[
            const SizedBox(height: 8),
            _buildStepLabel(step, isActive, palette),
          ],
        ],
      ),
    );
  }

  Widget _buildStepCircle({
    required int index,
    required bool isActive,
    required bool isCompleted,
    required Color activeColor,
    required Color inactiveColor,
    required Color completedColor,
  }) {
    Color backgroundColor;
    Color contentColor;
    Widget content;

    if (isCompleted) {
      backgroundColor = completedColor;
      contentColor = Colors.white;
      content = const Icon(Icons.check, color: Colors.white, size: 16);
    } else if (isActive) {
      backgroundColor = activeColor;
      contentColor = Colors.white;
      content = _buildStepContent(index, contentColor);
    } else {
      backgroundColor = Colors.transparent;
      contentColor = inactiveColor;
      content = _buildStepContent(index, contentColor);
    }

    return Container(
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? activeColor : inactiveColor,
          width: 2,
        ),
      ),
      child: Center(child: content),
    );
  }

  Widget _buildStepContent(dynamic step, Color color) {
    if (step is int) {
      // Index number
      return Text(
        (step + 1).toString(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      );
    } else if (step is StepperItem) {
      // Step content
      return Text(
        step.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildStepLabel(StepperItem step, bool isActive, dynamic palette) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          step.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? palette.text.primary : palette.text.secondary,
            fontSize: 14,
          ),
        ),
        if (step.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            step.subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.text.secondary,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildConnectorLine({
    required bool isCompleted,
    required Color activeColor,
    required Color inactiveColor,
    required Color completedColor,
    required bool isHorizontal,
  }) {
    final color = isCompleted ? completedColor : inactiveColor;

    if (isHorizontal) {
      return Expanded(
        child: Container(
          height: lineWidth,
          color: color,
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
      );
    } else {
      return Container(
        width: lineWidth,
        height: 24,
        color: color,
      );
    }
  }
}

/// Data class for stepper items
class StepperItem {
  final String title;
  final String? subtitle;
  final Widget? content;
  final bool isClickable;

  const StepperItem({
    required this.title,
    this.subtitle,
    this.content,
    this.isClickable = true,
  });

  StepperItem copyWith({
    String? title,
    String? subtitle,
    Widget? content,
    bool? isClickable,
  }) {
    return StepperItem(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      isClickable: isClickable ?? this.isClickable,
    );
  }
}

/// Stepper type enumeration
enum StepperType {
  numbered,
  dotted,
  icon,
}
