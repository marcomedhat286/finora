import 'package:get/get.dart';

class BottomAppBarController extends GetxController {
  final currentIndexOptions = 0.obs;
  void changePage(int index) {
    currentIndexOptions.value = index;
  }
}
