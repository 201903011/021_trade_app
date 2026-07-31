import 'dart:async';
import 'package:flutter/material.dart';

// ----------------------------------------------------------------------

class CountdownResult {
  final String days;
  final String hours;
  final String minutes;
  final String seconds;

  const CountdownResult({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

/// Hook-like function for countdown functionality
/// Similar to React's useCountdown hook
class UseCountdown extends ChangeNotifier {
  Timer? _timer;
  CountdownResult _countdown = const CountdownResult(
    days: '00',
    hours: '00',
    minutes: '00',
    seconds: '00',
  );

  CountdownResult get countdown => _countdown;

  UseCountdown(DateTime targetDate) {
    _startCountdown(targetDate);
  }

  void _startCountdown(DateTime targetDate) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCountdown(targetDate);
    });
    // Initial update
    _updateCountdown(targetDate);
  }

  void _updateCountdown(DateTime targetDate) {
    final now = DateTime.now();
    final difference = targetDate.difference(now);

    if (difference.isNegative) {
      _countdown = const CountdownResult(
        days: '00',
        hours: '00',
        minutes: '00',
        seconds: '00',
      );
    } else {
      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      final seconds = difference.inSeconds % 60;

      _countdown = CountdownResult(
        days: days.toString().padLeft(3, '0'),
        hours: hours.toString().padLeft(2, '0'),
        minutes: minutes.toString().padLeft(2, '0'),
        seconds: seconds.toString().padLeft(2, '0'),
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Widget wrapper for countdown functionality
/// Provides a more Flutter-idiomatic approach using a builder pattern
class CountdownBuilder extends StatefulWidget {
  final DateTime targetDate;
  final Widget Function(BuildContext context, CountdownResult countdown) builder;

  const CountdownBuilder({
    super.key,
    required this.targetDate,
    required this.builder,
  });

  @override
  State<CountdownBuilder> createState() => _CountdownBuilderState();
}

class _CountdownBuilderState extends State<CountdownBuilder> {
  late UseCountdown _useCountdown;

  @override
  void initState() {
    super.initState();
    _useCountdown = UseCountdown(widget.targetDate);
  }

  @override
  void didUpdateWidget(CountdownBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetDate != widget.targetDate) {
      _useCountdown.dispose();
      _useCountdown = UseCountdown(widget.targetDate);
    }
  }

  @override
  void dispose() {
    _useCountdown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _useCountdown,
      builder: (context, child) {
        return widget.builder(context, _useCountdown.countdown);
      },
    );
  }
}

/// Static utility function for one-off countdown calculations
CountdownResult calculateCountdown(DateTime targetDate) {
  final now = DateTime.now();
  final difference = targetDate.difference(now);

  if (difference.isNegative) {
    return const CountdownResult(
      days: '00',
      hours: '00',
      minutes: '00',
      seconds: '00',
    );
  }

  final days = difference.inDays;
  final hours = difference.inHours % 24;
  final minutes = difference.inMinutes % 60;
  final seconds = difference.inSeconds % 60;

  return CountdownResult(
    days: days.toString().padLeft(3, '0'),
    hours: hours.toString().padLeft(2, '0'),
    minutes: minutes.toString().padLeft(2, '0'),
    seconds: seconds.toString().padLeft(2, '0'),
  );
}

// Usage example:
// final countdown = CountdownBuilder(
//   targetDate: DateTime(2025, 7, 7, 21, 30),
//   builder: (context, countdown) {
//     return Text('${countdown.days}:${countdown.hours}:${countdown.minutes}:${countdown.seconds}');
//   },
// );
