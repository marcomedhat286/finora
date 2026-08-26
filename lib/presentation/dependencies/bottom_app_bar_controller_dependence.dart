import 'package:finora/presentation/screens/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:get/get.dart';

class BottomAppBarControllerDependence extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomAppBarController>(() => BottomAppBarController());
  }
}
