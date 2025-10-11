part of 'package:orkitt/orkitt.dart';


abstract class OrkittProgressIndicatorThemeData<
        T extends OrkittProgressIndicatorThemeData<T>>
    extends theme.ThemeExtension<T> {
  OrkittProgressIndicatorThemeData(
    this.color,
    this.trackColor,
    this.strokeWidth,
    this.trackStrokeWidth,
  );

  final Color? color;

  final Color? trackColor;

  final double? strokeWidth;

  final double? trackStrokeWidth;
}