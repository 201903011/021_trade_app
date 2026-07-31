import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ----------------------------------------------------------------------

class ActiveLinkResult {
  final bool active;
  final bool isExternalLink;

  const ActiveLinkResult({
    required this.active,
    required this.isExternalLink,
  });
}

/// Hook-like function to check if a link is active
/// Similar to React's useActiveLink hook
ActiveLinkResult useActiveLink(String path, {bool deep = true}) {
  final currentRoute = Get.currentRoute;
  final currentLocation = Get.routing.current;

  final checkPath = path.startsWith('#');
  final normalizedPath = path == '/' ? '/' : '$path/';

  final normalActive = (!checkPath && currentRoute == normalizedPath) || (!checkPath && currentLocation == normalizedPath);

  final deepActive = (!checkPath && currentRoute.contains(normalizedPath)) || (!checkPath && currentLocation.contains(normalizedPath));

  return ActiveLinkResult(
    active: deep ? deepActive : normalActive,
    isExternalLink: path.contains('http'),
  );
}

/// Widget wrapper for active link detection
/// Provides a more Flutter-idiomatic approach using a builder pattern
class ActiveLinkBuilder extends StatelessWidget {
  final String path;
  final bool deep;
  final Widget Function(BuildContext context, ActiveLinkResult result) builder;

  const ActiveLinkBuilder({
    super.key,
    required this.path,
    this.deep = true,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final result = useActiveLink(path, deep: deep);
    return builder(context, result);
  }
}
