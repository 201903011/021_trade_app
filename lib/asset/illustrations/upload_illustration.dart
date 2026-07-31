import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimals/asset/illustrations/background_illustration.dart';
import 'package:minimals/theme/use_theme.dart';

/// SVG-based upload illustration widget that closely matches the React version
class UploadIllustration extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const UploadIllustration({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UseTheme(context);

    final primaryMain = theme.palette.common.primary.main;
    final primaryDark = theme.palette.common.primary.dark;
    final primaryDarker = theme.palette.common.primary.darker;

    // Convert colors to hex strings for SVG
    final primaryMainHex = _colorToHex(primaryMain);
    final primaryDarkHex = _colorToHex(primaryDark);
    final primaryDarkerHex = _colorToHex(primaryDarker);

    final svgString = '''
<svg width="480" height="360" viewBox="0 0 480 360" xmlns="http://www.w3.org/2000/svg">
  <!-- Background Illustration -->
  <defs>
    ${getBackgroundString(primaryMain)}

    <linearGradient id="linearGradient-2" x1="30.113%" x2="30.113%" y1="0%" y2="100%">
      <stop offset="0%" stop-opacity="0" />
      <stop offset="100%" />
    </linearGradient>
  </defs>

  <!-- Background path -->
  <path
    fill="url(#BG)"
    fill-rule="nonzero"
    d="M0 198.78c0 41.458 14.945 79.236 39.539 107.786 28.214 32.765 69.128 53.365 114.734 53.434a148.44 148.44 0 0056.495-11.036c9.051-3.699 19.182-3.274 27.948 1.107a75.779 75.779 0 0033.957 8.01c5.023 0 9.942-.494 14.7-1.433 13.58-2.67 25.94-8.99 36.09-17.94 6.378-5.627 14.547-8.456 22.897-8.446h.142c27.589 0 53.215-8.732 74.492-23.696 19.021-13.36 34.554-31.696 44.904-53.224C474.92 234.58 480 213.388 480 190.958c0-76.93-59.774-139.305-133.498-139.305-7.516 0-14.88.663-22.063 1.899C305.418 21.42 271.355 0 232.499 0a103.651 103.651 0 00-45.88 10.661c-13.24 6.487-25.011 15.705-34.64 26.939-32.698.544-62.931 11.69-87.676 30.291C25.351 97.155 0 144.882 0 198.781z"
    opacity="0.2"
  />

  <!-- Document/folder elements with gradients -->
  <path
    fill="#FF4842"
    fill-rule="nonzero"
    d="M293.006 206.192c-2.248 2.672-4.676 2.628-6.123 2.251l.054-1.384s5.979-2.733 5.827-2.159c-.057.215.057.733.242 1.292zM309.393 209.217c-3.818 2.206-6.058-.38-6.578-1.112.32-.84.801-2.204.703-2.592-.144-.577 5.827 2.155 5.827 2.155l.048 1.549zM305.303 187.204s3.632-2.093 4.425-1.151c.792.942-4.425 1.151-4.425 1.151zM307.497 188.355s-.598.299.721.681c1.318.383-.721-.681-.721-.681zM285.532 182.599c-.123.036 3.022 2.123 5.862.395-.012 0-5.154-.61-5.862-.395zM291.239 186.591s-.861 1.692-2.625 1.943c-1.764.251 2.625-1.943 2.625-1.943zM302.785 190.262s4.138 6.578 3.346 8.129c-.793 1.552-3.346-8.129-3.346-8.129zM294.62 216.416c0 .368 0 .712-.036.996-.107 1.33-3.381.828-3.381.828-2.99.416-4.066-1.019-4.422-2.392a5.444 5.444 0 01-.164-1.363 5.606 5.606 0 01.054-.819v-.272a1.998 1.998 0 011.859.379c1.331 1.08 3.095.252 3.095.252s1.294.107 1.793.538c.281.242.745-.341 1.098-.897.021.359.054 1.007.074 1.701.024.356.03.714.03 1.049z"
    opacity="0.05"
  />

  <!-- Main tablet/clipboard -->
  <path
    fill="$primaryDarkerHex"
    fill-rule="nonzero"
    d="M157.592 279.461a4.114 4.114 0 01-.917-3.131l13.196-107.979 1.094-8.97a4.142 4.142 0 014.078-3.635l38.654-.257a4.135 4.135 0 004.108-4.249l-.015-.409a4.14 4.14 0 014.135-4.279h40.619a4.134 4.134 0 014.098 4.682 4.137 4.137 0 003.995 4.682l39.01.996a4.13 4.13 0 013.97 4.831l-19.502 113.909-.368 2.152a4.042 4.042 0 01-.598 1.543l-135.557.114z"
  />

  <!-- Document pages -->
  <path
    fill="#FFF"
    fill-rule="nonzero"
    d="M251.256817 123.296578L274.098317 123.296578 274.098317 200.823078 251.256817 200.823078z"
    transform="rotate(34.64 262.678 162.06)"
  />

  <path
    fill="#FFC107"
    fill-rule="nonzero"
    d="M270.624591 129.857671L286.750291 129.857671 286.750291 145.983371 270.624591 145.983371z"
    transform="rotate(34.804 278.687 137.92)"
  />

  <path
    fill="#FFC107"
    fill-rule="nonzero"
    d="M260.275579 145.813111L276.423079 145.813111 276.423079 161.960611 260.275579 161.960611z"
    opacity="0.5"
    transform="rotate(34.64 268.35 153.887)"
  />

  <path
    fill="#FFC107"
    fill-rule="nonzero"
    d="M249.191579 161.852111L265.339079 161.852111 265.339079 177.999611 249.191579 177.999611z"
    opacity="0.3"
    transform="rotate(34.64 257.265 169.926)"
  />

  <path
    fill="#FFF"
    fill-rule="nonzero"
    d="M237.472537 121.334214L260.314037 121.334214 260.314037 198.567714 237.472537 198.567714z"
    transform="rotate(16.29 248.893 159.951)"
  />

  <path
    fill="#FF4842"
    fill-rule="nonzero"
    d="M249.053192 123.761554L265.200692 123.761554 265.200692 139.909054 249.053192 139.909054z"
    transform="rotate(16.29 257.127 131.835)"
  />

  <path
    fill="#FF4842"
    fill-rule="nonzero"
    d="M243.584192 142.473554L259.731692 142.473554 259.731692 158.621053 243.584192 158.621053z"
    opacity="0.5"
    transform="rotate(16.29 251.658 150.547)"
  />

  <path
    fill="#FF4842"
    fill-rule="nonzero"
    d="M238.116192 161.182554L254.263692 161.182554 254.263692 177.330054 238.116192 177.330054z"
    opacity="0.3"
    transform="rotate(16.29 246.19 169.256)"
  />

  <path
    fill="#FFF"
    fill-rule="nonzero"
    d="M230.099192 121.641542L252.940692 121.641542 252.940692 198.875042 230.099192 198.875042z"
    transform="rotate(4.6 241.52 160.258)"
  />

  <path
    fill="#1890FF"
    fill-rule="nonzero"
    d="M235.800489 122.985499L251.947989 122.985499 251.947989 139.132999 235.800489 139.132999z"
    transform="rotate(4.6 243.874 131.06)"
  />

  <path
    fill="#1890FF"
    fill-rule="nonzero"
    d="M234.234488 142.413498L250.381988 142.413498 250.381988 158.560998 234.234488 158.560998z"
    opacity="0.5"
    transform="rotate(4.6 242.308 150.487)"
  />

  <path
    fill="#1890FF"
    fill-rule="nonzero"
    d="M232.672488 161.846499L248.819988 161.846499 248.819988 177.993999 232.672488 177.993999z"
    opacity="0.3"
    transform="rotate(4.6 240.746 169.92)"
  />

  <path
    fill="#FFF"
    fill-rule="nonzero"
    d="M224.736657 123.384871L247.578157 123.384871 247.578157 200.618371 224.736657 200.618371z"
    transform="rotate(-2.61 236.157 162.002)"
  />

  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M226.751283 124.659968L242.898783 124.659968 242.898783 140.807468 226.751283 140.807468z"
    transform="rotate(-2.61 234.825 132.734)"
  />

  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M228.305601 143.479224L244.473301 143.479224 244.473301 159.646924 228.305601 159.646924z"
    opacity="0.5"
    transform="rotate(-2.862 236.39 151.563)"
  />

  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M228.525282 163.608968L244.672782 163.608968 244.672782 179.756468 228.525282 179.756468z"
    opacity="0.3"
    transform="rotate(-2.61 236.599 171.683)"
  />

  <!-- Floating elements -->
  <path
    fill="#F4F6F8"
    fill-rule="nonzero"
    d="M232.679 225.726l-20.294 7.851-29.661 11.466c-1.121-2.093-2.771-4.921-4.813-8.297-7.026-11.642-18.65-29.75-29.001-45.665-11.66-17.938-21.696-33.075-21.696-33.075l7.265-2.093 59.346-17.23 38.854 87.043z"
  />

  <path
    fill="#000"
    fill-rule="nonzero"
    d="M232.679 225.726l-20.294 7.851a152.535 152.535 0 01-34.484 3.169c-7.026-11.642-18.65-29.75-29-45.665l-14.42-35.18 59.343-17.218 38.855 87.043z"
    opacity="0.1"
  />

  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M247.777 220.841s-31.526 18.65-78.596 14.432l-37.525-91.486 17.984-3.091 62.168-10.677 35.279 89.043.69 1.779z"
  />

  <path
    fill="#FF4842"
    fill-rule="nonzero"
    d="M247.075 219.074c-7.424.365-16.013.329-24.654-.702-9.351-1.101-18.757-3.367-26.82-7.523-6.742-3.471-12.506-7.247-17.532-11.776-13.074-11.759-21.164-28.579-28.429-58.365l62.168-10.677 35.267 89.043z"
    opacity="0.1"
  />

  <path
    fill="#FFF"
    fill-rule="nonzero"
    d="M270.203 213.959s-23.239 4.55-46.894 1.749c-9.351-1.1-18.757-3.367-26.82-7.522-6.742-3.471-12.503-7.247-17.532-11.777-16.181-14.557-24.725-36.866-33.536-81.918 0 0 38.633 9.325 76.836-11.101-.012.015 12.865 80.373 47.946 110.569z"
  />

  <!-- Lines and decorative elements -->
  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M165.405 131.03s31.416-1.776 40.187-8.548l1.331 4.276s-20.758 9.157-41.518 9.268v-4.996zM165.405 152.137s30.417-1.665 53.399-12.766l.777 1.776s-18.237 10.647-54.176 13.433v-2.443zM167.853 160.362s30.418-1.665 53.397-12.766l.777 1.776s-18.237 10.643-54.174 13.433v-2.443zM170.299 168.599s30.417-1.666 53.399-12.766l.774 1.775s-18.237 10.647-54.173 13.433v-2.442zM172.748 176.835s30.417-1.665 53.396-12.766l.777 1.776s-18.237 10.647-54.173 13.433v-2.443zM175.193 185.075s30.417-1.665 53.399-12.766l.774 1.776s-18.237 10.643-54.173 13.433v-2.443z"
    opacity="0.3"
  />

  <!-- Upload folder container -->
  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M269.277 168.76l-45.767.493a3.127 3.127 0 00-3.094 3.125v3.782a3.127 3.127 0 01-3.05 3.124l-33.024.792a3.124 3.124 0 01-3.095-2.308l-1.551-5.701a3.124 3.124 0 00-3.053-2.308l-44.113.475a3.125 3.125 0 00-3.05 3.648l17.747 104.449a3.129 3.129 0 003.071 2.604l139.363.598a3.129 3.129 0 003.082-3.714l-20.366-106.521a3.125 3.125 0 00-3.1-2.538z"
  />

  <path
    fill="$primaryDarkHex"
    fill-rule="nonzero"
    d="M269.277 168.76l-45.767.493a3.127 3.127 0 00-3.094 3.125v3.782a3.127 3.127 0 01-3.05 3.124l-33.024.792a3.124 3.124 0 01-3.095-2.308l-1.551-5.701a3.124 3.124 0 00-3.053-2.308l-44.113.475a3.125 3.125 0 00-3.05 3.648l17.747 104.449a3.129 3.129 0 003.071 2.604l139.363.598a3.129 3.129 0 003.082-3.714l-20.366-106.521a3.125 3.125 0 00-3.1-2.538z"
    opacity="0.243"
  />

  <path
    fill="url(#linearGradient-2)"
    fill-rule="nonzero"
    d="M269.277 168.76l-45.767.493a3.127 3.127 0 00-3.094 3.125v3.782a3.127 3.127 0 01-3.05 3.124l-33.024.792a3.124 3.124 0 01-3.095-2.308l-1.551-5.701a3.124 3.124 0 00-3.053-2.308l-44.113.475a3.125 3.125 0 00-3.05 3.648l17.747 104.449a3.129 3.129 0 003.071 2.604l139.363.598a3.129 3.129 0 003.082-3.714l-20.366-106.521a3.125 3.125 0 00-3.1-2.538z"
    opacity="0.32"
  />

  <!-- Plants/decorative bottom elements -->
  <ellipse
    cx="119.593"
    cy="258.664"
    fill="$primaryMainHex"
    fill-rule="nonzero"
    opacity="0.1"
    rx="4.846"
    ry="1"
  />

  <ellipse
    cx="101.03"
    cy="260.545"
    fill="$primaryMainHex"
    fill-rule="nonzero"
    opacity="0.1"
    rx="4.846"
    ry="1"
  />

  <!-- Upload icon circle -->
  <circle
    cx="206.029"
    cy="224.351"
    r="14.44"
    fill="$primaryDarkHex"
    fill-rule="nonzero"
  />

  <path
    fill="$primaryMainHex"
    fill-rule="nonzero"
    d="M206.029 211.59c7.047 0 12.761 5.714 12.761 12.761 0 7.048-5.714 12.761-12.761 12.761-7.048 0-12.761-5.713-12.761-12.761.006-7.045 5.716-12.754 12.761-12.761"
    opacity="0.72"
  />

  <!-- Upload arrow -->
  <path
    fill="$primaryDarkHex"
    fill-rule="nonzero"
    d="M200.058 225.406l-.699-.681a.721.721 0 010-1.065l6.127-5.984a.753.753 0 01.546-.231c.206 0 .404.083.545.231l6.127 5.978a.733.733 0 010 1.065l-.699.682a.768.768 0 01-1.091 0l-3.622-3.727v8.843a.725.725 0 01-.219.523.76.76 0 01-.534.217h-1.009a.75.75 0 01-.759-.74v-8.832l-3.622 3.726a.768.768 0 01-1.091-.005z"
  />

  <!-- Small decorative circles -->
  <circle
    cx="84.467"
    cy="87.003"
    r="6.467"
    fill="$primaryMainHex"
    fill-rule="nonzero"
    opacity="0.1"
  />

  <circle
    cx="395.425"
    cy="138.681"
    r="6.467"
    fill="$primaryMainHex"
    fill-rule="nonzero"
    opacity="0.1"
  />

  <circle
    cx="279.178"
    cy="66.467"
    r="6.467"
    fill="$primaryMainHex"
    fill-rule="nonzero"
    opacity="0.1"
  />

  <circle
    cx="97.4"
    cy="122.68"
    r="10.838"
    fill="$primaryMainHex"
    fill-rule="nonzero"
    opacity="0.1"
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
