import 'langs/en.dart';
import 'langs/ar.dart';
import 'langs/fr.dart';
import 'langs/vi.dart';
import 'langs/cn.dart';
import 'langs/hi.dart';

/// All translations for the application
class AppTranslations {
  static const Map<String, Map<String, String>> translations = {
    'en_US': en,
    'ar_SA': ar,
    'fr_FR': fr,
    'vi_VN': vi,
    'zh_CN': cn,
    'hi_IN': hi,
  };

  /// Get translations for a specific locale
  static Map<String, String>? getTranslationsForLocale(String locale) {
    return translations[locale];
  }

  /// Get all available locales
  static List<String> get availableLocales => translations.keys.toList();
}
