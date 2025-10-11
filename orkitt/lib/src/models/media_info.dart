part of 'package:orkitt/orkitt.dart';

// Functional widget that provides responsive metadata (device, orientation, screen)
/// and allows building adaptive layouts with a single builder function.

class Composer {
  final BuildContext context;
  final bool isLandscape;
  final bool isPortrait;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const Composer({
    required this.context,
    required this.isLandscape,
    required this.isPortrait,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });
  factory Composer.fromBaseContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final width = mediaQuery.size.width;
    return Composer(
      context: context,
      isLandscape: orientation == Orientation.landscape,
      isPortrait: orientation == Orientation.portrait,
      isMobile: width < 600, // Mobile if width < 600
      isTablet: width >= 600 && width < 1200, // Tablet if 600 <= width < 1200
      isDesktop: width >= 1200, // Desktop if width >= 1200
    );
  }

  factory Composer.fromThis(BuildContext context) {
    return Composer(
      context: context,
      isLandscape: _OrkittScreenUtils.orientation == Orientation.landscape,
      isPortrait: _OrkittScreenUtils.orientation == Orientation.portrait,
      isMobile: _OrkittScreenUtils._screenType == ScreenType.mobile,
      isTablet: _OrkittScreenUtils._screenType == ScreenType.tablet,
      isDesktop: _OrkittScreenUtils._screenType == ScreenType.desktop,
    );
  }
}
