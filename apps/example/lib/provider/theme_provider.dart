import 'package:example/core/colors.dart';
import 'package:example/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:orkitt/orkitt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ThemeManager {
  static const _themeKey = 'selected_theme';

  AppTheme() {
    _loadThemeFromPrefs();
  }

  @override
  ThemeData get lightTheme =>
      ThemeBuilder.build(AppLightColors());

  @override
  ThemeData get darkTheme =>
      ThemeBuilder.build(AppDarkColors());

  /// Load theme from shared preferences
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Future<void> onThemeUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, themeMode == ThemeMode.dark);
    debug(
      "Current theme mode: ${themeMode == ThemeMode.dark ? 'Dark' : 'Light'}",
    );
  }
}

final themeProvider = ChangeNotifierProvider<AppTheme>((ref) {
  return AppTheme();
});
