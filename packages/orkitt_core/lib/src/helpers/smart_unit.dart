import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';

/// SmartUnit extension: Unified scaling for responsive apps
extension SmartUnit on num {
  /// Smart scaling for width/height/radius/container
  ///
  /// Options:
  /// - [minValue] → enforce minimum size
  /// - [maxValue] → enforce maximum size
  /// - [aspectAware] → width/height scaled separately if true
  /// - [ultraLargeCurve] → custom multiplier for ultra-large screens
  double smart({
    double? minValue,
    double? maxValue,
    bool aspectAware = false,
    double Function(double value)? ultraLargeCurve,
  }) {
    final mode = OrkittCoreScaling.instance.mode;

    // 1️⃣ Base scaled value
    double value;

    if (mode == ScaleMode.design) {
      final dw = _safe(() => DesignScaleUtils.instance.scaleWidth(this));
      final dh = _safe(() => DesignScaleUtils.instance.scaleHeight(this));
      value = aspectAware ? (dw + dh) / 2 : min(dw, dh);
    } else {
      final pw = OrkittScreenUtils.percentWidth(toDouble());
      final ph = OrkittScreenUtils.percentHeight(toDouble());
      value = aspectAware ? (pw + ph) / 2 : min(pw, ph);
    }

    // 2️⃣ Apply dynamic design-frame detection
    value *= _designFrameMultiplier();

    // 3️⃣ Apply orientation-aware multiplier
    value *= _orientationMultiplier();

    // 4️⃣ Apply custom ultra-large screen curve if provided
    if (ultraLargeCurve != null) value = ultraLargeCurve(value);

    // 5️⃣ Clamp min/max limits
    if (minValue != null) value = max(value, minValue);
    if (maxValue != null) value = min(value, maxValue);

    return value;
  }

  /// Separate smart scaling for font size
  double smartFont({
    double? minValue,
    double? maxValue,
    double fontMultiplier = 1.0,
    double Function(double value)? ultraLargeCurve,
  }) {
    final base = smart(ultraLargeCurve: ultraLargeCurve);
    final scaled = base * fontMultiplier;

    double result = scaled;

    if (minValue != null) result = max(result, minValue);
    if (maxValue != null) result = min(result, maxValue);

    return result;
  }

  /// Orientation-aware multiplier (slightly reduce in landscape)
  double _orientationMultiplier() {
    final orientation = OrkittScreenUtils.orientation;

    if (orientation == Orientation.landscape) {
      return 0.9;
    }
    return 1.0;
  }

  /// Dynamic design-frame multiplier based on device type
  double _designFrameMultiplier() {
    final deviceType = OrkittScreenUtils.screenType;
    final screenSize = OrkittScreenUtils.width;

    if (deviceType == ScreenType.desktop) {
      // Desktop scaling: larger screens get bigger multiplier
      if (screenSize > 1920) return 1.6; // 4K ultra-large monitor
      if (screenSize > 1440) return 1.4; // Full HD desktop
      return 1.2;
    } else if (deviceType == ScreenType.tablet) {
      return 1.15;
    }
    return 1.0; // Mobile
  }

  /// Safe executor to avoid crashes if scaling utils not initialized
  T _safe<T>(T Function() compute, {T? fallback}) {
    try {
      return compute();
    } catch (e, st) {
      debugPrint('SmartUnit error: $e');
      if (kDebugMode) debugPrintStack(stackTrace: st);
      if (fallback != null) return fallback;
      return toDouble() as T;
    }
  }
}
