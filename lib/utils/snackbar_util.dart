// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/components/snackbar/custom_snackbar.dart';
import 'package:minimals/theme/use_theme.dart';

void showSnackBar(String message, {bool isError = false, int second = 3}) {
  final context = Get.context;
  final duration = Duration(seconds: second);
  final type = isError ? SnackbarType.error : SnackbarType.success;

  if (context != null) {
    CustomSnackbar.show(
      context: context,
      message: message,
      type: type,
      duration: duration,
      showCloseButton: true,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
      borderRadius: 8,
    );
    return;
  }
}

void showErrorSnackBar(String message, {int second = 3}) {
  showSnackBar(message, isError: true, second: second);
}

void showSuccessSnackBar(String message, {int second = 3}) {
  showSnackBar(message, isError: false, second: second);
}

class _SnackbarMessage extends StatelessWidget {
  const _SnackbarMessage({
    required this.message,
    required this.isError,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    useTheme(context);

    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: Get.closeCurrentSnackbar,
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }
}
