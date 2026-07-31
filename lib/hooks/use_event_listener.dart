import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ----------------------------------------------------------------------

/// Hook-like functionality for event listening
/// Similar to React's useEventListener hook
class UseEventListener {
  StreamSubscription? _subscription;

  UseEventListener();

  /// Listen to keyboard events
  void listenToKeyboard({
    required bool Function(KeyEvent) filter,
    required VoidCallback handler,
  }) {
    dispose();

    HardwareKeyboard.instance.addHandler((event) {
      if (filter(event)) {
        handler();
        return true;
      }
      return false;
    });
  }

  /// Listen to app lifecycle changes
  void listenToAppLifecycle({
    required void Function(AppLifecycleState) handler,
  }) {
    dispose();

    // Note: This would typically be handled through WidgetsBindingObserver
    // in a real Flutter app, but we're providing a hook-like interface
  }

  /// Listen to scroll events from a ScrollController
  void listenToScroll({
    required ScrollController controller,
    required VoidCallback handler,
  }) {
    dispose();
    controller.addListener(handler);
  }

  /// Listen to focus events from a FocusNode
  void listenToFocus({
    required FocusNode focusNode,
    required VoidCallback handler,
  }) {
    dispose();
    focusNode.addListener(handler);
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

/// Widget wrapper for event listening functionality
/// Provides a more Flutter-idiomatic approach
class EventListenerBuilder extends StatefulWidget {
  final Widget child;
  final void Function(UseEventListener eventListener)? onInit;

  const EventListenerBuilder({
    super.key,
    required this.child,
    this.onInit,
  });

  @override
  State<EventListenerBuilder> createState() => _EventListenerBuilderState();
}

class _EventListenerBuilderState extends State<EventListenerBuilder> {
  late UseEventListener _eventListener;

  @override
  void initState() {
    super.initState();
    _eventListener = UseEventListener();
    widget.onInit?.call(_eventListener);
  }

  @override
  void dispose() {
    _eventListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Keyboard event listener widget
class KeyboardListener extends StatefulWidget {
  final Widget child;
  final bool Function(KeyEvent)? keyFilter;
  final VoidCallback? onKeyEvent;

  const KeyboardListener({
    super.key,
    required this.child,
    this.keyFilter,
    this.onKeyEvent,
  });

  @override
  State<KeyboardListener> createState() => _KeyboardListenerState();
}

class _KeyboardListenerState extends State<KeyboardListener> {
  late UseEventListener _eventListener;

  @override
  void initState() {
    super.initState();
    _eventListener = UseEventListener();

    if (widget.keyFilter != null && widget.onKeyEvent != null) {
      _eventListener.listenToKeyboard(
        filter: widget.keyFilter!,
        handler: widget.onKeyEvent!,
      );
    }
  }

  @override
  void didUpdateWidget(KeyboardListener oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.keyFilter != widget.keyFilter || oldWidget.onKeyEvent != widget.onKeyEvent) {
      _eventListener.dispose();
      _eventListener = UseEventListener();

      if (widget.keyFilter != null && widget.onKeyEvent != null) {
        _eventListener.listenToKeyboard(
          filter: widget.keyFilter!,
          handler: widget.onKeyEvent!,
        );
      }
    }
  }

  @override
  void dispose() {
    _eventListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (widget.keyFilter?.call(event) == true) {
          widget.onKeyEvent?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: widget.child,
    );
  }
}

/// Scroll event listener widget
class ScrollEventListener extends StatefulWidget {
  final Widget child;
  final ScrollController? controller;
  final VoidCallback? onScroll;

  const ScrollEventListener({
    super.key,
    required this.child,
    this.controller,
    this.onScroll,
  });

  @override
  State<ScrollEventListener> createState() => _ScrollEventListenerState();
}

class _ScrollEventListenerState extends State<ScrollEventListener> {
  late UseEventListener _eventListener;
  ScrollController? _internalController;

  @override
  void initState() {
    super.initState();
    _eventListener = UseEventListener();
    _internalController = widget.controller ?? ScrollController();

    if (widget.onScroll != null) {
      _eventListener.listenToScroll(
        controller: _internalController!,
        handler: widget.onScroll!,
      );
    }
  }

  @override
  void didUpdateWidget(ScrollEventListener oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller || oldWidget.onScroll != widget.onScroll) {
      _eventListener.dispose();
      _eventListener = UseEventListener();

      if (widget.controller == null && _internalController == null) {
        _internalController = ScrollController();
      } else if (widget.controller != null) {
        _internalController = widget.controller;
      }

      if (widget.onScroll != null && _internalController != null) {
        _eventListener.listenToScroll(
          controller: _internalController!,
          handler: widget.onScroll!,
        );
      }
    }
  }

  @override
  void dispose() {
    _eventListener.dispose();
    if (widget.controller == null) {
      _internalController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// Usage examples:
// 
// // Keyboard listener
// KeyboardListener(
//   keyFilter: (event) => event.logicalKey == LogicalKeyboardKey.escape,
//   onKeyEvent: () => print('Escape pressed'),
//   child: MyWidget(),
// )
//
// // Scroll listener  
// ScrollEventListener(
//   controller: scrollController,
//   onScroll: () => print('Scrolled'),
//   child: ListView(...),
// )
