import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomAppBarController extends GetxController {
  final currentIndexOptions = 0.obs;
  void changePage(int index) {
    currentIndexOptions.value = index;
  }

  FaIconData get fabIcon {
    switch (currentIndexOptions.value) {
      case 0:
        return FontAwesomeIcons.plus;

      case 1:
        return FontAwesomeIcons.wallet;

      case 2:
        return FontAwesomeIcons.magnifyingGlass;

      case 3:
        return FontAwesomeIcons.penToSquare;

      default:
        return FontAwesomeIcons.plus;
    }
  }
}
