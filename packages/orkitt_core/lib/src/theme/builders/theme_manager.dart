import 'package:flutter/material.dart';

/// A customizable theme manager that provides responsive theme switching
/// between light, dark, and system modes with change notification support.
///
/// Extend this class to define your application's specific light and dark themes,
/// then use the provided methods to manage theme changes throughout your app.
abstract class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late ThemeData _currentTheme;

  /// The light theme configuration for your application
  abstract final ThemeData lightTheme;

  /// The dark theme configuration for your application
  abstract final ThemeData darkTheme;

  /// Returns the current active theme mode
  ThemeMode get themeMode => _themeMode;

  /// Returns the current theme data based on active theme mode
  ThemeData get themeData => _currentTheme;

  /// Checks if dark mode is currently active
  bool get isDarkMode {
    switch (_themeMode) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    }
  }

  ThemeManager() {
    _updateTheme();
  }

  /// Changes the current theme mode
  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    _updateTheme();
  }

  /// Forces a theme refresh, useful when system brightness changes
  void refreshTheme() {
    _updateTheme();
  }

  /// Toggles between light and dark modes only
  void toggleTheme() {
    setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  /// Cycles through all available theme modes: Light → Dark → System
  void cycleThemeModes() {
    setThemeMode(
      _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : _themeMode == ThemeMode.dark
          ? ThemeMode.system
          : ThemeMode.light,
    );
  }

  /// Called whenever the theme changes - override to perform custom actions
  void onThemeUpdated();

  void _updateTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _currentTheme = lightTheme;
        break;
      case ThemeMode.dark:
        _currentTheme = darkTheme;
        break;
      case ThemeMode.system:
        final systemBrightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _currentTheme = systemBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
        break;
    }

    notifyListeners();
    onThemeUpdated();
  }
}
