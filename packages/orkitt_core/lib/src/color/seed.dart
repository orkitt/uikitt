import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';

/// [Generate Color Schema Based of Seed Color]
class Seed extends Palette {
  final Color seedColor;
  final Brightness brightness;

  Seed({required this.seedColor, this.brightness = Brightness.light});

  /// Generate a ColorScheme from seed color and brightness
  @override
  ColorScheme get colorScheme =>
      ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness);
}
