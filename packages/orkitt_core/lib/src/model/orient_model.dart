

import 'package:flutter/services.dart';
import 'package:orkitt_core/orkitt_core.dart';

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
