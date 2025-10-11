part of 'package:orkitt/orkitt.dart';


/// Orkitt ThemeEngine provides a structured approach to application theming,
/// facilitating the implementation of color palettes, typography, and component styles
/// with support for dynamic theming and custom extensions.
///

abstract class OrkittThemeEngine {
  /// Provides the application's ColorScheme
  ColorScheme get colorScheme;

  /// Provides the application's TextTheme
  TextTheme get textTheme;

  /// Generates ThemeData from the theme engine configuration
  ThemeData get themeData;
}
/// The engine adheres to Material Design Guidelines to ensure visual consistency
/// and maintainable theme architecture.