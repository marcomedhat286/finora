import 'package:finora/domain/entities/user.dart';
import 'package:get/get.dart';

class AuthUserController extends GetxController {
  static AuthUserController get to => Get.find<AuthUserController>();
  /////////////////////////// user //////////////////////////////////////
  final Rxn<User> _currentUser = Rxn<User>();

  void setUser(User user) {
    _currentUser.value = user;
  }

  User? get currentUser => _currentUser.value;
  void logout() {
    _currentUser.value = null;
    Get.offAllNamed('/welcome');
  }
}
