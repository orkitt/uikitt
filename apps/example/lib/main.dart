import 'package:example/provider/theme_provider.dart';
import 'package:example/view/homepage.dart';
import 'package:example/widgets/global_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orkitt/orkitt.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Orkitt Design System
    return AppComposer(
      orientation: AppOrientation.portraitUp, // Lock or allow orientations
      designFrame: const DesignFrame(
        width: 320,
        height: 812,
      ), // Base design frame
      scaleMode: ScaleMode.design, // Design-based scaling
      pixelDebug: true, // Turn on for layout visualization
      gridCount: 12, // Default grid layout (for responsive spacing)
      enableDebugLogging: true, // Logs device metrics & scaling
      errorScreen: ErrorScreen.dessert, // Custom global error view
      appBuilder: (layout) {
        return  OrkittAppDemo(
        );
      },
    );
  }
}

class OrkittAppDemo extends ConsumerWidget {
  const OrkittAppDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orkitt Example',
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      home: const WalletXHomePage(),
    );
  }
}
