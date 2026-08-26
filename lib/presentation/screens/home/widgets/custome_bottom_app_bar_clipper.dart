import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CustomeBottomAppBarClipper extends CustomClipper<Path> {
  const CustomeBottomAppBarClipper();
  @override
  Path getClip(Size size) {
    const double halfCircleWithSpace = (circleBottonSize + 20) / 2;
    const double smoothSpaceOfLine = 10;
    const double warpLine = 5;
    const double spaceOfController = 3;

    final controllerLeftPoint = Offset(
      (size.width / 2) - (halfCircleWithSpace) + spaceOfController,
      0,
    );
    final endLeftPoint = Offset(
      (size.width / 2) - (halfCircleWithSpace) + warpLine,
      smoothSpaceOfLine,
    );

    /////////////////////////////////////////////////////////////////

    final controllerRightPoint = Offset(
      size.width / 2 + (halfCircleWithSpace) + spaceOfController,
      0,
    );
    final endRightPoint = Offset(
      size.width / 2 + halfCircleWithSpace + smoothSpaceOfLine,
      0,
    );

    Path path = Path();
    path.moveTo(0, 0);

    path.lineTo((size.width / 2) - halfCircleWithSpace - smoothSpaceOfLine, 0);
    path.quadraticBezierTo(
      controllerLeftPoint.dx,
      controllerLeftPoint.dy,
      endLeftPoint.dx,
      endLeftPoint.dy,
    );

    path.arcToPoint(
      Offset(size.width / 2 + (halfCircleWithSpace), smoothSpaceOfLine),
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

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
