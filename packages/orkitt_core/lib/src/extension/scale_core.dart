// UnifiedScaler: Strict, robust scaling utilities for design and percent modes
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';

/// Extension for scaling numbers according to current scaling mode
extension SmartScalerExtension on num {
  // ------------------------
  // Percent-based extensions
  // ------------------------

  /// Percent of screen height (0.5 ➝ 50% of screen height)
  double get ph => OrkittScreenUtils.percentHeight(toDouble());

  /// Percent of screen width
  double get pw => OrkittScreenUtils.percentWidth(toDouble());

  /// Percent-based radius (based on screen width)
  double get pr => OrkittScreenUtils.percentRadius(toDouble());

  /// Percent-based font size (pixel-ratio aware)
  double get psp => OrkittScreenUtils.percentFontSize(toDouble());

  // ------------------------
  // Design-based extensions
  // ------------------------

  /// Design-mode responsive width
  double get dw => _safe(
        () => DesignScaleUtils.instance.scaleWidth(this),
        fallback: toDouble(),
      );

  /// Design-mode responsive height
  double get dh => _safe(
        () => DesignScaleUtils.instance.scaleHeight(this),
        fallback: toDouble(),
      );

  /// Design-mode responsive font size
  double get dt => _safe(
        () => DesignScaleUtils.instance.scaleFont(this),
        fallback: toDouble(),
      );

  /// Design-mode responsive radius
  double get dr => _safe(
        () => DesignScaleUtils.instance.scaleRadius(this),
        fallback: toDouble(),
      );

  // ------------------------
  // Unified extensions (auto-detect mode)
  // ------------------------

  /// Unified width depending on current ScaleMode
  double get w {
    final mode = OrkittCoreScaling.instance.mode;
    return mode == ScaleMode.design ? dw : pw;
  }

  /// Unified height depending on current ScaleMode
  double get h {
    final mode = OrkittCoreScaling.instance.mode;
    return mode == ScaleMode.design ? dh : ph;
  }

  /// Unified radius depending on current ScaleMode
  double get r {
    final mode = OrkittCoreScaling.instance.mode;
    return mode == ScaleMode.design ? min(dw, dh) : min(pw, ph);
  }

  /// Unified font size depending on current ScaleMode
  double get sp {
    final mode = OrkittCoreScaling.instance.mode;
    return mode == ScaleMode.design ? dt : psp;
  }


  // Usefull upgrades
   double get sq {
    final mode = OrkittCoreScaling.instance.mode;
    final dw = min(this.dw, dh);
    final pw = min(this.pw, ph);
    return mode == ScaleMode.design ? dw : pw;
  }
  // ------------------------
  // Safe executor to prevent crashes if DesignScaleUtils is not initialized
  // ------------------------
  T _safe<T>(T Function() compute, {T? fallback}) {
    try {
      return compute();
    } catch (e, st) {
      debugPrint('ResponsiveScale error: $e');
      if (kDebugMode) debugPrintStack(stackTrace: st);
      if (fallback != null) return fallback;
      return toDouble() as T; // fallback to original number
    }
  }
}

// ------------------------
// UIContext: Quick access to screen info
// ------------------------
class UIContext {
  /// Full screen width
  static double get width => OrkittScreenUtils.width;

  /// Full screen height
  static double get height => OrkittScreenUtils.height;

  /// Safe screen width (excluding system UI)
  static double get safeWidth => OrkittScreenUtils.safeWidth;

  /// Safe screen height (excluding system UI)
  static double get safeHeight => OrkittScreenUtils.safeHeight;

  /// Current device pixel ratio
  static double get pixelRatio => OrkittScreenUtils.pixelRatio;

  /// Screen aspect ratio (width / height)
  static double get aspectRatio => OrkittScreenUtils.aspectRatio;

  /// Current orientation
  static Orientation get orientation => OrkittScreenUtils.orientation;

  /// True if device is landscape
  static bool get isLandscape => orientation == Orientation.landscape;

  /// True if device is portrait
  static bool get isPortrait => orientation == Orientation.portrait;

  /// Device type (mobile, tablet, desktop)
  static ScreenType get deviceType => OrkittScreenUtils.screenType;

  /// Operating system type
  static OSType get osType => OrkittScreenUtils.osType;

  /// True if device is mobile
  static bool get isMobile => deviceType == ScreenType.mobile;

  /// True if device is tablet
  static bool get isTablet => deviceType == ScreenType.tablet;

  /// True if device is desktop
  static bool get isDesktop => deviceType == ScreenType.desktop;
}
