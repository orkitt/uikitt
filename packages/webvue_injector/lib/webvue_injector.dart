// ---------------------------------------------------------------------------
// Orkitt JS Injector Helper for flutter_inappwebview
// ---------------------------------------------------------------------------
// Features:
// • Per-domain and global script registration
// • Named scripts with metadata (description, timeout, retries)
// • Safe injection with timeout and exponential backoff retries
// • Optional result capture from JavaScript
// • Extensible debug logging (plug in your own logger)
// ---------------------------------------------------------------------------

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Metadata describing a registered JavaScript snippet.
class DomainScript {
  /// Unique name of the script within its domain or global scope.
  final String name;

  /// JavaScript source code to be injected.
  final String source;

  /// Optional human-readable description.
  final String? description;

  /// Maximum duration to wait for script evaluation.
  final Duration timeout;

  /// Number of retries allowed after the first failure.
  final int retries;

  const DomainScript({
    required this.name,
    required this.source,
    this.description,
    this.timeout = const Duration(seconds: 3),
    this.retries = 0,
  });
}

/// A robust JavaScript injector for [`flutter_inappwebview`](https://pub.dev/packages/flutter_inappwebview).
///
/// - Register **global** scripts (executed for all URLs) or **domain-specific** scripts.
/// - Safe evaluation with timeout protection and retry logic.
/// - Designed for easy integration into any WebView lifecycle.
///
/// Usage:
/// ```dart
/// final injector = JSInjector(logger: print);
///
/// injector.registerGlobal(DomainScript(
///   name: 'remove_banner',
///   description: 'Remove annoying top banner',
///   source: "(function(){ const el = document.querySelector('.banner'); if(el) el.remove(); return 'done'; })();",
/// ));
///
/// // Inside your WebView lifecycle:
/// onLoadStop: (controller, url) async {
///   await injector.injectForUrl(controller, url);
/// }
/// ```
class JSInjector {
  final Map<String, List<DomainScript>> _domainScripts = {};
  final List<DomainScript> _globalScripts = [];

  /// Optional logger (e.g., Sentry, custom analytics, etc.)
  final void Function(Object message)? _logger;

  JSInjector({void Function(Object message)? logger}) : _logger = logger;

  // ---------------------------------------------------------------------------
  // Registration API
  // ---------------------------------------------------------------------------

  /// Registers a script for a specific domain (e.g. `"example.com"`).
  ///
  /// If a script with the same name already exists, it will be replaced.
  void registerForDomain(String hostname, DomainScript script) {
    final scripts = _domainScripts.putIfAbsent(hostname, () => []);
    final existingIndex = scripts.indexWhere((s) => s.name == script.name);
    if (existingIndex >= 0) {
      scripts[existingIndex] = script;
    } else {
      scripts.add(script);
    }
    _log('Registered domain script "${script.name}" for "$hostname"');
  }

  /// Registers a script to be executed globally (for all URLs).
  void registerGlobal(DomainScript script) {
    final existingIndex = _globalScripts.indexWhere(
      (s) => s.name == script.name,
    );
    if (existingIndex >= 0) {
      _globalScripts[existingIndex] = script;
    } else {
      _globalScripts.add(script);
    }
    _log('Registered global script "${script.name}"');
  }

  /// Removes a script by name from a specific domain.
  void unregisterFromDomain(String hostname, String name) {
    final list = _domainScripts[hostname];
    if (list == null) return;
    list.removeWhere((s) => s.name == name);
    if (list.isEmpty) _domainScripts.remove(hostname);
    _log('Unregistered domain script "$name" from "$hostname"');
  }

  /// Removes a globally registered script by name.
  void unregisterGlobal(String name) {
    _globalScripts.removeWhere((s) => s.name == name);
    _log('Unregistered global script "$name"');
  }

  /// Clears all scripts (domain and global).
  void clearAll() {
    _domainScripts.clear();
    _globalScripts.clear();
    _log('Cleared all registered scripts');
  }

  // ---------------------------------------------------------------------------
  // Injection API
  // ---------------------------------------------------------------------------

  /// Injects all applicable scripts (global + domain) for the given URL.
  ///
  /// Returns a map of `scriptName → result` or `{error: message}` on failure.
  Future<Map<String, dynamic>> injectForUrl(
    InAppWebViewController controller,
    Uri? url, {
    bool includeGlobal = true,
    bool swallowExceptions = true,
  }) async {
    final results = <String, dynamic>{};
    final hostname = url?.host;
    final scripts = <DomainScript>[
      if (includeGlobal) ..._globalScripts,
      if (hostname != null) ...?_domainScripts[hostname],
    ];

    for (final script in scripts) {
      try {
        final result = await _injectWithRetries(controller, script);
        results[script.name] = result;
      } catch (e) {
        _log('Script "${script.name}" failed: $e');
        if (!swallowExceptions) rethrow;
        results[script.name] = {'error': e.toString()};
      }
    }
    return results;
  }

  /// Injects a single named script for a given domain.
  Future<dynamic> injectNamed(
    InAppWebViewController controller,
    String hostname,
    String name, {
    bool swallowExceptions = true,
  }) async {
    final script = _domainScripts[hostname]?.firstWhere(
      (s) => s.name == name,
      orElse: () =>
          throw ArgumentError('Script "$name" not found for "$hostname"'),
    );

    if (script == null) return null;

    try {
      return await _injectWithRetries(controller, script);
    } catch (e) {
      _log('injectNamed("$name") failed: $e');
      if (!swallowExceptions) rethrow;
      return {'error': e.toString()};
    }
  }

  // ---------------------------------------------------------------------------
  // Internal Helpers
  // ---------------------------------------------------------------------------

  Future<dynamic> _injectWithRetries(
    InAppWebViewController controller,
    DomainScript script,
  ) async {
    for (var attempt = 0; attempt <= script.retries; attempt++) {
      try {
        final result = await _evaluateWithTimeout(
          controller,
          script.source,
          script.timeout,
        );
        _log('Executed "${script.name}" (attempt ${attempt + 1})');
        return result;
      } catch (e) {
        _log('Attempt ${attempt + 1} for "${script.name}" failed: $e');
        if (attempt >= script.retries) rethrow;
        final backoff = Duration(milliseconds: 200 * (attempt + 1));
        await Future.delayed(backoff);
      }
    }
  }

  Future<dynamic> _evaluateWithTimeout(
    InAppWebViewController controller,
    String source,
    Duration timeout,
  ) {
    final evaluation = controller.evaluateJavascript(source: source);
    return Future.any([
      evaluation,
      Future.delayed(
        timeout,
        () => throw TimeoutException(
          'Script timed out after ${timeout.inSeconds}s',
        ),
      ),
    ]);
  }

  void _log(Object message) {
    if (_logger != null) {
      try {
        _logger(message);
      } catch (_) {}
    } else if (kDebugMode) {
      debugPrint('[JSInjector] $message');
    }
  }

  // ---------------------------------------------------------------------------
  // Utilities
  // ---------------------------------------------------------------------------

  List<String> listDomains() => List.unmodifiable(_domainScripts.keys);
  List<DomainScript> listScriptsForDomain(String domain) =>
      List.unmodifiable(_domainScripts[domain] ?? const []);
  List<DomainScript> listGlobalScripts() => List.unmodifiable(_globalScripts);
}
