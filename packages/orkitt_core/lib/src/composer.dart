import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orkitt_core/src/model/composer.dart';
import 'package:orkitt_core/src/model/design_frame.dart';
import 'package:orkitt_core/src/model/orient_model.dart';
import 'package:orkitt_core/src/helpers/screen_utils.dart';
import 'package:orkitt_foundation/orkitt_foundation.dart';

import 'errors/error_scope.dart';
import 'responsive/wrappers/core_scale.dart';
import 'responsive/wrappers/scope_wrapper.dart';

/// ResponsiveScope widget
class AppComposer extends StatefulWidget {
  const AppComposer({
    super.key,
    required this.appBuilder,
    this.designFrame,
    this.scaleMode = ScaleMode.percent,
    this.onFlutterError,
    this.orientation = AppOrientation.none,
    this.ownErrorScreen,
    this.enableDebugLogging = false,
    this.errorScreen = ErrorScreen.dessert,
    this.pixelDebug = false,
    this.gridCount = 12,
    this.version = '1.0',
  });

  final Widget Function(Composer layout) appBuilder;
  final ScaleMode scaleMode;
  final DesignFrame? designFrame;
  final AppOrientation orientation;
  final bool enableDebugLogging;
  final FlutterExceptionHandler? onFlutterError;
  final Widget Function(FlutterErrorDetails error)? ownErrorScreen;
  final ErrorScreen errorScreen;
  final bool pixelDebug;
  final int gridCount;
  final String version;
  @override
  State<AppComposer> createState() => _AppComposerState();
}

class _AppComposerState extends State<AppComposer> with WidgetsBindingObserver {
  Orientation? _orientation;
  ScreenType? _screenType;
  Size? _screenSize;

  Timer? _resizeDebounce;
  bool _coreScaleInitialized = false;

  @override
  void initState() {
    super.initState();
    _setOrientationLock(widget.orientation);
    WidgetsBinding.instance.addObserver(this);

    ErrorHandlerService.setup(
      onFlutterError: widget.onFlutterError,
      errorScreen: widget.ownErrorScreen,
      errorScreenStyle: widget.errorScreen,
      enableDebugLogging: widget.enableDebugLogging,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateScreenInfo(); // first-time initialization
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // debounce to prevent rapid rebuilds
    _resizeDebounce?.cancel();
    _resizeDebounce = Timer(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      _updateScreenInfo();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resizeDebounce?.cancel();
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  Future<void> _setOrientationLock(AppOrientation lock) async {
    try {
      if (lock != AppOrientation.none) {
        await SystemChrome.setPreferredOrientations(lock.orientations);
      }
    } catch (e, stack) {
      debugPrint('Failed to set orientation: $e');
      debugPrintStack(stackTrace: stack);
    }
  }

  void _updateScreenInfo() {
    final mq = MediaQuery.maybeOf(context);
    if (mq == null || mq.size.isEmpty) {
      // Try again in the next frame
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateScreenInfo());
      return;
    }
    final newOrientation = mq.orientation;
    final newSize = mq.size;

    OrkittScreenUtils.initialize(mediaQuery: mq, context: context);
    final newScreenType = OrkittScreenUtils.screenType;

    final hasChanged =
        _orientation != newOrientation ||
        _screenType != newScreenType ||
        _screenSize != newSize;

    if (hasChanged) {
      setState(() {
        _orientation = newOrientation;
        _screenType = newScreenType;
        _screenSize = newSize;
      });

      if (!_coreScaleInitialized) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            ComposerScale.instance.init(
              rootContext: context,
              mode: widget.designFrame != null
                  ? ScaleMode.design
                  : widget.scaleMode,
              designFrame: _getDesignFrame(_orientation!),
              debugLog: widget.enableDebugLogging,
            );
            _coreScaleInitialized = true;
          } catch (e) {
            debugPrint('CoreScale init error: $e');
          }
        });
      }

      if (widget.enableDebugLogging) {
        debugPrint(
          '📱 Orientation: $_orientation, Screen Type: $_screenType, '
          'Width: ${newSize.width}, Height: ${newSize.height}',
        );
      }
    }
  }

  DesignFrame _getDesignFrame(Orientation orientation) {
    final frame = widget.designFrame;
    if (frame != null && frame.width > 0 && frame.height > 0) {
      return orientation == Orientation.landscape ? frame.reversed : frame;
    }
    return DesignFrame.mobileLarge;
  }

  @override
  Widget build(BuildContext context) {
    if (_screenSize == null || _orientation == null || _screenType == null) {
      // Return placeholder until screen info is ready
      return const SizedBox.shrink();
    }

    final Widget layoutWidget = widget.appBuilder(Composer.fromThis(context));

    final dir = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final wrapped = Directionality(textDirection: dir, child: layoutWidget);

    // Wrap in WidgetsApp + Theme + ScaffoldMessenger + Grid
    /// 🔒 PRODUCTION SAFETY GUARANTEE
    ///
    /// This component is specifically engineered for production reliability:
    ///
    /// •  **Production**: Returns wrapper only - zero localization errors
    /// •  **Debug**: Temporarily disable `enableDebugLog` if alerts shows error
    return widget.enableDebugLogging
        ? ScopeWrapper(
            wrapped: wrapped,
            debugBanner: widget.enableDebugLogging,
            showGrid: widget.pixelDebug,
            columnCount: widget.gridCount,
            version: widget.version,
          )
        : wrapped;
  }
}
