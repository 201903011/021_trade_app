import 'dart:convert';
import 'package:minimals/constants/assets_path.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class LocalizationService extends Translations {
  final _storage = GetStorage();

  LocalizationService() {
    loadTranslations();
  }

  static const locale = Locale('en', 'US');
  static const fallbackLocale = Locale('en', 'US');

  static final langs = [
    'English',
    'हिन्दी',
    // Add more languages here
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('hi', 'IN'),
    // Add more locales here
  ];

  static final Map<String, Map<String, String>> _translations = {};

  Future<void> loadTranslations() async {
    try {
      for (Locale locale in locales) {
        String langCode = locale.languageCode;
        String jsonContent = await rootBundle.loadString('${AppAssets.langPath}$langCode.json');
        Map<String, dynamic> translationsMap = json.decode(jsonContent);
        Map<String, String> parsedTranslations = {};
        translationsMap.forEach((pageKey, pageTranslations) {
          (pageTranslations as Map<String, dynamic>).forEach((key, value) {
            if (value is String) {
              parsedTranslations['$pageKey.$key'] = value;
            }
          });
        });
        _translations['${locale.languageCode}_${locale.countryCode ?? ''}'] = parsedTranslations;
      }
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  @override
  Map<String, Map<String, String>> get keys => _translations;

  void changeLocale(String lang) async {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    await _saveLocale(locale);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    switch (lang) {
      case 'en':
        return const Locale('en', 'US');
      case 'hi':
        return const Locale('hi', 'IN');
      // Add more cases for other languages
      default:
        return const Locale('en', 'US'); // Default to English if language not found
    }
  }

  Future<void> _saveLocale(Locale locale) async {
    final String localeString = '${locale.languageCode}_${locale.countryCode}';
    await _storage.write('locale', localeString);
  }

  Future<Locale> loadSavedLocale() async {
    final localeString = _storage.read<String>('locale') ?? 'en_US';
    final parts = localeString.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : '');
  }
}
