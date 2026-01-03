import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';
import 'package:orkitt_core/src/model/design_frame.dart';
import 'package:orkitt_core/src/helpers/screen_utils.dart';

import '../../helpers/design_utils.dart';

/// Singleton class that initializes and coordinates all scaling modes.
///
/// Use [ComposerScale.instance.init] once on startup.
class ComposerScale {
  static final ComposerScale _instance = ComposerScale._internal();

  factory ComposerScale() => _instance;

  static ComposerScale get instance => _instance;

  ComposerScale._internal();

  late ScaleMode _mode;
  bool _initialized = false;
  bool _debugLog = false;
  late MediaQueryData _mediaQuery;

  DesignFrame? _designFrame;

  /// Initializes Composer once at app startup.
  /// Sets mode, design frame, and enables logging if needed.
  void init({
    required BuildContext rootContext,
    required ScaleMode mode,
    DesignFrame? designFrame,
    bool debugLog = false,
  }) {
    if (_initialized) {
      if (debugLog) _log('[Composer] Already initialized, skipping init.');
      return;
    }

    _mode = mode;
    _debugLog = debugLog;
    _designFrame = designFrame;

    _mediaQuery = MediaQuery.of(rootContext);
    _log('[Composer] Initializing with mode: $_mode');
    //ThemeHelper.init(rootContext);
    // Initialize percent-based scaling
    OrkittScreenUtils.initialize(mediaQuery: _mediaQuery);

    // Initialize or update design-based scaling only if designFrame is valid
    // and the current mode is ScaleMode.design
    if (_mode == ScaleMode.design &&
        _designFrame != null &&
        _designFrame!.width > 0 &&
        _designFrame!.height > 0) {
      DesignScaleUtils.instance.init(
        designWidth: _designFrame!.width,
        designHeight: _designFrame!.height,
        mediaQuery: _mediaQuery,
        isLoggingEnabled: _debugLog,
      );
      _log('[Composer] Design-based scaling initialized or updated.');
    } else {
      _log(
        '[Composer] Design frame invalid or not provided — skipping design scaling.',
      );
    }

    _initialized = true;
    _log(
      '[Composer] Initialization complete: '
      'Screen: ${_mediaQuery.size.width} x ${_mediaQuery.size.height}',
    );
  }

  /// Updates Composer on screen size/orientation changes.
  /// Should be called every time MediaQuery changes (e.g., on resize).
  /// Does NOT reset mode or designFrame.
  void update({required BuildContext context}) {
    if (!_initialized) {
      throw FlutterError(
        '[Composer] update() called before init(). Please call init() first.',
      );
    }

    _mediaQuery = MediaQuery.of(context);
    _log('[Composer] Updating MediaQuery info.');

    // Update ScreenUtils with new media query info
    OrkittScreenUtils.initialize(mediaQuery: _mediaQuery);

    // Update DesignUtils scaling if design frame exists
    if (_designFrame != null &&
        _designFrame!.width > 0 &&
        _designFrame!.height > 0) {
      DesignScaleUtils.instance.init(
        designWidth: _designFrame!.width,
        designHeight: _designFrame!.height,
        mediaQuery: _mediaQuery,
        isLoggingEnabled: _debugLog,
      );
      _log('[Composer] Design-based scaling updated.');
    }

    _log(
      '[Composer] Update complete: Screen: ${_mediaQuery.size.width} x ${_mediaQuery.size.height}',
    );
  }

  ScaleMode get mode {
    _assertInitialized();
    return _mode;
  }

  void setMode(ScaleMode mode) {
    _assertInitialized();
    _mode = mode;
    _log('[Composer] Mode changed to: $_mode');
  }

  void enableLog(bool enable) {
    _debugLog = enable;
    _log('[Composer] Logging ${enable ? "enabled" : "disabled"}');
  }

  void _assertInitialized() {
    assert(_initialized, '[Composer] is not initialized. Call init() first.');
  }

  void _log(String message) {
    if (_debugLog) debugPrint(message);
  }
}
