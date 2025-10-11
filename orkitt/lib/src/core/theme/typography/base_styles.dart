part of 'package:orkitt/orkitt.dart';

/// Abstract base class for defining brand-specific typography systems.
/// 
/// Extend this class to create consistent, brand-aligned typography
/// that automatically adapts to your application's color scheme.
/// 
/// Implements the complete Material Design 3 typography scale with
/// semantic naming conventions for maintainable design systems.
abstract class BrandTypo {
  /// Primary font family used throughout the application
  String get fontFamily;

  // Body Text Styles - For primary content
  /// Large body text for main content paragraphs
  TextStyle get bodyLarge;

  /// Medium body text for standard content and descriptions
  TextStyle get bodyMedium;

  /// Small body text for captions, metadata, and secondary information
  TextStyle get bodySmall;

  // Display Text Styles - For prominent headlines
  /// Largest display style for hero sections and major headlines
  TextStyle get displayLarge;

  /// Medium display style for page headers and important titles
  TextStyle get displayMedium;

  // Label Text Styles - For interactive elements and UI labels
  /// Large labels for buttons, navigation items, and prominent CTAs
  TextStyle get labelLarge;

  /// Medium labels for form fields, section headers, and hints
  TextStyle get labelMedium;

  /// Small labels for tags, status indicators, and compact UI elements
  TextStyle get labelSmall;

  // Title Text Styles - For hierarchical content structure
  /// Large titles for card headers, modal titles, and major sections
  TextStyle get titleLarge;

  /// Medium titles for app bars, dialog titles, and content sections
  TextStyle get titleMedium;

  /// Small titles for list items, subtitles, and tab labels
  TextStyle get titleSmall;

  /// Converts the brand typography into a Material Design TextTheme
  /// 
  /// Automatically applies appropriate colors from the provided color scheme
  /// while maintaining the brand's typographic hierarchy and font family.
  /// 
  /// [colorScheme] - The color scheme to apply to the text styles
  /// Returns a complete TextTheme configured with brand typography and colors
  TextTheme toTextTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: bodyLarge.copyWith(
          color: colorScheme.onSurface,
          fontFamily: fontFamily,
        ),
        bodyMedium: bodyMedium.copyWith(
          color: colorScheme.onSurface.withValues(alpha:0.8),
          fontFamily: fontFamily,
        ),
        bodySmall: bodySmall.copyWith(
          color: colorScheme.onSurface.withValues(alpha:0.6),
          fontFamily: fontFamily,
        ),
        displayLarge: displayLarge.copyWith(
          color: colorScheme.onSurface,
          fontFamily: fontFamily,
        ),
        displayMedium: displayMedium.copyWith(
          color: colorScheme.onSurface,
          fontFamily: fontFamily,
        ),
        labelLarge: labelLarge.copyWith(
          color: colorScheme.onPrimary,
          fontFamily: fontFamily,
        ),
        labelMedium: labelMedium.copyWith(
          color: colorScheme.onPrimary.withValues(alpha:0.8),
          fontFamily: fontFamily,
        ),
        labelSmall: labelSmall.copyWith(
          color: colorScheme.onPrimary.withValues(alpha:0.8),
          fontFamily: fontFamily,
        ),
        titleLarge: titleLarge.copyWith(
          color: colorScheme.primary,
          fontFamily: fontFamily,
        ),
        titleMedium: titleMedium.copyWith(
          color: colorScheme.onSurface,
          fontFamily: fontFamily,
        ),
        titleSmall: titleSmall.copyWith(
          color: colorScheme.onSurface.withValues(alpha:0.8),
          fontFamily: fontFamily,
        ),
      );
}