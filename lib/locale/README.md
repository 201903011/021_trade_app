# Flutter Locale System

This is a comprehensive localization system for Flutter that provides:

- **Multi-language support** with RTL (Right-to-Left) capability
- **Automatic text direction handling**
- **Persistent language preferences**
- **Easy translation management**
- **Ready-to-use UI components**

## Features

### ✅ Supported Languages
- English (en_US) - LTR
- Arabic (ar_SA) - RTL
- French (fr_FR) - LTR
- Vietnamese (vi_VN) - LTR
- Chinese (zh_CN) - LTR  
- Hindi (hi_IN) - LTR

### ✅ Key Components
- `LocaleController` - Manages language state and preferences
- `LocalizationWrapper` - Provides directionality context
- `LanguageSelector` - UI components for language selection
- `LocaleMixin` - Easy access to translation functions

## Usage

### 1. Basic Setup

The locale system is already integrated into `MyApp`. The app automatically:
- Loads the saved language preference
- Sets up proper text direction (LTR/RTL)
- Provides translation context

### 2. Using Translations

#### Method 1: Using LocaleMixin
```dart
class MyWidget extends StatelessWidget with LocaleMixin {
  @override
  Widget build(BuildContext context) {
    return Text(tr('welcome')); // Translated text
  }
}
```

#### Method 2: Using LocaleController directly
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    return Text(localeController.translate('welcome'));
  }
}
```

#### Method 3: Using GetX built-in translation
```dart
Text('welcome'.tr)
```

### 3. Language Selection UI

#### Horizontal Selector
```dart
const LanguageSelector()
```

#### Dropdown Selector
```dart
const LanguageDropdown()
```

#### Dialog Selector
```dart
ElevatedButton(
  onPressed: () => LanguageSelectorDialog.show(context),
  child: Text('Select Language'),
)
```

### 4. Accessing Current Language Info

```dart
final localeController = Get.find<LocaleController>();

// Current language
LanguageConfig currentLang = localeController.currentLang;

// Text direction
TextDirection direction = localeController.textDirection;

// Check if RTL
bool isRTL = localeController.isRTL;

// Current locale
Locale locale = localeController.currentLocale;
```

### 5. Programmatic Language Change

```dart
final localeController = Get.find<LocaleController>();
await localeController.changeLanguage('ar'); // Switch to Arabic
```

### 6. Adding New Languages

1. **Add language config** in `config_lang.dart`:
```dart
LanguageConfig(
  label: 'Español',
  value: 'es',
  locale: Locale('es', 'ES'),
  icon: '/assets/icons/flags/ic_flag_es.svg',
  isRTL: false,
),
```

2. **Create translation file** `langs/es.dart`:
```dart
const Map<String, String> es = {
  'welcome': 'Bienvenido',
  'home': 'Inicio',
  // ... more translations
};
```

3. **Add to translations** in `app_translations.dart`:
```dart
static const Map<String, Map<String, String>> translations = {
  'en_US': en,
  'ar_SA': ar,
  'es_ES': es, // Add new language
  // ... other languages
};
```

## File Structure

```
lib/locale/
├── index.dart                     # Main exports
├── config_lang.dart              # Language configurations
├── locale_controller.dart        # Main controller
├── localization_wrapper.dart     # Direction wrapper
├── app_translations.dart         # Translation maps
├── enhanced_localization_service.dart  # Service integration
├── language_selector.dart        # UI components
├── locale_demo.dart              # Demo/example screen
└── langs/
    ├── en.dart                   # English translations
    ├── ar.dart                   # Arabic translations
    ├── fr.dart                   # French translations
    ├── vi.dart                   # Vietnamese translations
    ├── cn.dart                   # Chinese translations
    └── hi.dart                   # Hindi translations
```

## Key Features

### 🌍 Automatic Direction Handling
The system automatically handles text direction based on the selected language:
- **LTR Languages**: English, French, Vietnamese, Chinese, Hindi
- **RTL Languages**: Arabic

### 💾 Persistent Preferences
User language preferences are automatically saved and restored on app restart.

### 🎨 UI Components
Ready-to-use components for language selection:
- Horizontal selector with flags
- Dropdown selector
- Modal dialog selector

### 🔄 Real-time Updates
Language changes are applied immediately throughout the app without restart.

### 🛡️ Fallback System
If a translation is missing, the system falls back to English or shows the translation key.

## Demo

To see the locale system in action, navigate to the `LocaleDemo` screen which demonstrates:
- Current language information
- Translation examples
- Language selector components
- Direction handling

## Migration from React TypeScript

This Flutter implementation provides equivalent functionality to the React TypeScript locale system:

- `useLocales` hook → `LocaleController` + `LocaleMixin`
- `allLangs` config → `allLangs` constant
- `defaultLang` → `defaultLang` constant  
- `handleChangeLanguage` → `changeLanguage` method
- `onChangeDirectionByLang` → Automatic direction handling
- `ThemeLocalization` → `LocalizationWrapper`

## Best Practices

1. **Use LocaleMixin** for easy access to translations
2. **Keep translation keys consistent** across all languages
3. **Test RTL languages** thoroughly, especially Arabic
4. **Use semantic keys** like `'button.save'` instead of `'save_btn'`
5. **Provide fallbacks** for missing translations
6. **Consider context** when translating (formal vs informal)

## Troubleshooting

### Common Issues

1. **Missing translations**: Check if the key exists in all language files
2. **Direction not working**: Ensure `LocalizationWrapper` is properly set up
3. **Language not persisting**: Check if GetStorage is initialized
4. **RTL layout issues**: Test with Arabic language and adjust layouts as needed

### Debug Mode

In debug mode, the system will print warnings for:
- Missing translation keys
- Storage initialization failures
- Language loading errors
