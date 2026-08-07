import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class BottomCustomeAppBarClipper extends CustomClipper<Path> {
  const BottomCustomeAppBarClipper();
  @override
  Path getClip(Size size) {
    const double halfCircleWithSpace = (circleBottonRadius + 20) / 2;

    final controllerLeftPoint = Offset(
      (size.width / 2) - (halfCircleWithSpace) + 3,
      0,
    );
    final endLeftPoint = Offset(
      (size.width / 2) - (halfCircleWithSpace) + 5,
      10,
    );

    /////////////////////////////////////////////////////////////////

    final controllerRightPoint = Offset(
      size.width / 2 + (halfCircleWithSpace) + 3,
      0,
    );
    final endRightPoint = Offset(size.width / 2 + halfCircleWithSpace + 10, 0);

    Path path = Path();
    path.moveTo(0, 0);

    path.lineTo((size.width / 2) - halfCircleWithSpace, 0);
    path.quadraticBezierTo(
      controllerLeftPoint.dx,
      controllerLeftPoint.dy,
      endLeftPoint.dx,
      endLeftPoint.dy,
    );

    path.arcToPoint(
      Offset(size.width / 2 + (halfCircleWithSpace), 10),
      radius: Radius.circular(halfCircleWithSpace),
      clockwise: false,
    );

    path.quadraticBezierTo(
      controllerRightPoint.dx,
      controllerRightPoint.dy,
      endRightPoint.dx,
      endRightPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // canvas.drawShadow(path, Colors.black, 8, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
