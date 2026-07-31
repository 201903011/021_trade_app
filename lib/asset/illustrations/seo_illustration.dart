import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimals/constants/illustrations/characters/character_3.dart';
import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/asset/illustrations/background_illustration.dart';

/// SEO illustration widget using SVG with character overlay
class SeoIllustration extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SeoIllustration({
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
    final primaryDark = theme.palette.common.primary.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: SvgPicture.string(
        getSeoSvgString(primaryLight, primaryDark),
        fit: BoxFit.contain,
      ),
    );
  }
}

String getSeoSvgString(Color primaryLight, Color primaryDark) {
  final primaryLightHex = _colorToHex(primaryLight);
  final primaryDarkHex = _colorToHex(primaryDark);

  return '''
<svg width="100%" height="100%" viewBox="0 0 480 360" xmlns="http://www.w3.org/2000/svg">
  ${getBackgroundString(primaryLight)}
  
  <defs>
    <filter
      id="filter0_f_1_51"
      width="101.56"
      height="100.65"
      x="232.807"
      y="109.722"
      colorInterpolationFilters="sRGB"
      filterUnits="userSpaceOnUse"
    >
      <feFlood floodOpacity="0" result="BackgroundImageFix" />
      <feBlend in="SourceGraphic" in2="BackgroundImageFix" result="shape" />
      <feGaussianBlur result="effect1_foregroundBlur_1_51" stdDeviation="10" />
    </filter>

    <linearGradient
      id="paint0_linear_1_51"
      x1="47.397"
      x2="47.397"
      y1="107.95"
      y2="281.395"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryLightHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
    
    <linearGradient
      id="paint1_linear_1_51"
      x1="248.43"
      x2="248.43"
      y1="128.061"
      y2="169.533"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryLightHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
    
    <linearGradient
      id="paint5_linear_1_51"
      x1="109.604"
      x2="109.604"
      y1="76"
      y2="104.047"
      gradientUnits="userSpaceOnUse"
    >
      <stop stop-color="$primaryLightHex" />
      <stop offset="1" stop-color="$primaryDarkHex" />
    </linearGradient>
  </defs>

  <path
    fill="$primaryDarkHex"
    fill-rule="evenodd"
    d="M109.224 97.41l.812 1.827-.02.009-.061.027-.248.112c-.219.1-.544.25-.968.449l-.849-1.811c.43-.202.762-.355.988-.457l.256-.117.066-.03.024-.01zm-6.771 3.278c.997-.507 1.901-.958 2.7-1.35l.882 1.795c-.791.388-1.687.835-2.675 1.337l-.907-1.782zm-5.356 2.808c.93-.502 1.82-.975 2.665-1.418l.929 1.771c-.838.439-1.72.909-2.644 1.407l-.95-1.76z"
    clip-rule="evenodd"
    opacity="0.24"
  />

  <path
    fill="#fff"
    d="M47.943 122.571L96.231 273.55a11.4 11.4 0 0011.786 7.805l63.326-5.36 148.013-12.644a11.316 11.316 0 009.904-7.823c.456-1.421.627-2.918.503-4.405a12.314 12.314 0 00-.729-3.122l-11.838-31.221-21.412-57.238-16.599-44.23a11.37 11.37 0 00-10.641-7.362H58.741a11.345 11.345 0 00-11.344 11.343c.016 1.114.2 2.219.546 3.278z"
  />

  <path
    fill="url(#paint0_linear_1_51)"
    d="M170.575 276.06l-62.558 5.295a11.4 11.4 0 01-11.785-7.805L47.942 122.571a11.028 11.028 0 01-.546-3.278A11.34 11.34 0 0158.74 107.95h57.453l54.382 168.11z"
  />

  <path
    fill="#F4F6F8"
    d="M227.879 191.221c2.613-.162 4.368-2.749 3.553-5.237l-8.483-25.895a4.002 4.002 0 00-3.993-2.75l-61.621 2.961c-2.666.128-4.461 2.782-3.588 5.304l9.248 26.717a3.999 3.999 0 004.028 2.683l60.856-3.783z"
  />

  <path
    fill="#DFE3E8"
    d="M244.879 239.221c2.613-.162 4.368-2.749 3.553-5.237l-8.483-25.895a4.002 4.002 0 00-3.993-2.75l-61.621 2.961c-2.666.128-4.461 2.782-3.588 5.304l9.248 26.717a3.999 3.999 0 004.028 2.683l60.856-3.783z"
  />

  <g filter="url(#filter0_f_1_51)" opacity="0.4">
    <path
      fill="#919EAB"
      d="M253.012 134.539l15.948 52.893a4.007 4.007 0 003.903 2.94l39.559-1.142a2 2 0 001.816-2.7l-20.001-53.4a2 2 0 00-1.755-1.295l-35.906-2.109a3.612 3.612 0 00-3.059 1.461 3.614 3.614 0 00-.505 3.352z"
    />
  </g>

  <path
    fill="#fff"
    d="M330.082 174.424l-16.495-46.701a4.03 4.03 0 00-3.512-2.732l-69.518-4.111a3.676 3.676 0 00-3.061 1.481 3.663 3.663 0 00-.53 3.358l15.949 52.92a4.057 4.057 0 003.902 2.966l70.091-2.108a3.663 3.663 0 002.898-1.716 3.667 3.667 0 00.276-3.357z"
  />

  <path
    fill="$primaryDarkHex"
    d="M295.375 166.976c.478 1.237.718 1.856 1.229 2.206.511.351 1.174.351 2.501.351h.32c2.648 0 3.972 0 4.568-.87.596-.869.118-2.104-.837-4.574l-6.427-16.612c-.479-1.238-.719-1.856-1.23-2.207-.511-.35-1.174-.35-2.501-.35h-.32c-2.648 0-3.972 0-4.568.87-.596.869-.118 2.104.837 4.573l6.428 16.613z"
  />

  <g opacity="0.48">
    <path
      fill="url(#paint1_linear_1_51)"
      d="M306.33 166.969c.478 1.241.717 1.861 1.228 2.212.512.351 1.176.351 2.505.351h.314c2.649 0 3.973 0 4.569-.869.596-.87.118-2.105-.839-4.574l-1.586-4.099c-.479-1.237-.718-1.855-1.229-2.205-.511-.351-1.175-.351-2.501-.351h-.305c-2.644 0-3.966 0-4.562.868-.596.868-.121 2.102.829 4.569l1.577 4.098z"
    />

    <path
      fill="url(#paint1_linear_1_51)"
      d="M284.397 166.971c.478 1.24.717 1.86 1.228 2.211.512.351 1.176.351 2.505.351h.315c2.648 0 3.973 0 4.568-.87.596-.87.118-2.105-.838-4.575l-2.705-6.986c-.479-1.237-.718-1.855-1.229-2.205-.511-.35-1.175-.35-2.501-.35h-.303c-2.645 0-3.967 0-4.563.868-.596.868-.12 2.102.831 4.57l2.692 6.986z"
    />

    <path
      fill="url(#paint1_linear_1_51)"
      d="M273.442 166.976c.479 1.237.718 1.856 1.229 2.206.511.351 1.175.351 2.502.351h.32c2.648 0 3.972 0 4.568-.87.596-.869.118-2.104-.838-4.574l-9.445-24.417c-.479-1.238-.718-1.856-1.229-2.207-.511-.35-1.175-.35-2.502-.35h-.32c-2.648 0-3.972 0-4.568.869-.596.87-.118 2.104.837 4.574l9.446 24.418z"
    />

    <path
      fill="url(#paint1_linear_1_51)"
      d="M262.463 166.974c.479 1.239.718 1.858 1.229 2.208.511.351 1.175.351 2.502.351h.322c2.647 0 3.97 0 4.566-.869.596-.869.119-2.104-.835-4.573l-12.935-33.472c-.479-1.238-.718-1.857-1.229-2.207-.511-.351-1.175-.351-2.502-.351h-.322c-2.647 0-3.97 0-4.566.869-.596.869-.119 2.104.835 4.573l12.935 33.471z"
    />
  </g>

  <g fill="#fff" fill-rule="evenodd" clip-rule="evenodd" opacity="0.4">
    <path d="M78.02 155.171a15.22 15.22 0 11.312 1.015l-.156-.495-.157-.52zm15.194-4.189l-3.59-11.525a12.641 12.641 0 013.121-.547 12.102 12.102 0 0111.994 8.456c.312 1.014.496 2.062.546 3.122a13.006 13.006 0 01-.286 3.148 11.815 11.815 0 01-2.914 5.516 11.914 11.914 0 01-11.525 3.59 13.21 13.21 0 01-2.94-1.067 12.76 12.76 0 01-2.602-1.821 12.257 12.257 0 01-3.33-5.203l11.526-3.669z" />
  </g>

  <path fill="url(#paint5_linear_1_51)" d="M151.154 76h-41.55l12.645 7.727L151.154 76z" />
  
  <path
    fill="url(#paint5_linear_1_51)"
    d="M151.154 76l-26.668 12.332 4.501 15.715L151.154 76z"
  />

  <path
    fill="$primaryDarkHex"
    d="M117.435 95.279l7.051-6.947L151.154 76l-28.905 7.727-4.814 11.552z"
  />

  <!-- Character overlay -->
  <image href="$base64Character3" height="300" x="312" y="30" />
</svg>
''';
}

String _colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}
