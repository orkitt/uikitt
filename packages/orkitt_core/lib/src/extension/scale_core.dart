// UnifiedScaler: A utility for strict scaling based on design dimensions, percent, and smart modes.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';

extension SmartScalerExtension on num {
  // ------------------------
  // Percent-based extensions
  // ------------------------

  /// Percent of screen height (0.5 ➝ 50% of height)
  double get ph => OrkittScreenUtils.percentHeight(toDouble());

  /// Percent of screen width
  double get pw => OrkittScreenUtils.percentWidth(toDouble());

  /// Responsive radius from percent width
  double get pr => OrkittScreenUtils.percentRadius(toDouble());

  /// Responsive font size based on pixelRatio and aspectRatio
  double get psp => OrkittScreenUtils.percentFontSize(toDouble());

  // double get prs => min(_ScreenUtils.percentSafeHeight(toDouble())/ _ScreenUtils.percentSafeWidth(toDouble()), 1.0) * toDouble();
  // ------------------------
  // Design-based extensions
  // ------------------------

  /// Design-mode responsive width
  double get dw => _safe(() => DesignScaleUtils.instance.scaleWidth(this));

  /// Design-mode responsive height
  double get dh => _safe(() => DesignScaleUtils.instance.scaleHeight(this));

  /// Design-mode responsive font size
  double get dt => _safe(() => DesignScaleUtils.instance.scaleFont(this));

  /// Design-mode responsive radius
  double get dr => _safe(() => DesignScaleUtils.instance.scaleRadius(this));

  /// Responsive scale (min of width/height)
  // double get rs => min(dw, dh);

  // ------------------------
  // Unified extensions (auto-detect mode)
  // ------------------------

  /// Unified width/radius/text-size depending on current active ScaleMode
  double get w {
    switch (ComposerScale.instance.mode) {
      case ScaleMode.design:
        return dw;
      case ScaleMode.percent:
        return pw;
    }
  }

  // unified height
  double get h {
    switch (ComposerScale.instance.mode) {
      case ScaleMode.design:
        return dh;
      case ScaleMode.percent:
        return ph;
    }
  }

  // ------------------------
  // Unified radius
  // ------------------------
  double get r {
    switch (ComposerScale.instance.mode) {
      case ScaleMode.design:
        return min(dw, dh);
      case ScaleMode.percent:
        return min(pw, ph);
    }
  }

  double get sp {
    final mode = ComposerScale.instance.mode;
    switch (mode) {
      case ScaleMode.design:
        return dt;
      case ScaleMode.percent:
        return psp;
    }
  }

  // ------------------------
  // Safe executor to avoid uninit crashes
  // ------------------------

  T _safe<T>(T Function() compute) {
    try {
      return compute();
    } catch (e) {
      debugPrint('ResponsiveScale error: $e');
      rethrow;
    }
  }
}

class UIContext {
  /// Returns the current screen width.
  static double get width => OrkittScreenUtils.width;

  /// Returns the current screen height.
  static double get height => OrkittScreenUtils.height;

  /// Returns the current safe width (excluding system UI).
  static double get safeWidth => OrkittScreenUtils.safeWidth;

  /// Returns the current safe height (excluding system UI).
  static double get safeHeight => OrkittScreenUtils.safeHeight;

  /// Returns the current pixel ratio.
  static double get pixelRatio => OrkittScreenUtils.pixelRatio;

  /// Returns the current aspect ratio.
  static double get aspectRatio => OrkittScreenUtils.aspectRatio;

  static Orientation get orientation => OrkittScreenUtils.orientation;

  static bool get isLandscape => orientation == Orientation.landscape;
  static bool get isPortrait => orientation == Orientation.portrait;

  /// Returns the current device type.
  /// Returns the current screen type.
  static ScreenType get deviceType => OrkittScreenUtils.screenType;
  static OSType get osType => OrkittScreenUtils.osType;

  /// Returns the current device pixel ratio.
  static bool get isMobile => deviceType == ScreenType.mobile;
  static bool get isTablet => deviceType == ScreenType.tablet;
  static bool get isDesktop => deviceType == ScreenType.desktop;

  /// Returns the current orientation.
}
