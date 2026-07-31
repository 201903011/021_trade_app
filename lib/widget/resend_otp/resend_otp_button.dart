import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResendOtpButton extends StatelessWidget {
  final RxBool isResendingOtp;
  final RxInt countdownSeconds;
  final VoidCallback onResendOtp;

  const ResendOtpButton({
    super.key,
    required this.isResendingOtp,
    required this.countdownSeconds,
    required this.onResendOtp,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isResending = isResendingOtp.value;
      final countdown = countdownSeconds.value;

      return GestureDetector(
        onTap: () {
          if (countdown <= 0 && !isResending) {
            onResendOtp();
            isResendingOtp.value = true;
            // Start countdown timer externally, e.g., in the controller
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            countdown > 0
                ? Text(
                    isResending ? 'Resending...' : 'Resend OTP (00:${countdown.toString().padLeft(2, '0')}s)',
                  )
                : const Text(
                    'Resend OTP',
                  ),
          ],
        ),
      );
    });
  }
}
