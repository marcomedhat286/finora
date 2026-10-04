import 'package:flutter/material.dart';

const appName = "Fionra";
const kPrimaryColor = Color.fromARGB(255, 77, 126, 122);
const kPrimaryColor3 = Color.fromARGB(255, 225, 205, 160);
const kPrimaryColor2 = Color.fromARGB(255, 44, 97, 92);
const kSecondColor = Colors.white;
final kSecondColorwithAlpha = kSecondColor.withAlpha(alphaValue * 5);
const double veryBigSizeFont = 60;
const double bigSizeFont = 40;
const double middleSizeFont = 25;
const double smallSizeFont = 15;
const kTranstionDuration = 2;
const blurRadius = 50.0;
const horizontalWhiteBorder = Border(
  top: BorderSide(color: kSecondColor, width: 2),
);
final int alphaValue = 40;
const double circleBottonSize = 80;
const double bottomAppBarHeight = 120;
const double circleAvatarRadius = 100;
final double radiusIcon = 48;
const int limitTransactionView = 5;
const defaultColors = [
  Color.fromARGB(255, 44, 97, 92),
  Color.fromARGB(255, 218, 165, 32),
  Color.fromARGB(255, 25, 42, 58),
];
final Map<String, List<Color>> cardPalettesMap = {
  "primaryCardBalance": [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 225, 205, 160),
    Color.fromARGB(255, 30, 65, 58),
  ],
  "addAccountPreviewCard": [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 184, 115, 51),
    Color.fromARGB(255, 38, 42, 43),
  ],
  "viewTransaction": [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 160, 67, 84),
    Color.fromARGB(255, 235, 220, 190),
  ],
};

final List<List<Color>> cardPalettes = [
  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 218, 165, 32),
    Color.fromARGB(255, 25, 42, 58),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 128, 45, 60),
    Color.fromARGB(255, 235, 220, 190),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 91, 63, 120),
    Color.fromARGB(255, 212, 175, 55),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 190, 92, 65),
    Color.fromARGB(255, 222, 204, 170),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 30, 45, 65),
    Color.fromARGB(255, 170, 180, 180),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 175, 90, 105),
    Color.fromARGB(255, 65, 40, 65),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 194, 155, 65),
    Color.fromARGB(255, 70, 52, 40),
  ],

  [
    Color.fromARGB(255, 44, 97, 92),
    Color.fromARGB(255, 210, 100, 85),
    Color.fromARGB(255, 28, 43, 55),
  ],
];
