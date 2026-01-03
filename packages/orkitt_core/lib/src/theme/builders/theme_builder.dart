import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';


/// Centralized theme management system that handles application theme settings,
/// including color schemes and typography configurations.
///
/// Implements the [OrkittThemeEngine] interface to provide consistent theme
/// generation with built-in caching for performance optimization.
class ThemeBuilder implements OrkittThemeEngine {
  final Palette colors;
  final BrandTypo typography;

  /// Constructs a ThemeMaker instance with specified color and typography configurations
  ///
  /// [colors] - The color palette for theme generation
  /// [typography] - Optional typography configuration, defaults to [FallBackTypography] when not provided
  ThemeBuilder(this.colors, [BrandTypo? typography])
    : typography = typography ?? FallBackTypography();

  @override
  ColorScheme get colorScheme => colors.colorScheme;

  @override
  TextTheme get textTheme {
    try {
      return typography.toTextTheme(colorScheme);
    } catch (e) {
      // Fallback to empty TextTheme to maintain application stability
      // during typography conversion failures
      return const TextTheme();
    }
  }

  @override
  ThemeData get themeData => _buildThemeData();

  /// Applies color palette and typography to generate a complete theme
  ///
  /// [palette] - The color palette for theme generation
  /// [typography] - Optional typography configuration
  /// Returns a complete ThemeData instance
  static ThemeData build(Palette palette, {BrandTypo? typography}) {
    return _makeTheme(palette, typography: typography);
  }

  /// Generates a ThemeData instance from provided color and typography parameters
  ///
  /// [colors] - The color palette for theme generation
  /// [typography] - Optional typography configuration
  /// Returns a cached or newly created ThemeData instance
  static ThemeData _makeTheme(Palette colors, {BrandTypo? typography}) {
    final typo = typography ?? FallBackTypography();
    final cacheKey = _generateCacheKey(colors, typo);

    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!.themeData;
    }

    final theme = ThemeBuilder(colors, typography);
    _cache[cacheKey] = theme;
    return theme.themeData;
  }

  /// Generates a unique cache key based on color scheme and typography properties
  static String _generateCacheKey(Palette colors, BrandTypo typography) {
    return Object.hashAll([
      colors.colorScheme.primary.hashCode,
      colors.colorScheme.surface.hashCode,
      typography.fontFamily,
    ]).toString();
  }

  /// In-memory cache for theme instances to optimize performance
  static final Map<String, ThemeBuilder> _cache = {};

  /// Clears all cached theme instances
  static void clearCache() => _cache.clear();

  /// Constructs the complete ThemeData using configured color scheme and typography
  ThemeData _buildThemeData() {
    return OrkittTheme(
      colorScheme: colorScheme,
      textTheme: textTheme,
      typography: typography,
    ).themeData;
  }
}
