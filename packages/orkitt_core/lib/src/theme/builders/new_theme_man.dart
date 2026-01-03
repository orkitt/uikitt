import 'dart:async';
import 'package:flutter/material.dart';

/// A pure, framework-agnostic theme manager.
/// No ChangeNotifier. No Provider.
/// Works anywhere: BLoC, Riverpod, GetX, MobX, etc.
///
/// Emits updates via a broadcast stream.
/// Consumers decide how to listen.
abstract class ThemeManager {
  ThemeMode _themeMode = ThemeMode.system;
  late ThemeData _currentTheme;

  /// Stream of theme updates
  final StreamController<ThemeData> _themeStreamController =
      StreamController<ThemeData>.broadcast();

  /// Light Theme (implemented by subclass)
  ThemeData get lightTheme;

  /// Dark Theme (implemented by subclass)
   ThemeData get darkTheme;

  /// Public Stream to listen to theme changes
  Stream<ThemeData> get onThemeChanged => _themeStreamController.stream;

  ThemeMode get themeMode => _themeMode;
  ThemeData get themeData => _currentTheme;

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

  // ------------------------------------------------------------
  // THEME UPDATE OPERATIONS
  // ------------------------------------------------------------

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    _updateTheme();
  }

  void toggleTheme() {
    setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  void cycleTheme() {
    setThemeMode(
      _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : _themeMode == ThemeMode.dark
              ? ThemeMode.system
              : ThemeMode.light,
    );
  }

  void refresh() => _updateTheme();

  // ------------------------------------------------------------
  // INTERNAL UPDATE LOGIC
  // ------------------------------------------------------------

  void _updateTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _currentTheme = lightTheme;
        break;

      case ThemeMode.dark:
        _currentTheme = darkTheme;
        break;

      case ThemeMode.system:
        final b = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _currentTheme = b == Brightness.dark ? darkTheme : lightTheme;
        break;
    }

    onThemeUpdated();

    // send update to consumers
    _themeStreamController.add(_currentTheme);
  }

  /// Optional override for logging or analytics
  void onThemeUpdated() {}

  /// Clean up if needed
  void dispose() {
    _themeStreamController.close();
  }
}
// final themeManager = Provider((_) => MyThemeManager());

// final themeProvider = StreamProvider(
//   (ref) => ref.watch(themeManager).onThemeChanged,
// );
// class ThemeCubit extends Cubit<ThemeData> {
//   ThemeCubit(this.manager) : super(manager.themeData) {
//     manager.onThemeChanged.listen(emit);
//   }

//   final ThemeManager manager;
// }
// final manager = MyThemeManager();
// final themeRx = manager.themeData.obs;

// manager.onThemeChanged.listen((t) => themeRx.value = t);

