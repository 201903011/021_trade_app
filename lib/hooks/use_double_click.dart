import 'dart:async';
import 'package:flutter/material.dart';

// ----------------------------------------------------------------------

class DoubleClickConfig {
  final Duration timeout;
  final VoidCallback? onSingleTap;
  final VoidCallback onDoubleTap;

  const DoubleClickConfig({
    this.timeout = const Duration(milliseconds: 250),
    this.onSingleTap,
    required this.onDoubleTap,
  });
}

/// Hook-like function for double click functionality
/// Similar to React's useDoubleClick hook
class UseDoubleClick {
  Timer? _clickTimeout;
  final DoubleClickConfig config;

  UseDoubleClick(this.config);

  void _clearClickTimeout() {
    _clickTimeout?.cancel();
    _clickTimeout = null;
  }

  void handleTap() {
    _clearClickTimeout();

    if (config.onSingleTap != null) {
      _clickTimeout = Timer(config.timeout, () {
        config.onSingleTap!();
      });
    }
  }

  void handleDoubleTap() {
    _clearClickTimeout();
    config.onDoubleTap();
  }

  void dispose() {
    _clearClickTimeout();
  }
}

/// Widget wrapper for double click functionality
/// Provides a more Flutter-idiomatic approach using gesture detection
class DoubleClickDetector extends StatefulWidget {
  final Widget child;
  final Duration timeout;
  final VoidCallback? onSingleTap;
  final VoidCallback onDoubleTap;

  const DoubleClickDetector({
    super.key,
    required this.child,
    this.timeout = const Duration(milliseconds: 250),
    this.onSingleTap,
    required this.onDoubleTap,
  });

  @override
  State<DoubleClickDetector> createState() => _DoubleClickDetectorState();
}

class _DoubleClickDetectorState extends State<DoubleClickDetector> {
  late UseDoubleClick _useDoubleClick;

  @override
  void initState() {
    super.initState();
    _useDoubleClick = UseDoubleClick(DoubleClickConfig(
      timeout: widget.timeout,
      onSingleTap: widget.onSingleTap,
      onDoubleTap: widget.onDoubleTap,
    ));
  }

  @override
  void didUpdateWidget(DoubleClickDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.timeout != widget.timeout || oldWidget.onSingleTap != widget.onSingleTap || oldWidget.onDoubleTap != widget.onDoubleTap) {
      _useDoubleClick.dispose();
      _useDoubleClick = UseDoubleClick(DoubleClickConfig(
        timeout: widget.timeout,
        onSingleTap: widget.onSingleTap,
        onDoubleTap: widget.onDoubleTap,
      ));
    }
  }

  @override
  void dispose() {
    _useDoubleClick.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _useDoubleClick.handleTap,
      onDoubleTap: _useDoubleClick.handleDoubleTap,
      child: widget.child,
    );
  }
}

/// Alternative implementation using Flutter's built-in tap detection
class SmartTapDetector extends StatefulWidget {
  final Widget child;
  final Duration timeout;
  final VoidCallback? onSingleTap;
  final VoidCallback onDoubleTap;

  const SmartTapDetector({
    super.key,
    required this.child,
    this.timeout = const Duration(milliseconds: 250),
    this.onSingleTap,
    required this.onDoubleTap,
  });

  @override
  State<SmartTapDetector> createState() => _SmartTapDetectorState();
}

class _SmartTapDetectorState extends State<SmartTapDetector> {
  Timer? _timer;
  int _tapCount = 0;

  void _handleTap() {
    _tapCount++;

    if (_tapCount == 1) {
      _timer = Timer(widget.timeout, () {
        if (_tapCount == 1 && widget.onSingleTap != null) {
          widget.onSingleTap!();
        }
        _tapCount = 0;
      });
    } else if (_tapCount == 2) {
      _timer?.cancel();
      widget.onDoubleTap();
      _tapCount = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: widget.child,
    );
  }
}

// Usage example:
// DoubleClickDetector(
//   onSingleTap: () => print('Single tap'),
//   onDoubleTap: () => print('Double tap'),
//   child: Container(
//     width: 100,
//     height: 100,
//     color: Colors.blue,
//   ),
// )
