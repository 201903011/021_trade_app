import 'package:flutter/material.dart';

/// Language configuration for the application
/// PLEASE REMOVE LOCAL STORAGE WHEN YOU CHANGE SETTINGS.
/// ----------------------------------------------------------------------

class LanguageConfig {
  final String label;
  final String value;
  final Locale locale;
  final String icon;
  final bool isRTL;

  const LanguageConfig({
    required this.label,
    required this.value,
    required this.locale,
    required this.icon,
    this.isRTL = false,
  });
}

/// All available languages
const List<LanguageConfig> allLangs = [
  LanguageConfig(
    label: 'English',
    value: 'en',
    locale: Locale('en', 'US'),
    icon: '/assets/icons/flags/ic_flag_en.svg',
    isRTL: false,
  ),
  LanguageConfig(
    label: 'French',
    value: 'fr',
    locale: Locale('fr', 'FR'),
    icon: '/assets/icons/flags/ic_flag_fr.svg',
    isRTL: false,
  ),
  LanguageConfig(
    label: 'Vietnamese',
    value: 'vi',
    locale: Locale('vi', 'VN'),
    icon: '/assets/icons/flags/ic_flag_vn.svg',
    isRTL: false,
  ),
  LanguageConfig(
    label: 'Chinese',
    value: 'cn',
    locale: Locale('zh', 'CN'),
    icon: '/assets/icons/flags/ic_flag_cn.svg',
    isRTL: false,
  ),
  LanguageConfig(
    label: 'Arabic (Sudan)',
    value: 'ar',
    locale: Locale('ar', 'SA'),
    icon: '/assets/icons/flags/ic_flag_sa.svg',
    isRTL: true,
  ),
  LanguageConfig(
    label: 'हिन्दी',
    value: 'hi',
    locale: Locale('hi', 'IN'),
    icon: '/assets/icons/flags/ic_flag_in.svg',
    isRTL: false,
  ),
];

/// Default language (English)
const LanguageConfig defaultLang = LanguageConfig(
  label: 'English',
  value: 'en',
  locale: Locale('en', 'US'),
  icon: '/assets/icons/flags/ic_flag_en.svg',
  isRTL: false,
);

/// Get language config by value
LanguageConfig? getLanguageByValue(String value) {
  try {
    return allLangs.firstWhere((lang) => lang.value == value);
  } catch (e) {
    return defaultLang;
  }
}

/// Get language config by locale
LanguageConfig? getLanguageByLocale(Locale locale) {
  try {
    return allLangs.firstWhere((lang) => lang.locale.languageCode == locale.languageCode && lang.locale.countryCode == locale.countryCode);
  } catch (e) {
    return defaultLang;
  }
}

/// Get text direction based on language
TextDirection getTextDirection(String langValue) {
  final lang = getLanguageByValue(langValue);
  return lang?.isRTL == true ? TextDirection.rtl : TextDirection.ltr;
}

/// Get all supported locales
List<Locale> get supportedLocales => allLangs.map((lang) => lang.locale).toList();
