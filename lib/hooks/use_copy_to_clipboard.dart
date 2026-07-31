import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// ----------------------------------------------------------------------

class CopyToClipboardResult {
  final Future<bool> Function(String text) copy;
  final ValueNotifier<String?> copiedTextNotifier;

  const CopyToClipboardResult({
    required this.copy,
    required this.copiedTextNotifier,
  });

  String? get copiedText => copiedTextNotifier.value;
}

/// Hook-like function for copying text to clipboard
/// Similar to React's useCopyToClipboard hook
CopyToClipboardResult useCopyToClipboard() {
  final copiedTextNotifier = ValueNotifier<String?>(null);

  Future<bool> copy(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      copiedTextNotifier.value = text;
      return true;
    } catch (error) {
      debugPrint('Copy failed: $error');
      copiedTextNotifier.value = null;
      return false;
    }
  }

  return CopyToClipboardResult(
    copy: copy,
    copiedTextNotifier: copiedTextNotifier,
  );
}

/// Widget wrapper for copy to clipboard functionality
/// Provides a more Flutter-idiomatic approach using a builder pattern
class CopyToClipboardBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, CopyToClipboardResult result) builder;

  const CopyToClipboardBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<CopyToClipboardBuilder> createState() => _CopyToClipboardBuilderState();
}

class _CopyToClipboardBuilderState extends State<CopyToClipboardBuilder> {
  late final CopyToClipboardResult _result;

  @override
  void initState() {
    super.initState();
    _result = useCopyToClipboard();
  }

  @override
  void dispose() {
    _result.copiedTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _result);
  }
}

/// Extension for easy copying in any widget
extension CopyToClipboardExtension on String {
  Future<bool> copyToClipboard() async {
    try {
      await Clipboard.setData(ClipboardData(text: this));
      return true;
    } catch (error) {
      debugPrint('Copy failed: $error');
      return false;
    }
  }
}
