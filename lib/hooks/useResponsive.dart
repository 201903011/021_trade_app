import 'package:flutter/material.dart';

// ----------------------------------------------------------------------

enum ResponsiveQuery { up, down, between, only }

enum Breakpoint { xs, sm, md, lg, xl }

class BreakpointValues {
  static const Map<Breakpoint, double> values = {
    Breakpoint.xs: 0,
    Breakpoint.sm: 600,
    Breakpoint.md: 900,
    Breakpoint.lg: 1200,
    Breakpoint.xl: 1536,
  };

  static double getValue(Breakpoint breakpoint) {
    return values[breakpoint] ?? 0;
  }

  static List<Breakpoint> get keys => Breakpoint.values;
}

// ----------------------------------------------------------------------

class ResponsiveUtils {
  static bool up(BuildContext context, Breakpoint breakpoint) {
    final width = MediaQuery.of(context).size.width;
    return width >= BreakpointValues.getValue(breakpoint);
  }

  static bool down(BuildContext context, Breakpoint breakpoint) {
    final width = MediaQuery.of(context).size.width;
    return width < BreakpointValues.getValue(breakpoint);
  }

  static bool between(BuildContext context, Breakpoint start, Breakpoint end) {
    final width = MediaQuery.of(context).size.width;
    final startValue = BreakpointValues.getValue(start);
    final endValue = BreakpointValues.getValue(end);
    return width >= startValue && width < endValue;
  }

  static bool only(BuildContext context, Breakpoint breakpoint) {
    final width = MediaQuery.of(context).size.width;
    final currentValue = BreakpointValues.getValue(breakpoint);

    // Find the next breakpoint
    final breakpoints = BreakpointValues.keys;
    final currentIndex = breakpoints.indexOf(breakpoint);

    if (currentIndex == breakpoints.length - 1) {
      // This is the largest breakpoint
      return width >= currentValue;
    }

    final nextBreakpoint = breakpoints[currentIndex + 1];
    final nextValue = BreakpointValues.getValue(nextBreakpoint);

    return width >= currentValue && width < nextValue;
  }
}

// ----------------------------------------------------------------------

/// Hook-like function for responsive queries
bool useResponsive(
  BuildContext context,
  ResponsiveQuery query, {
  Breakpoint? start,
  Breakpoint? end,
}) {
  switch (query) {
    case ResponsiveQuery.up:
      if (start == null) throw ArgumentError('start breakpoint is required for "up" query');
      return ResponsiveUtils.up(context, start);

    case ResponsiveQuery.down:
      if (start == null) throw ArgumentError('start breakpoint is required for "down" query');
      return ResponsiveUtils.down(context, start);

    case ResponsiveQuery.between:
      if (start == null || end == null) {
        throw ArgumentError('start and end breakpoints are required for "between" query');
      }
      return ResponsiveUtils.between(context, start, end);

    case ResponsiveQuery.only:
      if (start == null) throw ArgumentError('start breakpoint is required for "only" query');
      return ResponsiveUtils.only(context, start);
  }
}

// ----------------------------------------------------------------------

/// Get current screen width breakpoint
Breakpoint useWidth(BuildContext context) {
  final keys = BreakpointValues.keys.reversed.toList();

  for (final breakpoint in keys) {
    if (ResponsiveUtils.up(context, breakpoint)) {
      return breakpoint;
    }
  }

  return Breakpoint.xs;
}

// ----------------------------------------------------------------------

/// Extension methods for easier usage
extension ResponsiveExtension on BuildContext {
  bool get isXs => useWidth(this) == Breakpoint.xs;
  bool get isSm => useWidth(this) == Breakpoint.sm;
  bool get isMd => useWidth(this) == Breakpoint.md;
  bool get isLg => useWidth(this) == Breakpoint.lg;
  bool get isXl => useWidth(this) == Breakpoint.xl;

  bool get isSmUp => useResponsive(this, ResponsiveQuery.up, start: Breakpoint.sm);
  bool get isMdUp => useResponsive(this, ResponsiveQuery.up, start: Breakpoint.md);
  bool get isLgUp => useResponsive(this, ResponsiveQuery.up, start: Breakpoint.lg);
  bool get isXlUp => useResponsive(this, ResponsiveQuery.up, start: Breakpoint.xl);

  bool get isSmDown => useResponsive(this, ResponsiveQuery.down, start: Breakpoint.sm);
  bool get isMdDown => useResponsive(this, ResponsiveQuery.down, start: Breakpoint.md);
  bool get isLgDown => useResponsive(this, ResponsiveQuery.down, start: Breakpoint.lg);
  bool get isXlDown => useResponsive(this, ResponsiveQuery.down, start: Breakpoint.xl);

  Breakpoint get currentBreakpoint => useWidth(this);
}
