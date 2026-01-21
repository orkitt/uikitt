import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../orkitt_core.dart';

class AppComposer extends StatefulWidget {
  const AppComposer({
    super.key,
    required this.appBuilder,
    this.designFrame,
    this.scaleMode = ScaleMode.percent,
    this.orientation = AppOrientation.none,
    this.enableDebugLogging = false,
    this.onFlutterError,
    this.ownErrorScreen,
    this.errorScreen = ErrorScreen.dessert,
    this.pixelDebug = false,
    this.gridCount = 12,
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

  @override
  State<AppComposer> createState() => _AppComposerState();
}

class _AppComposerState extends State<AppComposer> with WidgetsBindingObserver {
  late MediaQueryData _mediaQuery;
  Orientation? _orientation;
  ScreenType? _screenType;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lockOrientation(widget.orientation);

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
    _syncWithMediaQuery();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _syncWithMediaQuery();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  Future<void> _lockOrientation(AppOrientation lock) async {
    if (lock == AppOrientation.none) return;
    await SystemChrome.setPreferredOrientations(lock.orientations);
  }

  void _syncWithMediaQuery() {
    final mq = MediaQuery.of(context);

    if (mq.size.isEmpty) return;

    final newOrientation = mq.orientation;

    OrkittScreenUtils.initialize(mediaQuery: mq);
    final newScreenType = OrkittScreenUtils.screenType;

    final changed =
        !_initialized ||
        _orientation != newOrientation ||
        _screenType != newScreenType;

    if (!changed) return;

    _mediaQuery = mq;
    _orientation = newOrientation;
    _screenType = newScreenType;

    if (!_initialized) {
      _initCoreScaling();
      _initialized = true;
    } else {
      OrkittCoreScaling.instance.update(mq);
    }

    if (widget.enableDebugLogging) {
      debugPrint(
        '📐 ${mq.size.width}x${mq.size.height} '
        'Orientation: $_orientation '
        'Screen: $_screenType',
      );
    }

    setState(() {});
  }

  void _initCoreScaling() {
    OrkittCoreScaling.instance.init(
      mediaQuery: _mediaQuery,
      mode: widget.designFrame != null ? ScaleMode.design : widget.scaleMode,
      designFrame: _resolvedDesignFrame,
      debugLog: widget.enableDebugLogging,
    );
  }

  DesignFrame get _resolvedDesignFrame {
    final frame = widget.designFrame;
    if (frame == null || !frame.isValid) {
      return DesignFrame.mobileLarge;
    }

    return _orientation == Orientation.landscape ? frame.reversed : frame;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const SizedBox.shrink();
    }

    final content = widget.appBuilder(Composer.fromThis(context));

    return Directionality(
      textDirection: TextDirection.ltr,
      child: widget.enableDebugLogging
          ? ScopeWrapper(
              wrapped: content,
              showGrid: widget.pixelDebug,
              columnCount: widget.gridCount,
              debugBanner: true,
            )
          : content,
    );
  }
}
