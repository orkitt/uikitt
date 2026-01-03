import 'package:flutter/widgets.dart';

/// ---------------------------------------------------------------------------
/// Orkitt Lifecycle Manager
/// ---------------------------------------------------------------------------
/// A reusable singleton to observe app lifecycle changes across your app.
///
/// Example usage:
/// ```dart
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   ComposerCycleManager().startObserving();
///   runApp(const MyApp());
/// }
///
/// class MyHomePage extends StatefulWidget { ... }
///
/// class _MyHomePageState extends State<MyHomePage> {
///   @override
///   void initState() {
///     super.initState();
///
///     context.addLifecycleManager
///       ..onAppResumed = _handleResumed
///       ..onAppPaused = _handlePaused
///       ..onAppInactive = _handleInactive
///       ..onAppDetached = _handleDetached;
///   }
///
///   void _handleResumed() {
///     debugPrint('✅ App resumed: refresh data, check token.');
///   }
/// ```
///
/// ---------------------------------------------------------------------------
///
///  Key features:
/// - Singleton pattern: always the same instance.
/// - Attach callbacks anywhere with `context.addLifecycleManager`.
/// - Works well with Riverpod if you wrap it in a provider.
/// - Ideal for analytics, saving state, or handling background/foreground logic.
class ComposerCycleManager with WidgetsBindingObserver {
  /// Private constructor for singleton.
  ComposerCycleManager._();

  /// Internal instance.
  static final ComposerCycleManager _instance = ComposerCycleManager._();

  /// Factory constructor to get the same singleton every time.
  factory ComposerCycleManager() => _instance;

  /// Callback when the app comes back to foreground.
  void Function()? onAppResumed;

  /// Callback when the app becomes inactive.
  void Function()? onAppInactive;

  /// Callback when the app is paused (backgrounded).
  void Function()? onAppPaused;

  /// Callback when the app is detached (terminated).
  void Function()? onAppDetached;

  /// Callback when the app is hidden.
  void Function()? onAppHidden;

  /// Start observing lifecycle changes.
  ///
  /// Call this once, early — for example, in `main()`:
  /// ```dart
  /// WidgetsFlutterBinding.ensureInitialized();
  /// AppLifecycleManager().startObserving();
  /// ```
  void startObserving() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Stop observing lifecycle changes.
  ///
  /// Rarely needed, but you can stop listening if you no longer need callbacks.
  void stopObserving() {
    WidgetsBinding.instance.removeObserver(this);
  }

  /// Internal Flutter callback when lifecycle state changes.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('[OrkittLifecycleManager] State changed: $state');
    switch (state) {
      case AppLifecycleState.resumed:
        onAppResumed?.call();
        break;
      case AppLifecycleState.inactive:
        onAppInactive?.call();
        break;
      case AppLifecycleState.paused:
        onAppPaused?.call();
        break;
      case AppLifecycleState.detached:
        onAppDetached?.call();
        break;
      case AppLifecycleState.hidden:
        onAppHidden?.call();
    }
  }
}

/// ---------------------------------------------------------------------------
/// Extension for easy access:
///
/// Use anywhere you have a [BuildContext]:
/// ```dart
/// context.addLifecycleManager.onAppPaused = () { ... };
/// ```
/// ---------------------------------------------------------------------------
extension ComposerLifecycle on BuildContext {
  /// Shortcut to access the [ComposerCycleManager] singleton.
  ComposerCycleManager get addLifecycleManager => ComposerCycleManager();
}

/// ---------------------------------------------------------------------------
/// ✅ Riverpod tip:
///
/// If you use Riverpod, you can wrap this singleton in a provider:
/// ```dart
/// final lifecycleProvider = Provider((ref) => ComposerCycleManager());
/// ```
/// ---------------------------------------------------------------------------
