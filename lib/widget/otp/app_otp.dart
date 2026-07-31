import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:sms_autofill/sms_autofill.dart';

class CommonOtpWidget extends StatefulWidget {
  final Function(String) onCompleted;
  final Function(String) onError;
  final bool isChange;
  const CommonOtpWidget({
    super.key,
    required this.onCompleted,
    required this.onError,
    this.isChange = false,
  });

  @override
  CommonOtpWidgetState createState() => CommonOtpWidgetState();
}

class CommonOtpWidgetState extends State<CommonOtpWidget> with CodeAutoFill {
  final TextEditingController _controller = TextEditingController();
  final int otpLength = 4;
  String? _errorMessage;
  late final FocusNode focusNode = FocusNode()..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void codeUpdated() {
    _controller.text = code!;
    widget.onCompleted(code!);
  }

  void _validateOtp(String otp) {
    if (otp.length == otpLength) {
      widget.onCompleted(otp);
      setState(() {
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = "Invalid OTP. Please try again.";
      });
      widget.onError(otp);
    }
  }

  @override
  void dispose() {
    cancel();
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 66,
          width: 250,
          child: PinFieldAutoFill(
            focusNode: focusNode,
            controller: _controller,
            codeLength: otpLength,
            autoFocus: true,
            decoration: BoxLooseDecoration(
              strokeColorBuilder: focusNode.hasFocus ? FixedColorBuilder(customTheme.palette.common.primary.main) : FixedColorBuilder(customTheme.palette.common.divider),
              bgColorBuilder: focusNode.hasFocus ? FixedColorBuilder(customTheme.palette.background.paper) : FixedColorBuilder(customTheme.palette.background.paper),
              obscureStyle: ObscureStyle(
                isTextObscure: true,
              ),
              textStyle: baseTheme.textTheme.bodyLarge?.copyWith(color: customTheme.palette.text.primary),
              radius: const Radius.circular(8.0),
              gapSpace: 10.0,
              strokeWidth: 2.0,
            ),
            cursor: Cursor(color: customTheme.palette.common.primary.main, width: 2, height: 25, enabled: true),
            onCodeChanged: (code) {
              if (code != null && code.length == otpLength) {
                if (widget.isChange) {
                } else {
                  _validateOtp(code);
                }
              }
            },
          ),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(color: customTheme.palette.common.error.main, fontSize: 14),
            ),
          ),
      ],
    );
  }
}
