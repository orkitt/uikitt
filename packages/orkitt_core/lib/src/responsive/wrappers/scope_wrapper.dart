import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pixel_wrapper.dart';

class ScopeWrapper extends StatelessWidget {
  const ScopeWrapper({
    super.key,
    required this.wrapped,
    this.showGrid = false,
    this.columnCount = 12,
    this.debugBanner = false,
  });

  final Widget wrapped;
  final bool showGrid;
  final int columnCount;
  final bool debugBanner;

  @override
  Widget build(BuildContext context) {
    Widget child = wrapped;

    if (showGrid) {
      child = Stack(
        fit: StackFit.expand,
        children: [
          child,
          PixelPerfectGridOverlay(
            visible: true,
            columns: columnCount,
            child: const SizedBox.shrink(),
          ),
          //_GridOverlay(columns: columnCount),
        ],
      );
    }

    if (debugBanner && kDebugMode) {
      child = Banner(
        message: 'DEBUG',
        location: BannerLocation.topStart,
        color: Colors.redAccent,
        child: child,
      );
    }

    return child;
  }
}
class _GridOverlay extends StatelessWidget {
  const _GridOverlay({
    required this.columns,
  });

  final int columns;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columnWidth = width / columns;

          return CustomPaint(
            painter: _GridPainter(
              columns: columns,
              columnWidth: columnWidth,
            ),
          );
        },
      ),
    );
  }
}
class _GridPainter extends CustomPainter {
  _GridPainter({
    required this.columns,
    required this.columnWidth,
  });

  final int columns;
  final double columnWidth;

  final Paint _paint = Paint()
    ..color = Colors.red.withOpacity(0.2)
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 1; i < columns; i++) {
      final x = columnWidth * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.columns != columns ||
        oldDelegate.columnWidth != columnWidth;
  }
}

