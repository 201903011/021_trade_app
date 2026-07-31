import 'package:flutter/material.dart';

// ----------------------------------------------------------------------

/// Hook-like functionality for tracking scroll offset
/// Similar to React's useOffSetTop hook (from framer-motion)
class UseOffsetTop extends ChangeNotifier {
  final ScrollController _controller;
  final double _threshold;
  bool _isOffsetTop = false;

  bool get isOffsetTop => _isOffsetTop;

  UseOffsetTop({
    required ScrollController controller,
    double threshold = 100,
  })  : _controller = controller,
        _threshold = threshold {
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _controller.offset;
    final newValue = offset > _threshold;

    if (newValue != _isOffsetTop) {
      _isOffsetTop = newValue;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    super.dispose();
  }
}

/// Widget wrapper for offset top functionality
/// Provides a more Flutter-idiomatic approach using a builder pattern
class OffsetTopBuilder extends StatefulWidget {
  final double threshold;
  final ScrollController controller;
  final Widget Function(BuildContext context, bool isOffsetTop) builder;

  const OffsetTopBuilder({
    super.key,
    this.threshold = 100,
    required this.controller,
    required this.builder,
  });

  @override
  State<OffsetTopBuilder> createState() => _OffsetTopBuilderState();
}

class _OffsetTopBuilderState extends State<OffsetTopBuilder> {
  late UseOffsetTop _useOffsetTop;

  @override
  void initState() {
    super.initState();
    _useOffsetTop = UseOffsetTop(
      controller: widget.controller,
      threshold: widget.threshold,
    );
  }

  @override
  void didUpdateWidget(OffsetTopBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller || oldWidget.threshold != widget.threshold) {
      _useOffsetTop.dispose();
      _useOffsetTop = UseOffsetTop(
        controller: widget.controller,
        threshold: widget.threshold,
      );
    }
  }

  @override
  void dispose() {
    _useOffsetTop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _useOffsetTop,
      builder: (context, child) {
        return widget.builder(context, _useOffsetTop.isOffsetTop);
      },
    );
  }
}

/// Simple scroll-aware widget that reacts to scroll position
class ScrollOffsetDetector extends StatefulWidget {
  final double threshold;
  final ScrollController? controller;
  final Widget Function(bool isOffsetTop) builder;

  const ScrollOffsetDetector({
    super.key,
    this.threshold = 100,
    this.controller,
    required this.builder,
  });

  @override
  State<ScrollOffsetDetector> createState() => _ScrollOffsetDetectorState();
}

class _ScrollOffsetDetectorState extends State<ScrollOffsetDetector> {
  bool _isOffsetTop = false;
  ScrollController? _effectiveController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initController();
  }

  @override
  void didUpdateWidget(ScrollOffsetDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _effectiveController?.removeListener(_onScroll);
      _initController();
    }
  }

  void _initController() {
    _effectiveController?.removeListener(_onScroll);
    _effectiveController = widget.controller ?? PrimaryScrollController.of(context);
    _effectiveController?.addListener(_onScroll);
  }

  void _onScroll() {
    if (_effectiveController != null) {
      final offset = _effectiveController!.offset;
      final newValue = offset > widget.threshold;

      if (newValue != _isOffsetTop) {
        setState(() {
          _isOffsetTop = newValue;
        });
      }
    }
  }

  @override
  void dispose() {
    _effectiveController?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_isOffsetTop);
  }
}

/// Extension for easy scroll position checking
extension ScrollControllerOffsetExtension on ScrollController {
  bool isOffsetTop(double threshold) {
    return offset > threshold;
  }

  void addOffsetTopListener(double threshold, VoidCallback callback) {
    bool wasOffsetTop = isOffsetTop(threshold);

    addListener(() {
      final isCurrentlyOffsetTop = isOffsetTop(threshold);
      if (isCurrentlyOffsetTop != wasOffsetTop) {
        wasOffsetTop = isCurrentlyOffsetTop;
        callback();
      }
    });
  }
}

// Usage examples:
//
// // Using the builder widget
// OffsetTopBuilder(
//   threshold: 100,
//   controller: scrollController,
//   builder: (context, isOffsetTop) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       color: isOffsetTop ? Colors.white : Colors.transparent,
//       child: AppBar(title: Text('My App')),
//     );
//   },
// )
//
// // Using the simple detector
// ScrollOffsetDetector(
//   threshold: 100,
//   builder: (isOffsetTop) => Text(isOffsetTop ? 'Scrolled' : 'Top'),
// )
