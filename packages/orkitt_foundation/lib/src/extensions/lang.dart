

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
    'en': 'English',
    'bn': 'বাংলা',
    'es': 'Español',
    'fr': 'Français',
    'ar': 'العربية',
    'hi': 'हिन्दी',
    'zh': '中文',
    'ru': 'Русский',
    'ja': '日本語',
    'de': 'Deutsch',
    'pt': 'Português',
    'tr': 'Türkçe',
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
