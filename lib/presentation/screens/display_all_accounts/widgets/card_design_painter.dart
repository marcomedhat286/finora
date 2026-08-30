import 'package:flutter/material.dart';

class CardDesignPainter extends CustomPainter {
  const CardDesignPainter();
  @override
  void paint(Canvas canvas, Size size) {
    // ------------------------------------------------------------
    // First shape
    // ------------------------------------------------------------

    final firstPaint = Paint()
      ..color = Colors.white.withAlpha(20)
      ..style = PaintingStyle.fill;

    final firstPath = Path();

    firstPath.moveTo(size.width * 0.10, 0);

    firstPath.lineTo(size.width * 0.35, 0);

    firstPath.lineTo(size.width * 0.95, size.height);

    firstPath.lineTo(size.width * 0.70, size.height);

    firstPath.close();

    canvas.drawPath(firstPath, firstPaint);

    // ------------------------------------------------------------
    // Second shape
    // ------------------------------------------------------------

    final secondPaint = Paint()
      ..color = Colors.white.withAlpha(15)
      ..style = PaintingStyle.fill;

    final secondPath = Path();

    secondPath.moveTo(size.width * 0.35, 0);

    secondPath.lineTo(size.width * 0.50, 0);

    secondPath.lineTo(size.width, size.height * 0.75);

    secondPath.lineTo(size.width, size.height);

    secondPath.lineTo(size.width * 0.85, size.height);

    secondPath.close();

    canvas.drawPath(secondPath, secondPaint);

    // ------------------------------------------------------------
    // Large curved shape
    // ------------------------------------------------------------

    final curvePaint = Paint()
      ..color = Colors.white.withAlpha(18)
      ..style = PaintingStyle.fill;

    final curvePath = Path();

    curvePath.moveTo(0, 0);

    curvePath.cubicTo(
      size.width * 0.30,
      size.height * 0.9,

      size.width * 0.80,
      size.height * 0.1,

      size.width,
      size.height * 0.70,
    );

    curvePath.lineTo(size.width, size.height);

    curvePath.lineTo(0, size.height);

    curvePath.close();

    canvas.drawPath(curvePath, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
