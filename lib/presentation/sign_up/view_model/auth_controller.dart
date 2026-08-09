import 'package:finora/domain/entities/user.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();

  final Rxn<User> _currentUser = Rxn<User>();
  User? get currentUser => _currentUser.value;
  bool get isAuthenticated => (_currentUser.value != null);
  void setUser(User user) {
    _currentUser.value = user;
  }

  void logout() {
    _currentUser.value = null;
    Get.offAllNamed('/welcome');
  }
}
