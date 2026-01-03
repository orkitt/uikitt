import 'package:flutter/material.dart' show TextStyle, FontWeight, FontStyle;
import 'package:orkitt_core/orkitt_core.dart';

import 'base_styles.dart';

/// DefaultTypography provides a fallback set of typography styles.

/// Default implementation of OrkittTypography
class FallBackTypography extends BrandTypo {
  @override
  String get fontFamily => 'Roboto';

  @override
  TextStyle get bodyLarge =>
      TextStyle(fontSize: 16.fontscale, fontWeight: FontWeight.w500);

  @override
  TextStyle get bodyMedium =>
      TextStyle(fontSize: 14.fontscale, fontWeight: FontWeight.w400);

  @override
  TextStyle get bodySmall =>
      TextStyle(fontSize: 12.fontscale, fontStyle: FontStyle.normal);

  @override
  TextStyle get displayLarge =>
      TextStyle(fontSize: 36.fontscale, fontWeight: FontWeight.bold);

  @override
  TextStyle get displayMedium =>
      TextStyle(fontSize: 28.fontscale, fontWeight: FontWeight.bold);

  @override
  TextStyle get labelLarge =>
      TextStyle(fontSize: 16.fontscale, fontWeight: FontWeight.w700);

  @override
  TextStyle get labelMedium =>
      TextStyle(fontSize: 14.fontscale, fontWeight: FontWeight.w600);

  @override
  TextStyle get labelSmall =>
      TextStyle(fontSize: 12.fontscale, fontWeight: FontWeight.w500);

  @override
  TextStyle get titleLarge =>
      TextStyle(fontSize: 20.fontscale, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleMedium =>
      TextStyle(fontSize: 18.fontscale, fontWeight: FontWeight.w600);

  @override
  TextStyle get titleSmall =>
      TextStyle(fontSize: 16.fontscale, fontWeight: FontWeight.w500);
}
