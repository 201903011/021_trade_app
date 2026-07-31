// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimals/asset/illustrations/background_illustration.dart';
import 'package:minimals/constants/illustrations/characters/character_2.dart';
import 'package:minimals/theme/use_theme.dart';

/// SVG-based motivation illustration widget that closely matches the React version
class MotivationIllustration extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const MotivationIllustration({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    final primaryLighter = theme.palette.common.primary.lighter;
    final primaryDark = theme.palette.common.primary.dark;
    final primaryDarker = theme.palette.common.primary.darker;

    // Convert colors to hex strings for SVG
    final primaryLighterHex = _colorToHex(primaryLighter);
    final primaryDarkHex = _colorToHex(primaryDark);
    final primaryDarkerHex = _colorToHex(primaryDarker);

    final svgString = '''
<svg width="100%" height="100%" viewBox="0 0 480 360" xmlns="http://www.w3.org/2000/svg">
  <!-- Background Illustration -->
  <defs>
    ${getBackgroundString(theme.palette.common.primary.main)}

    <linearGradient
      id="paint0_linear_1_43"
      x1="140"
      x2="276.5"
      y1="98"
      y2="312.5"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryLighterHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
  </defs>

  <!-- Background path -->
  <path
    fill="url(#BG)"
    fill-rule="nonzero"
    d="M0 198.78c0 41.458 14.945 79.236 39.539 107.786 28.214 32.765 69.128 53.365 114.734 53.434a148.44 148.44 0 0056.495-11.036c9.051-3.699 19.182-3.274 27.948 1.107a75.779 75.779 0 0033.957 8.01c5.023 0 9.942-.494 14.7-1.433 13.58-2.67 25.94-8.99 36.09-17.94 6.378-5.627 14.547-8.456 22.897-8.446h.142c27.589 0 53.215-8.732 74.492-23.696 19.021-13.36 34.554-31.696 44.904-53.224C474.92 234.58 480 213.388 480 190.958c0-76.93-59.774-139.305-133.498-139.305-7.516 0-14.88.663-22.063 1.899C305.418 21.42 271.355 0 232.499 0a103.651 103.651 0 00-45.88 10.661c-13.24 6.487-25.011 15.705-34.64 26.939-32.698.544-62.931 11.69-87.676 30.291C25.351 97.155 0 144.882 0 198.781z"
    opacity="0.2"
  />

  <!-- Character image with base64 data -->
  <image
    href="$base64Character2"
    height="300"
    x="322"
    y="30"
  />

  <!-- Bar chart bars with gradient -->
  <path
    fill="url(#paint0_linear_1_43)"
    d="M216.3 138v108.3c0 2.2-1.8 4-4 4H195c-2.2 0-4-1.8-4-4V138c0-2.2 1.8-4 4-4h17.3c2.2 0 4 1.8 4 4zm-55-68H144c-2.2 0-4 1.8-4 4v176.3c0 2.2 1.8 4 4 4h17.3c2.2 0 4-1.8 4-4V74c0-2.2-1.8-4-4-4zm102 93H246c-2.2 0-4 1.8-4 4v75.7c0 2.2 1.8 4 4 4h17.3c2.2 0 4-1.8 4-4V167c0-2.2-1.8-4-4-4z"
  />

  <!-- Graph/chart base shadow -->
  <path
    fill="$primaryDarkerHex"
    d="M359.2 253.4c-1.1 3.1-2.3 6.3-3.7 9.7-5.1.1-10.1.3-15.2.4-3.3.1-6.9.2-9.6 2.1-5.2 3.6-.7 6.1-1.3 9.6-.7 4.2-4.9 5.1-9 5.1-14.1.1-27.7 4.6-41.5 7.3s-28.9 3.5-41.2-3.4c-.8-.5-1.7-1-2-2-.6-1.6.9-3.2 2.3-4.2 3.2-2.2 6.7-3.7 10.5-4.5 2.2-.5 4.5-.8 6.5-2 1.9-1.2 3.3-3.7 2.3-5.8-32.1 2-64.1 4.8-96 8.4-41.1 4.8-81.8 12.9-123 15.9h-.4c-2.9-2.9-5.5-6-7.9-9.3.2-.2.4-.5.6-.7 2-2.2 5-3.2 7.8-4.1 15.9-4.9 32.4-7.4 48.8-9.9 81.6-12.3 164.2-21.1 246.8-15.3 8.4.6 16.8 1.5 25.2 2.7z"
    opacity="0.24"
  />

  <!-- Chart/clipboard base -->
  <path
    fill="#DFE3E8"
    d="M81.7 204.2l74 11v60.7h8.5v3.6h-19.5v-2.3h8.7v-50.3l-70-13.5v49h9.7v1.7H73.6V262h8.2v-57.8h-.1z"
  />

  <!-- Chart/clipboard shadow -->
  <path
    fill="#C4CDD5"
    d="M80.6 204.2l74 11v60.7h8.5v3.6h-19.5v-2.3h8.7v-50.3l-70-13.5v49H92v1.7H72.4V262h8.2v-57.8z"
  />
</svg>
    ''';

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: SvgPicture.string(
        svgString,
        fit: BoxFit.contain,
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
