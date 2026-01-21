import 'package:flutter/material.dart';
import 'package:posme/core/layouts/app_shell.dart';
import 'package:posme/features/home/views/home_page.dart';

// ---------------------
// App Router
// ---------------------
abstract class AppRouter {
  static final router = AppRouterImpl().router;
  static final String initial = '/shell';

  // This can be extended with real routes later
}

class AppRouterImpl {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/shell':
        return MaterialPageRoute(builder: (_) => const PosShell());
      // Example route
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found', style: TextStyle(fontSize: 18)),
            ),
          ),
        );
    }
  }

  Route<dynamic> Function(RouteSettings) get router => onGenerateRoute;
}
