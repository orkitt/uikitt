import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';

/// Central scaling coordinator for Orkitt.
///
/// Lifecycle:
/// 1. Call [init] once after MediaQuery exists
/// 2. Call [update] whenever MediaQuery changes (resize/orientation)
/// 3. Use scaling helpers throughout the app
class OrkittCoreScaling {
  OrkittCoreScaling._internal();

  static final OrkittCoreScaling instance = OrkittCoreScaling._internal();

  static const String _tag = '[OrkittScaling]';

  late ScaleMode _mode;
  late MediaQueryData _mediaQuery;

  DesignFrame? _designFrame;
  bool _initialized = false;
  bool _debugLog = false;

  /// Initializes scaling infrastructure.
  ///
  /// If [force] is true, re-initializes even if already initialized.
  void init({
    required MediaQueryData mediaQuery,
    required ScaleMode mode,
    DesignFrame? designFrame,
    bool debugLog = false,
    bool force = false,
  }) {
    if (_initialized && !force) {
      _log('$_tag Already initialized — skipping.');
      return;
    }

    _mediaQuery = mediaQuery;
    _mode = mode;
    _designFrame = designFrame;
    _debugLog = debugLog;

    _log('$_tag Initializing with mode: $_mode');
    _applyScaling();

    _initialized = true;

    _log(
      '$_tag Init complete: '
      '${_mediaQuery.size.width} x ${_mediaQuery.size.height}',
    );
  }

  /// Updates scaling on MediaQuery changes.
  void update(MediaQueryData mediaQuery) {
    if (!_initialized) {
      throw StateError(
        'OrkittCoreScaling.update() called before init().',
      );
    }

    _mediaQuery = mediaQuery;
    _log('$_tag MediaQuery updated.');

    _applyScaling();

    _log(
      '$_tag Update complete: '
      '${_mediaQuery.size.width} x ${_mediaQuery.size.height}',
    );
  }

  /// Current scaling mode.
  ScaleMode get mode {
    _assertInitialized();
    return _mode;
  }

  /// Change scaling mode at runtime.
  void setMode(ScaleMode mode) {
    _assertInitialized();
    if (_mode == mode) return;

    _mode = mode;
    _log('$_tag Mode changed to $_mode');

    _applyScaling();
  }

  /// Enable or disable debug logging.
  void enableLog(bool enable) {
    _debugLog = enable;
    _log('$_tag Logging ${enable ? "enabled" : "disabled"}');
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  void _applyScaling() {
    // Percent / screen-based scaling
    OrkittScreenUtils.initialize(
      mediaQuery: _mediaQuery,
    );

    // Design-based scaling
    if (_mode == ScaleMode.design && _designFrame?.isValid == true) {
      DesignScaleUtils.instance.init(
        designWidth: _designFrame!.width,
        designHeight: _designFrame!.height,
        mediaQuery: _mediaQuery,
        isLoggingEnabled: _debugLog,
      );

      _log('$_tag Design scaling applied.');
    } else {
      _log('$_tag Design scaling skipped.');
    }
  }

  void _assertInitialized() {
    assert(
      _initialized,
      'OrkittCoreScaling is not initialized. Call init() first.',
    );
  }

  void _log(String message) {
    if (_debugLog) debugPrint(message);
  }
}
