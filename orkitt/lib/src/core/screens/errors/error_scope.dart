part of 'package:orkitt/orkitt.dart';

class _ErrorHandlerService {
  static bool _initialized = false;

  static void setup({
    FlutterExceptionHandler? onFlutterError,
    Widget Function(FlutterErrorDetails error)? errorScreen,
    required ErrorScreen errorScreenStyle,
    required bool enableDebugLogging,
  }) {
    if (_initialized) return;
    _initialized = true;

    FlutterError.onError =
        onFlutterError ?? _defaultErrorHandler(enableDebugLogging);
    ErrorWidget.builder = _buildErrorWidget(errorScreen, errorScreenStyle);

    ConsoleLogger.debug(
      'ErrorHandlerService initialized',
      tag: 'ERROR_HANDLER',
    );
  }

  static FlutterExceptionHandler _defaultErrorHandler(bool enableDebugLogging) {
    return (FlutterErrorDetails details) {
      if (enableDebugLogging) {
        _showDebugInfo(details);
      }
      FlutterError.presentError(details);
    };
  }

  static ErrorWidgetBuilder _buildErrorWidget(
    Widget Function(FlutterErrorDetails error)? customErrorScreen,
    ErrorScreen errorScreenStyle,
  ) {
    return (FlutterErrorDetails details) {
      final screen = customErrorScreen != null
          ? customErrorScreen(details)
          : _buildThemedErrorScreen(details, errorScreenStyle);

      return Directionality(
        textDirection: TextDirection.ltr,
        child: Material(color: Colors.transparent, child: screen),
      );
    };
  }

  static Widget _buildThemedErrorScreen(
    FlutterErrorDetails details,
    ErrorScreen style,
  ) {
    ConsoleLogger.debug(
      'Building error screen: ${style.name}',
      tag: 'ERROR_UI',
    );

    switch (style) {
      case ErrorScreen.pixelArt:
        return _PixelArtErrorScreen(details);
      case ErrorScreen.catHacker:
        return _CatHackerErrorScreen(details);
      case ErrorScreen.frost:
        return _FrostErrorScreen(details);
      case ErrorScreen.winDeath:
        return _WinDeath(details);
      case ErrorScreen.brokenRobot:
        return _AssistantErrorScreen(details);
      case ErrorScreen.simple:
        return _AppErrorScreen(details);
      case ErrorScreen.sifi:
        return _SciFiErrorScreen(details);
      case ErrorScreen.theater:
        return _TheaterErrorScreen(details);
      case ErrorScreen.dessert:
        return _Desert404ErrorScreen(details);
      case ErrorScreen.book:
        return _ScrollErrorScreen(details);
      case ErrorScreen.codeTerminal:
        return _TerminalErrorScreen(details);
    }
  }

  static void _showDebugInfo(FlutterErrorDetails details) {
    if (!kDebugMode) return;

    final exception = details.exception.toString();
    final stack = details.stack?.toString() ?? 'No stack trace available';
    final motivation = _getContextualMotivation(details);

    _printDebugReport(exception, stack, motivation);
  }

  static String _getContextualMotivation(FlutterErrorDetails details) {
    // Determine error context for relevant motivation
    final exception = details.exception.toString().toLowerCase();
    final stack = details.stack?.toString().toLowerCase() ?? '';

    DevelopmentPhase phase;
    bool isChallenging = false;

    // Analyze error context to provide relevant motivation
    if (exception.contains('null') || exception.contains('no such method')) {
      phase = DevelopmentPhase.debugging;
      isChallenging = true;
    } else if (stack.contains('widget') || stack.contains('build')) {
      phase = DevelopmentPhase.coding;
    } else if (exception.contains('network') || exception.contains('http')) {
      phase = DevelopmentPhase.deployment;
      isChallenging = true;
    } else if (exception.contains('render') || exception.contains('layout')) {
      phase = DevelopmentPhase.refactoring;
    } else {
      phase = DevelopmentPhase.debugging;
    }

    return DeveloperMotivation.getContextualMessage(
      phase: phase,
      isChallenging: isChallenging,
    );
  }

  static void _printDebugReport(String exception, String stack, String motivation) {
    ConsoleLogger.section('🚨 FLUTTER ERROR DETECTED', color: 'red');

    // Professional motivation header
    ConsoleLogger.keyValue(
      '💡 Developer Insight',
      motivation,
      keyColor: 'cyan',
      valueColor: 'white',
    );
    ConsoleLogger.separator(color: 'blue', length: 60);

    // Exception details
    ConsoleLogger.section('EXCEPTION ANALYSIS', color: 'yellow');
    ConsoleLogger.error(exception, tag: 'EXCEPTION');
    ConsoleLogger.separator(color: 'blue', length: 60);

    // Stack trace preview
    ConsoleLogger.section('STACK TRACE PREVIEW', color: 'magenta');
    ConsoleLogger.warning(_previewStack(stack), tag: 'STACK');
    ConsoleLogger.separator(color: 'blue', length: 60);

    // Professional debugging guidance
    ConsoleLogger.section('DEBUGGING STRATEGY', color: 'green');
    _printDebuggingGuidance(exception, stack);
    ConsoleLogger.separator(color: 'blue', length: 60);

    // Search optimization
    ConsoleLogger.section('RESEARCH ASSISTANCE', color: 'cyan');
    final searchUrl = _generateSearchQuery(exception);
    ConsoleLogger.info(searchUrl, tag: 'SEARCH_URL');
    ConsoleLogger.keyValue(
      'Research Tip',
      'Focus search on the specific exception type and framework context',
      keyColor: 'yellow',
      valueColor: 'white',
    );
    ConsoleLogger.separator(color: 'blue', length: 60);

    // Professional development practices
    ConsoleLogger.section('PROFESSIONAL PRACTICES', color: 'green');
    _printBestPractices();
    
    // System context
    ConsoleLogger.debug(
      'Error timestamp: ${DateTime.now().toIso8601String()}',
      tag: 'TIMESTAMP',
    );
    ConsoleLogger.debug(
      'Execution environment: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      tag: 'ENVIRONMENT',
    );

    // Professional closure
    ConsoleLogger.section('ERROR ANALYSIS COMPLETE 🏁', color: 'red');
  }

  static void _printDebuggingGuidance(String exception, String stack) {
    if (exception.toLowerCase().contains('null')) {
      ConsoleLogger.info(
        'Consider implementing null safety checks and defensive programming patterns',
        tag: 'GUIDANCE',
      );
    } else if (exception.toLowerCase().contains('widget')) {
      ConsoleLogger.info(
        'Review widget lifecycle and state management consistency',
        tag: 'GUIDANCE',
      );
    } else if (exception.toLowerCase().contains('network')) {
      ConsoleLogger.info(
        'Implement robust error handling for network connectivity variations',
        tag: 'GUIDANCE',
      );
    } else {
      ConsoleLogger.info(
        'Apply systematic debugging: isolate, reproduce, and analyze the root cause',
        tag: 'GUIDANCE',
      );
    }

    ConsoleLogger.keyValue(
      'Debug Approach',
      'Use breakpoints to trace execution flow and variable states',
      keyColor: 'yellow',
      valueColor: 'white',
    );
  }

  static void _printBestPractices() {
    final practices = [
      'Implement comprehensive error boundaries in production applications',
      'Use structured logging for better error tracking and analysis',
      'Consider implementing custom exception types for domain-specific errors',
      'Establish monitoring and alerting for critical application errors',
      'Document common error scenarios and their resolution procedures',
    ];

    for (final practice in practices.take(2)) { // Show top 2 most relevant
      ConsoleLogger.info(practice, tag: 'BEST_PRACTICE');
    }
  }

  static String _previewStack(String stack, [int lines = 8]) {
    final linesList = stack.split('\n');
    final preview = linesList.take(lines).join('\n');
    final hasMore = linesList.length > lines
        ? '\n... (${linesList.length - lines} more lines)'
        : '';

    return '$preview$hasMore';
  }

  static String _generateSearchQuery(String exception) {
    // Clean and focus the search query for better results
    final cleaned = exception
        .replaceAll(RegExp(r'[\n\r\t]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    // Extract the most relevant part (first 60 chars or to first colon)
    final queryBase = cleaned.length > 60 
        ? cleaned.substring(0, 60) 
        : cleaned;
    
    final focusedQuery = queryBase.split(':').first.trim();

    final encodedQuery = Uri.encodeComponent('$focusedQuery Flutter Dart');
    return 'https://stackoverflow.com/search?q=$encodedQuery';
  }
}