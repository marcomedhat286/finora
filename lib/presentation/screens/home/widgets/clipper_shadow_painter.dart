import 'package:flutter/material.dart';

class ClipperShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final Shadow shadow;

  const ClipperShadowPainter({required this.clipper, required this.shadow});

  @override
  void paint(Canvas canvas, Size size) {
    final path = clipper.getClip(size);

    final paint = shadow.toPaint();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
