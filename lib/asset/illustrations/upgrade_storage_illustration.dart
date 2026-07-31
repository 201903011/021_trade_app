import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimals/constants/illustrations/characters/character_2.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/asset/illustrations/background_illustration.dart';

/// Upgrade Storage illustration widget using SVG with character overlay
class UpgradeStorageIllustration extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const UpgradeStorageIllustration({
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
    final primaryMain = theme.palette.common.primary.main;
    final primaryDark = theme.palette.common.primary.dark;
    final primaryDarker = theme.palette.common.primary.darker;

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: SvgPicture.string(
        getUpgradeStorageSvgString(primaryLighter, primaryMain, primaryDark, primaryDarker),
        fit: BoxFit.contain,
      ),
    );
  }
}

String getUpgradeStorageSvgString(Color primaryLighter, Color primaryMain, Color primaryDark, Color primaryDarker) {
  final primaryLighterHex = _colorToHex(primaryLighter);
  final primaryMainHex = _colorToHex(primaryMain);
  final primaryDarkHex = _colorToHex(primaryDark);
  final primaryDarkerHex = _colorToHex(primaryDarker);

  return '''
<svg width="100%" height="100%" viewBox="0 0 480 360" xmlns="http://www.w3.org/2000/svg">
  ${getBackgroundString(primaryMain)}
  
  <defs>
    <linearGradient
      id="paint0_linear_1_99"
      x1="179.716"
      x2="100.71"
      y1="61.393"
      y2="249.434"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryMainHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
    <linearGradient
      id="paint1_linear_1_99"
      x1="209.454"
      x2="130.449"
      y1="73.888"
      y2="261.929"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryMainHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
    <linearGradient
      id="paint2_linear_1_99"
      x1="168.021"
      x2="145.633"
      y1="238.622"
      y2="311.266"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryMainHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
  </defs>

  <!-- Character overlay -->
  <image href="$base64Character2" height="300" x="322" y="30" />

  <!-- Cloud decorations -->
  <path
    fill="$primaryMainHex"
    d="M70.6 79.545c0-2.7.7-5.4 2-7.8 1.3-2.4 3.1-4.4 5.4-5.9 2.3-1.5 4.9-2.4 7.6-2.7 2.7-.3 5.4.1 8 1.1 1.8-3.8 4.8-6.8 8.499-8.8 3.7-2 7.9-2.8 12-2.3s8 2.3 11.1 5.1c3.1 2.8 5.3 6.5 6.2 10.6 4.5.3 8.7 2.3 11.7 5.7 3 3.3 4.6 7.7 4.5 12.2-.1 4.5-2 8.7-5.2 11.9-3.2 3.1-7.5 4.9-12 4.9h-55.5c-2.9 0-5.7-1-7.9-2.8-2.2-1.8-3.7-4.4-4.2-7.2s0-5.7 1.4-8.3c1.4-2.7 3.7-4.7 6.4-5.7z"
    opacity="0.08"
  />

  <!-- Shadow -->
  <path
    fill="$primaryDarkerHex"
    d="M185.3 306.145c74.7 0 135.3-3.5 135.3-7.9s-60.6-7.9-135.3-7.9c-74.7 0-135.3 3.5-135.3 7.9s60.5 7.9 135.3 7.9z"
    opacity="0.24"
  />

  <!-- Cloud storage box -->
  <path
    fill="url(#paint0_linear_1_99)"
    d="M138.6 75.745h12.8c8 0 15.8 2.3 22.5 6.7 6.9 4.5 12.3 10.9 15.4 18.5 7.6.5 14.8 3.3 20.6 8.2 5.8 4.9 9.9 11.5 11.6 18.8 5.1 1.5 9.5 4.7 12.5 9.2 2.9 4.5 4.1 9.8 3.4 15.1-.7 5.3-3.4 10.1-7.4 13.6s-9.2 5.4-14.5 5.4h-125c-4.7.1-9.3-.8-13.6-2.5-4.3-1.7-8.3-4.3-11.6-7.6-3.3-3.3-6-7.2-7.8-11.5-1.8-4.3-2.7-8.9-2.7-13.6 0-4.7.9-9.3 2.7-13.6 1.8-4.3 4.4-8.2 7.8-11.5 3.3-3.3 7.3-5.9 11.6-7.6 4.3-1.7 9-2.6 13.6-2.5h10.2c3.1-7.4 8.4-13.8 15.1-18.2 6.8-4.5 14.7-6.9 22.8-6.9z"
  />

  <!-- Upload arrow -->
  <path
    fill="url(#paint1_linear_1_99)"
    d="M124.2 171.245h16.4v16.5c0 1.8-.7 3.6-2 4.9-.6.6-1.2 1-1.9 1.3v10.6c0 1-.4 1.9-1.1 2.6-.6.6-1.5 1-2.3 1.1h.8v4.2c0 4.3 1.7 8.5 4.8 11.6 3.1 3.1 7.2 4.8 11.6 4.8h36.6v3.5h-36.6c-5.3 0-10.3-2.1-14.1-5.8-3.7-3.7-5.8-8.8-5.8-14.1v-4.3h.8c-.9-.1-1.7-.4-2.3-1.1-.7-.7-1.1-1.6-1.1-2.6v-10.6c-.7-.3-1.3-.8-1.9-1.3-1.3-1.3-2-3-2-4.9v-16.4h.1z"
  />

  <!-- Cloud upload content -->
  <path
    fill="$primaryLighterHex"
    fill-rule="evenodd"
    d="M216.1 130.245l1.6.4c4.5 1.3 8.3 4.1 10.9 8 2.5 3.9 3.6 8.6 2.9 13.2-.6 4.6-2.9 8.8-6.4 11.9-3.5 3.1-8 4.7-12.7 4.7H103.3c-8.4 0-16.5-3.4-22.6-9.3-6-5.9-9.5-13.9-9.7-22.4-.2-8.4 2.9-16.6 8.6-22.7 5.8-6.2 13.7-9.9 22.2-10.4h1.5c2.9 0 5.9.4 8.7 1.2l.2.1 2.5.7.9-2.4c2.7-7 7.4-13.1 13.5-17.4 6.1-4.4 13.3-6.9 20.8-7.2 7.3.3 14.3 2.6 20.3 6.8 6 4.2 10.7 9.9 13.5 16.7l.7 1.6 1.7.1c6.9.4 13.6 3.1 18.9 7.6 5.3 4.5 9.1 10.5 10.7 17.3l.4 1.5zm-78.7 24.4v-27.7h-8.8l22.8-25.6 22.8 25.6h-8.8v27.7h-28z"
    clip-rule="evenodd"
  />

  <!-- Storage devices -->
  <path
    fill="$primaryMainHex"
    d="M256.3 144.745h-60c-5 0-9.1 4.1-9.1 9.1v135.3c0 5 4.1 9.1 9.1 9.1h60c5 0 9.1-4.1 9.1-9.1v-135.3c0-5-4.1-9.1-9.1-9.1z"
  />

  <path
    fill="$primaryDarkHex"
    d="M256.3 298.245h16.3c5 0 9.1-4.1 9.1-9.1v-135.3c0-5-4.1-9.1-9.1-9.1h-16.3c5 0 9.1 4.1 9.1 9.1v135.3c0 5-4.1 9.1-9.1 9.1z"
  />

  <path
    fill="#fff"
    d="M262.4 289.145v-135.3c0-3.3-2.7-6.1-6.1-6.1h-57.2c-3.3 0-6.1 2.7-6.1 6.1v135.3c0 3.3 2.7 6.1 6.1 6.1h57.2c3.3 0 6.1-2.8 6.1-6.1z"
  />

  <!-- File folders -->
  <path
    fill="url(#paint2_linear_1_99)"
    d="M154.6 246.645l-3.6 5.3c-.3.5-.8.9-1.3 1.1-.5.3-1.1.4-1.7.4h-33.1c-.5 0-1 .1-1.4.2-.4.2-.9.5-1.2.8-.3.3-.6.8-.8 1.2-.2.5-.2.9-.2 1.4l3 40.6c.1 1 .6 2 1.4 2.6.8.7 1.8 1 2.8 1h78.9c.5 0 1-.1 1.4-.2.4-.2.9-.5 1.2-.8.3-.3.6-.8.8-1.2.2-.5.2-.9.2-1.4l-3.6-48.9c-.1-1-.6-1.9-1.4-2.6-.8-.7-1.8-1-2.8-1h-35.5c-.6 0-1.2.1-1.7.4-.5.3-1 .7-1.4 1.1z"
  />

  <!-- Progress dots and indicators -->
  <path
    fill="#FFAB00"
    d="M248.8 161.845c.6 0 1-.5 1-1 0-.6-.5-1-1-1-.6 0-1 .5-1 1-.1.6.4 1 1 1zm0 15.2c.6 0 1-.5 1-1 0-.6-.5-1-1-1-.6 0-1 .5-1 1-.1.5.4 1 1 1zm0 15.2c.6 0 1-.5 1-1 0-.6-.5-1-1-1-.6 0-1 .5-1 1-.1.5.4 1 1 1z"
  />

  <path
    fill="$primaryDarkHex"
    d="M253.3 161.845c.6 0 1-.5 1-1 0-.6-.5-1-1-1-.6 0-1 .5-1 1 0 .6.4 1 1 1zm0 15.2c.6 0 1-.5 1-1 0-.6-.5-1-1-1-.6 0-1 .5-1 1s.4 1 1 1zm0 15.2c.6 0 1-.5 1-1 0-.6-.5-1-1-1-.6 0-1 .5-1 1s.4 1 1 1z"
  />

  <!-- File browser lines -->
  <path
    fill="$primaryMainHex"
    fill-rule="evenodd"
    d="M202.5 165.545h50.4c1.2 0 2.4-.5 3.3-1.4.9-.9 1.4-2.1 1.4-3.3 0-1.3-.5-2.5-1.4-3.3-.9-.9-2.1-1.4-3.3-1.4h-50.4c-1.2 0-2.4.5-3.3 1.4-.9.9-1.4 2.1-1.4 3.3 0 1.2.5 2.4 1.4 3.3.9.9 2 1.4 3.3 1.4z"
    clip-rule="evenodd"
    opacity="0.24"
  />
</svg>
''';
}

String _colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}
