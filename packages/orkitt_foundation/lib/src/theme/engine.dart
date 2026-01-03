import 'package:flutter/material.dart';

/// *****************************************************************************
///
/// Orkitt UI Kit v1.0.0
/// Copyright (c) 2024 [Orkitt]. All rights reserved.
/// BSD 3-Clause License - see LICENSE for details.
/// Initial Release: November 2025
/// Based on: Flutter Addons Library v3.0.0 (Legacy Framework)
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
///

extension ThemeColorExtract on Color {
  /// Converts the `Color` object to a hexadecimal string representation.
  /// The output can be customized to include or exclude the leading '#' symbol and the alpha (transparency) value.
  ///
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}


///
/// Extension methods for Color manipulation
/// 

