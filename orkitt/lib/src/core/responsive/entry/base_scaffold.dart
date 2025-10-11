part of 'package:orkitt/orkitt.dart';


abstract class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  /// ≥576 && <768 → Mobile
  Widget buildMobile(BuildContext context);

  /// ≥768 && <992 → Tablet
  Widget buildTablet(BuildContext context);

  /// ≥992 → Desktop
  Widget buildDesktop(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < Breakpoints.xs) {
      // sm and below
      return buildMobile(context);
    } else if (width < Breakpoints.sm) {
      // md
      return buildTablet(context);
    } else {
      // lg and above
      return buildDesktop(context);
    }
  }
}
