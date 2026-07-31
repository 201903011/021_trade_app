import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:minimals/locale/index.dart';
import 'package:minimals/constants/assets_path.dart';

@Singleton()
class EnhancedLocalizationService extends Translations {
  final _storage = GetStorage();
  static const String _localeKey = 'selected_locale';

  // Combine new translations with existing asset translations
  static final Map<String, Map<String, String>> _allTranslations = {
    ...AppTranslations.translations, // New locale system translations
  };

  EnhancedLocalizationService() {
    _loadAssetTranslations();
  }

  /// Load translations from asset files and merge with new translations
  Future<void> _loadAssetTranslations() async {
    try {
      for (LanguageConfig langConfig in allLangs) {
        final localeKey = '${langConfig.locale.languageCode}_${langConfig.locale.countryCode}';

        // Skip if we already have translations for this locale
        if (_allTranslations.containsKey(localeKey)) continue;

        try {
          // Try loading from assets
          String jsonContent = await rootBundle.loadString('${AppAssets.langPath}${langConfig.value}.json');
          Map<String, dynamic> translationsMap = json.decode(jsonContent);
          Map<String, String> parsedTranslations = {};

          // Flatten nested JSON structure
          translationsMap.forEach((pageKey, pageTranslations) {
            if (pageTranslations is Map<String, dynamic>) {
              pageTranslations.forEach((key, value) {
                if (value is String) {
                  parsedTranslations['$pageKey.$key'] = value;
                }
              });
            } else if (pageTranslations is String) {
              parsedTranslations[pageKey] = pageTranslations;
            }
          });

          // Merge with existing translations
          if (_allTranslations.containsKey(localeKey)) {
            _allTranslations[localeKey]!.addAll(parsedTranslations);
          } else {
            _allTranslations[localeKey] = parsedTranslations;
          }
        } catch (e) {
          debugPrint('Could not load asset translations for ${langConfig.label}: $e');
        }
      }
    } catch (e) {
      debugPrint('Error loading asset translations: $e');
    }
  }

  @override
  Map<String, Map<String, String>> get keys => _allTranslations;

  /// Change locale using the new locale system
  Future<void> changeLocale(String langValue) async {
    final langConfig = getLanguageByValue(langValue);
    if (langConfig == null) return;

    final locale = langConfig.locale;
    Get.updateLocale(locale);
    await _saveLocale(locale);
  }

  /// Save locale preference
  Future<void> _saveLocale(Locale locale) async {
    final String localeString = '${locale.languageCode}_${locale.countryCode}';
    await _storage.write(_localeKey, localeString);
  }

  /// Load saved locale preference
  Future<Locale> loadSavedLocale() async {
    try {
      final localeString = _storage.read<String>(_localeKey);
      if (localeString != null) {
        final parts = localeString.split('_');
        final locale = Locale(parts[0], parts.length > 1 ? parts[1] : '');

        // Verify this locale is supported
        final langConfig = getLanguageByLocale(locale);
        if (langConfig != null) {
          return locale;
        }
      }
    } catch (e) {
      debugPrint('Error loading saved locale: $e');
    }
    return defaultLang.locale;
  }

  /// Get all supported locales
  static List<Locale> get supportedLocales => allLangs.map((lang) => lang.locale).toList();

  /// Get fallback locale
  static Locale get fallbackLocale => defaultLang.locale;
}
