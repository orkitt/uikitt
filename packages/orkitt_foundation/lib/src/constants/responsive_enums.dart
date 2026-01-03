
import 'package:flutter/material.dart';

/// Enum for supported operating systems.
enum OSType { web, android, ios, windows, mac, linux, fuchsia }

/// Enum for screen classifications.
enum ScreenType { mobile, tablet, laptop, desktop, wide, ultra }
/// Enum for OS type.


enum ScaleMode { design, percent }

/// unified widget function
typedef ResponsiveBuilderType = Widget Function(
  BuildContext context,
  Orientation orientation,
  ScreenType screenType,
);

/// error page design
enum ErrorScreen {
  pixelArt,
  catHacker,
  frost,
  winDeath,
  brokenRobot,
  simple,
  codeTerminal,
  sifi,
  theater,
  dessert,
  book,
}

enum ResponsiveTransition { fade, slide, scale, slideScale, rotation, flip }


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
