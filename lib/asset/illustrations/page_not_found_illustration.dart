import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimals/asset/illustrations/background_illustration.dart';
import 'package:minimals/constants/illustrations/characters/character_6.dart';
import 'package:minimals/theme/use_theme.dart';

/// SVG-based page not found illustration widget that closely matches the React version
class PageNotFoundIllustration extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const PageNotFoundIllustration({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    final primaryLight = theme.palette.common.primary.light;
    final primaryMain = theme.palette.common.primary.main;
    final primaryDark = theme.palette.common.primary.dark;
    final primaryDarker = theme.palette.common.primary.darker;

    // Convert colors to hex strings for SVG
    final primaryLightHex = _colorToHex(primaryLight);
    final primaryMainHex = _colorToHex(primaryMain);
    final primaryDarkHex = _colorToHex(primaryDark);
    final primaryDarkerHex = _colorToHex(primaryDarker);

    final svgString = '''
<svg width="480" height="360" viewBox="0 0 480 360" xmlns="http://www.w3.org/2000/svg">
  <!-- Background Illustration -->
  <defs>
    ${getBackgroundString(primaryMain)}

    <linearGradient
      id="paint0_linear_1_119"
      x1="78.3"
      x2="78.3"
      y1="187.77"
      y2="305.935"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryLightHex" />
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
    href="$base64Character6"
    height="300"
    x="205"
    y="30"
  />

  <!-- Yellow decorative elements -->
  <path
    fill="#FFAB00"
    d="M111.1 141.2c58.7-1 58.6-88.3 0-89.2-58.6 1-58.6 88.3 0 89.2z"
    opacity="0.12"
  />

  <path fill="#FFD666" d="M111.1 120c30.8-.5 30.8-46.3 0-46.8-30.8.5-30.8 46.3 0 46.8z" />
  
  <!-- Main circle with "0" -->
  <path
    fill="$primaryDarkerHex"
    d="M244.9 182.5c82.3 1.4 82.2 123.8 0 125.2-82.3-1.5-82.3-123.8 0-125.2zm0 23.1c-51.8.9-51.8 77.9 0 78.8 51.8-.9 51.7-77.9 0-78.8z"
  />

  <!-- "404" text -->
  <path
    fill="url(#paint0_linear_1_119)"
    d="M175 265.6c1-8.7-12.1-4.8-17-5.6v-66.6c0-4.5-1.5-5.6-5.6-5.6-5.3.3-13.8-1.4-17.1 4l-55 68.3c-2.7 3.3-1.8 8.8-2 12.8 0 4.1 1.5 5.6 5.6 5.6h54.7v21.7c-.9 7.9 9.1 5.2 13.7 5.6 4.1 0 5.6-1.5 5.6-5.6v-21.7c13.8-1.1 18.1 4.5 17.1-12.9zm-72.5-5.6l36-44.4V260h-36zm309.1 5.6c1-8.7-12.2-4.8-17.1-5.6v-66.6c0-4.5-1.5-5.6-5.6-5.6-5.3.3-13.7-1.4-17.1 4l-55 68.3c-2.7 3.3-1.9 8.8-2 12.8 0 4.1 1.5 5.6 5.6 5.6h54.7v21.7c-.9 7.9 9.1 5.2 13.7 5.6 4.1 0 5.6-1.5 5.6-5.6v-21.7c14.1-1.1 18.2 4.5 17.2-12.9zm-72.4-5.6l36-44.4V260h-36z"
  />

  <!-- Decorative clouds -->
  <path
    fill="$primaryMainHex"
    d="M425.6 118.2c0-5-4.6-9-9.6-8.2-2-3.7-6-6-10.2-5.9 4.3-21.4-30-21.4-25.7 0-8.7-.8-15.1 9.4-10.4 16.8 2.1 3.5 5.9 5.6 10 5.5h38.7v-.1c4.1-.4 7.2-3.9 7.2-8.1zM104.3 200c.1-4.2-4.1-7.8-8.2-7-1.7-3.2-5.1-5.1-8.8-5 3.8-18.4-25.8-18.4-22 0-7.4-.7-12.9 8.1-8.9 14.4 1.8 3 5.1 4.8 8.6 4.7h33.2v-.1c3.4-.4 6.1-3.4 6.1-7z"
    opacity="0.08"
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
