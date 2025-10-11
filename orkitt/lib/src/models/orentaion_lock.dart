part of 'package:orkitt/orkitt.dart';

/// Enum representing different orientation lock modes
enum AppOrientation {
  portraitUp,
  portraitDown,
  landscapeLeft,
  landscapeRight,
  portraitOnly,
  landscapeOnly,
  none, // Default: allows all orientations
}

extension AppOrientationLockExtension on AppOrientation {
  List<DeviceOrientation> get orientations {
    switch (this) {
      case AppOrientation.portraitUp:
        return [DeviceOrientation.portraitUp];
      case AppOrientation.portraitDown:
        return [DeviceOrientation.portraitDown];
      case AppOrientation.landscapeLeft:
        return [DeviceOrientation.landscapeLeft];
      case AppOrientation.landscapeRight:
        return [DeviceOrientation.landscapeRight];
      case AppOrientation.portraitOnly:
        return [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
      case AppOrientation.landscapeOnly:
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      case AppOrientation.none:
        return [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
    }
  }
}
