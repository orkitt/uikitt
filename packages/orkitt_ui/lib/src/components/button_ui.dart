import 'package:flutter/material.dart';
import 'dart:ui';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final bool expanded;
  final bool useShadow;
  final bool useGradient;
  final TextStyle? labelStyle;

  const AppPrimaryButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = 42,
    this.borderRadius = 8,
    this.backgroundColor = const Color(0xFF593BF2),
    this.expanded = false,
    this.useShadow = true,
    this.useGradient = true,
    this.labelStyle,
  });

  bool get _shouldDisable => isDisabled || isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SizedBox(
      height: height,
      width: expanded ? mq.width : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: useGradient? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _shouldDisable
                ? [
                    const Color.fromARGB(255, 173, 160, 239),
                    const Color.fromARGB(255, 165, 150, 241),
                  ]
                : [
                    //Color(0xFF7E68ED), Color(0xFF593BF2)
                    backgroundColor.lighten(.19),
                    backgroundColor,
                  ],
          ):null,
          boxShadow:  _shouldDisable || !useShadow
              ? []
              : [
                  BoxShadow(
                    color: backgroundColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
          border: Border.all(
            color: Colors.white.withOpacity(_shouldDisable ? 0.05 : 0.12),
            width: 2,
          ),
        ),
        child: ElevatedButton(
          onPressed: _shouldDisable ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          ),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      );
    }

    final content = Text(
      label,
      style: labelStyle?? TextStyle(
        color: _shouldDisable ? Colors.white70 : Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    );

    if (icon == null) return content;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 20,
          color: _shouldDisable ? Colors.white70 : Colors.white,
        ),
        const SizedBox(width: 8),
        content,
      ],
    );
  }
}

// Great Button Implementation
// class AppPrimaryButton extends StatelessWidget {
//   final String label;
//   final VoidCallback? onPressed;
//   final double height;
//   final double borderRadius;
//   final EdgeInsets padding;
//   final bool isLoading;

//   const AppPrimaryButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.height = 38,
//     this.borderRadius = 8,
//     this.padding = const EdgeInsets.symmetric(horizontal: 20),
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius),
//           color: const Color(0xFF593BF2),
//           gradient: const LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF7E68ED), Color(0xFF593BF2)],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF593BF2).withValues(alpha: 0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.08),
//               blurRadius: 4,
//               offset: const Offset(0, 1),
//             ),
//           ],
//           border: Border.all(
//             color: Colors.white.withValues(alpha: 0.12),
//             width: 2,
//           ),
//         ),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(borderRadius),
//             ),
//             padding: padding,
//           ),
//           onPressed: isLoading ? null : onPressed,
//           child: isLoading
//               ? const SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.white,
//                   ),
//                 )
//               : Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

extension _ColorExtensions on Color {
  /// Get HSL components of the color
  HSLColor get hsl => HSLColor.fromColor(this);

  /// Get HSV components of the color
  HSVColor get hsv => HSVColor.fromColor(this);

  /// Lighten the color by a factor (0.0 to 1.0)
  Color lighten([double factor = 0.15]) {
    return hsl
        .withLightness((hsl.lightness + factor).clamp(0.0, 1.0))
        .toColor();
  }

  /// Darken the color by a factor (0.0 to 1.0)
  Color darken([double factor = 0.15]) {
    return hsl
        .withLightness((hsl.lightness - factor).clamp(0.0, 1.0))
        .toColor();
  }

  /// Saturate the color by a factor (0.0 to 1.0)
  Color saturate([double factor = 0.1]) {
    return hsl
        .withSaturation((hsl.saturation + factor).clamp(0.0, 1.0))
        .toColor();
  }

  /// Desaturate the color by a factor (0.0 to 1.0)
  Color desaturate([double factor = 0.1]) {
    return hsl
        .withSaturation((hsl.saturation - factor).clamp(0.0, 1.0))
        .toColor();
  }

  /// Mix with white by a ratio (0.0 to 1.0)
  Color tint([double ratio = 0.4]) {
    return Color.lerp(this, const Color(0xFFFFFFFF), ratio)!;
  }

  /// Mix with black by a ratio (0.0 to 1.0)
  Color shade([double ratio = 0.4]) {
    return Color.lerp(this, const Color(0xFF000000), ratio)!;
  }

  /// Adjust alpha/opacity
  Color withOpacity(double opacity) {
    return withAlpha((opacity.clamp(0.0, 1.0) * 255).round());
  }

  /// Get a color variant like the example (0xFF593BF2 → 0xFF8773EB)
  Color get lighterVariant {
    return Color.fromARGB(
      alpha,
      (red + 46).clamp(0, 255),
      (green + 56).clamp(0, 255),
      (blue - 7).clamp(0, 255),
    );
  }

  /// Get complementary/opposite color
  Color get complementary {
    return hsl.withHue((hsl.hue + 180) % 360).toColor();
  }

  /// Get analogous colors (adjacent on color wheel)
  List<Color> analogous({int count = 2, double step = 30.0}) {
    final colors = <Color>[];
    for (int i = 1; i <= count; i++) {
      colors.add(hsl.withHue((hsl.hue + step * i) % 360).toColor());
      colors.add(hsl.withHue((hsl.hue - step * i) % 360).toColor());
    }
    return colors;
  }

  /// Check if color is light (useful for text color decisions)
  bool get isLight {
    // Using relative luminance formula
    final luminance = (0.299 * red + 0.587 * green + 0.114 * blue) / 255;
    return luminance > 0.5;
  }

  /// Get contrasting text color (black or white)
  Color get contrastingText {
    return isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }
}
