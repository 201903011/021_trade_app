import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimals/locale/config_lang.dart';

/// Locale controller to manage language changes and directionality
class LocaleController extends GetxController {
  final _storage = GetStorage();
  static const String _localeKey = 'selected_locale';
  static const String _directionKey = 'text_direction';

  // Observable values
  final Rx<LanguageConfig> _currentLang = defaultLang.obs;
  final Rx<TextDirection> _textDirection = TextDirection.ltr.obs;

  // Getters
  LanguageConfig get currentLang => _currentLang.value;
  TextDirection get textDirection => _textDirection.value;
  List<LanguageConfig> get allLanguages => allLangs;
  Locale get currentLocale => _currentLang.value.locale;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  /// Load saved language from storage
  void _loadSavedLanguage() {
    try {
      final savedLangValue = _storage.read<String>(_localeKey);
      final savedDirection = _storage.read<String>(_directionKey);

      if (savedLangValue != null) {
        final lang = getLanguageByValue(savedLangValue);
        if (lang != null) {
          _currentLang.value = lang;
          _textDirection.value = savedDirection == 'rtl' ? TextDirection.rtl : TextDirection.ltr;
        }
      }
    } catch (e) {
      // If error loading, keep default values
      debugPrint('Error loading saved language: $e');
    }
  }

  /// Change language and update locale
  Future<void> changeLanguage(String langValue) async {
    try {
      final newLang = getLanguageByValue(langValue);
      if (newLang == null) return;

      // Update current language
      _currentLang.value = newLang;

      // Update text direction
      _textDirection.value = getTextDirection(langValue);

      // Update GetX locale
      Get.updateLocale(newLang.locale);

      // Save to storage
      await _saveLanguageSettings(langValue);

      // Trigger rebuild for direction change
      update();
    } catch (e) {
      debugPrint('Error changing language: $e');
    }
  }

  /// Save language settings to storage
  Future<void> _saveLanguageSettings(String langValue) async {
    try {
      await _storage.write(_localeKey, langValue);
      await _storage.write(_directionKey, _textDirection.value == TextDirection.rtl ? 'rtl' : 'ltr');
    } catch (e) {
      debugPrint('Error saving language settings: $e');
    }
  }

  /// Get translation with fallback
  String translate(String key, {Map<String, String>? args}) {
    String translation = key.tr;

    // If translation is the same as key, it means translation not found
    if (translation == key) {
      // Try to get from English as fallback
      translation = key.tr;
    }

    // Replace arguments if provided
    if (args != null) {
      args.forEach((argKey, argValue) {
        translation = translation.replaceAll('{$argKey}', argValue);
      });
    }

    return translation;
  }

  /// Check if current language is RTL
  bool get isRTL => _textDirection.value == TextDirection.rtl;

  /// Get language by value (helper method)
  LanguageConfig? getLanguageByValue(String value) {
    return allLangs.cast<LanguageConfig?>().firstWhere(
          (lang) => lang?.value == value,
          orElse: () => null,
        );
  }

  /// Get initial locale for app startup
  static Locale getInitialLocale() {
    try {
      final storage = GetStorage();
      final savedLangValue = storage.read<String>(_localeKey);
      if (savedLangValue != null) {
        final lang = allLangs.cast<LanguageConfig?>().firstWhere(
              (lang) => lang?.value == savedLangValue,
              orElse: () => null,
            );
        return lang?.locale ?? defaultLang.locale;
      }
    } catch (e) {
      debugPrint('Error getting initial locale: $e');
    }
    return defaultLang.locale;
  }

  /// Get initial text direction for app startup
  static TextDirection getInitialTextDirection() {
    try {
      final storage = GetStorage();
      final savedDirection = storage.read<String>(_directionKey);
      return savedDirection == 'rtl' ? TextDirection.rtl : TextDirection.ltr;
    } catch (e) {
      debugPrint('Error getting initial text direction: $e');
    }
    return TextDirection.ltr;
  }
}
