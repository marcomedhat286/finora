import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:get/get.dart';

class AuthUserController extends GetxController {
  static AuthUserController get to => Get.find<AuthUserController>();

  final Rxn<User> _currentUser = Rxn<User>();
  final Rxn<List<Account>> _userAccounts = Rxn<List<Account>>();

  void setUser(User user) {
    _currentUser.value = user;
  }

  void setAccount(Account account) {
    _userAccounts.value = [account];
  }

  void addAccount(Account account) {
    _userAccounts.value!.add(account);
  }

  User? get currentUser => _currentUser.value;
  bool get isAuthenticated => (_currentUser.value != null);

  List<Account>? get userAccounts => _userAccounts.value;
  Account get defaultAccount => _userAccounts.value!.first;
  bool get hasAccounts => (_userAccounts.value != null);

  void logout() {
    _currentUser.value = null;
    _userAccounts.value = null;
    Get.offAllNamed('/welcome');
  }
}
