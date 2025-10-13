part of 'package:orkitt/orkitt.dart';

/// *****************************************************************************
/// 
/// Orkitt UI Kit v1.0.0
/// Copyright (c) 2024 [Orkitt]. All rights reserved.
/// BSD 3-Clause License - see LICENSE for details.
/// Initial Release: November 2025
/// Based on: Flutter Addons Library v3.0.0 (Legacy Framework)
/// Developed by AR Rahman
///
/// A modern, brand-driven UI framework that extends Flutter’s core capabilities
/// with beautifully crafted components, typography, color systems, and layout
/// extensions — designed to accelerate high-quality app development under the
/// Orkitt design principles.
///
/// Repository: https://github.com/orkitt/uikit
/// Documentation: https://docs.orkitt.dev/uikit
/// *****************************************************************************
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