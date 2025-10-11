part of 'package:orkitt/orkitt.dart';

/// Abstract class for All kolors
abstract class Palette {
  const Palette();
  /// Common getter to get a `ColorScheme` from any state
  ColorScheme get colorScheme;
}
