import 'package:flutter/material.dart';

/// List of Right-to-Left (RTL) languages
const rtlLanguages = [
  'ar', // Arabic
  'he', // Hebrew
  'fa', // Persian
  'ur', // Urdu
];

/// Utility function to check if a language is RTL
bool isRtlLanguage(String languageCode) {
  return rtlLanguages.contains(languageCode);
}

/// A registry of supported languages
class LanguageData {
  static const Map<String, String> languageNames = {
    // Major global
    'en': 'English',
    'bn': 'বাংলা',
    'hi': 'हिन्दी',
    'ur': 'اردو',
    'ar': 'العربية',
    'fa': 'فارسی',
    'zh': '中文',
    'ja': '日本語',
    'ko': '한국어',
    'ru': 'Русский',

    // European
    'fr': 'Français',
    'de': 'Deutsch',
    'es': 'Español',
    'pt': 'Português',
    'it': 'Italiano',
    'nl': 'Nederlands',
    'sv': 'Svenska',
    'no': 'Norsk',
    'da': 'Dansk',
    'fi': 'Suomi',
    'pl': 'Polski',
    'cs': 'Čeština',
    'sk': 'Slovenčina',
    'hu': 'Magyar',
    'ro': 'Română',
    'bg': 'Български',
    'uk': 'Українська',
    'el': 'Ελληνικά',

    // South & Southeast Asia
    'ta': 'தமிழ்',
    'te': 'తెలుగు',
    'ml': 'മലയാളം',
    'kn': 'ಕನ್ನಡ',
    'mr': 'मराठी',
    'gu': 'ગુજરાતી',
    'pa': 'ਪੰਜਾਬੀ',
    'si': 'සිංහල',
    'ne': 'नेपाली',
    'th': 'ไทย',
    'vi': 'Tiếng Việt',
    'id': 'Bahasa Indonesia',
    'ms': 'Bahasa Melayu',
    'fil': 'Filipino',

    // Middle East & Africa
    'he': 'עברית',
    'sw': 'Kiswahili',
    'am': 'አማርኛ',
    'ha': 'Hausa',
    'yo': 'Yorùbá',
    'ig': 'Igbo',
    'zu': 'isiZulu',

    // Others
    'tr': 'Türkçe',
    'az': 'Azərbaycanca',
    'kk': 'Қазақша',
    'uz': 'O‘zbek',
    'mn': 'Монгол',
  };

  /// Get the native name of a language code
  static String getLanguageName(Locale locale) {
    return languageNames[locale.languageCode] ??
        locale.languageCode; // fallback
  }
}

/// A high-level localization utility class
///
class LanguageUtils {
  /// Get native name of the locale
  ///
  /// Usecase:
  /// ```dart
  /// final name = LanguageUtils.getName(Locale('es')); // Español
  // final locale = const Locale('bn');

  //   print(LanguageUtils.getName(locale));       // বাংলা
  //   print(LanguageUtils.getFormatted(locale)); // বাংলা (BN)
  //   print(LanguageUtils.isRTL(locale));        // false
  //   print(LanguageUtils.describe(locale));     // বাংলা - Unknown

  //   print(LanguageUtils.supportedLocales());   // [en, bn, es, ...]
  /// ```
  ///
  static String getName(Locale locale) {
    return LanguageData.getLanguageName(locale);
  }

  /// Get formatted name with language code
  static String getFormatted(Locale locale) {
    final name = getName(locale);
    return "$name (${locale.languageCode.toUpperCase()})";
  }

  /// Check if this locale is RTL
  static bool isRTL(Locale locale) {
    return isRtlLanguage(locale.languageCode);
  }

  /// Convert a locale to a friendly display text
  static String describe(Locale locale) {
    return "${getName(locale)} - ${locale.countryCode ?? 'Unknown'}";
  }

  /// List all supported languages
  static List<Locale> supportedLocales() {
    return LanguageData.languageNames.keys.map((code) => Locale(code)).toList();
  }
}
