
import 'package:flutter/material.dart';

class CustomOtpField extends StatefulWidget {
  final int otpLength;
  final TextEditingController controller;
  final Color focusedBorderColor;
  final Color filledBorderColor;
  final Color outlinedBorderColor;
  final Color defaultBorderColor;
  final TextStyle textStyle;
  final double gapSpace;
  final double borderRadius;
  final double strokeWidth;
  final bool isObscureText;
  final ValueChanged<String> onCodeComplete;
  const CustomOtpField({
    super.key,
    required this.otpLength,
    required this.controller,
    required this.onCodeComplete,
    this.focusedBorderColor = Colors.green,
    this.outlinedBorderColor = Colors.green,
    this.filledBorderColor = Colors.green,
    this.defaultBorderColor = Colors.grey,
    this.textStyle = const TextStyle(fontSize: 20, color: Colors.black),
    this.gapSpace = 10.0,
    this.borderRadius = 8.0,
    this.strokeWidth = 2.0,
    this.isObscureText = false,
  });

  @override
  CustomOtpFieldState createState() => CustomOtpFieldState();
}

class CustomOtpFieldState extends State<CustomOtpField> {
  final List<FocusNode> _focusNodes = [];
  final List<String> _code = [];
  List<Color> _boxColors = [];
  List<Color> _decboxColors = [];


  @override
  void initState() {
    super.initState();
    _boxColors = List.generate(widget.otpLength, (_) => widget.defaultBorderColor);
    _decboxColors = List.generate(widget.otpLength, (_) => widget.defaultBorderColor);
    _code.addAll(List.generate(widget.otpLength, (_) => ''));
    _focusNodes.addAll(List.generate(widget.otpLength, (_) => FocusNode()));
    // Adding listeners for each FocusNode
    for (int i = 0; i < widget.otpLength; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          _boxColors[i] = _focusNodes[i].hasFocus ? widget.focusedBorderColor : widget.defaultBorderColor;
          _decboxColors[i] = _focusNodes[i].hasFocus ? widget.outlinedBorderColor : widget.defaultBorderColor;

        });
      });
    }
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged() {
    final currentCode = _code.join();
    widget.controller.text = currentCode;

    if (currentCode.length == widget.otpLength) {
      widget.onCodeComplete(currentCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.otpLength, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: widget.gapSpace / 2),
          child: _buildOtpBox(index),
        );
      }),
    );
  }

  Widget _buildOtpBox(int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _decboxColors[index],
            width:  widget.strokeWidth,
          )
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        width: 56,
        height: 66,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _boxColors[index],
            width: widget.strokeWidth,
          ),
        ),
        child: TextField(
          obscureText: widget.isObscureText,
          autofocus: true,
          autofillHints: const [
            AutofillHints.oneTimeCode,
            AutofillHints.creditCardNumber
          ],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          style: widget.textStyle,
          maxLength: 1,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isNotEmpty) {
              // Store the entered value in the code list at the correct index
              _code[index] = value;

              // Move focus to the next field automatically if not the last field
              if (index < widget.otpLength - 1) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              }
            } else {
              // Clear the value for this box
              _code[index] = '';

              // Move focus to the previous field automatically if not the first field
              if (index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            }

            _onCodeChanged();
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
        ),
      ),
    );
  }
}

