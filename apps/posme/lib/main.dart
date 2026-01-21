import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:orkitt/orkitt.dart';
import 'package:posme/core/routes/app_router.dart';
import 'package:posme/core/themes/theme_provider.dart';

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
        width: 375,
        height: 812,
      ), // Base design frame
      scaleMode: ScaleMode.design, // Design-based scaling
      pixelDebug: false, // Turn on for layout visualization
      gridCount: 12, // Default grid layout (for responsive spacing)
      // enableDebugLogging: true, // Logs device metrics & scaling
      errorScreen: ErrorScreen.dessert, 
      appBuilder: (Composer layout) => const PosMeApp(),
    );
  }
}


class PosMeApp extends ConsumerWidget {
  const PosMeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POSMe',
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      onGenerateRoute: AppRouter.router,
      initialRoute: AppRouter.initial,
    );
  }
}
