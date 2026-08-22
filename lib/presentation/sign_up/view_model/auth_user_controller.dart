import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:get/get.dart';

/// Manages the authenticated user's runtime state.
///
/// [AuthUserController] acts as the central state holder for the
/// currently authenticated [User] and the [Account]s owned by that user.
///
/// The controller is responsible for:
///
/// - Storing the currently authenticated user.
/// - Storing the user's accounts.
/// - Updating the authenticated user.
/// - Replacing the user's account list.
/// - Adding newly created accounts.
/// - Exposing authentication and account state to the UI.
/// - Providing access to the user's default account.
/// - Clearing the authenticated state during logout.
///
/// This controller belongs to the Presentation layer and is responsible
/// only for managing UI/application state.
///
/// It does NOT contain Domain business rules such as:
///
/// - Validating Account IDs.
/// - Validating Account Names.
/// - Calculating account balances.
/// - Creating Accounts.
/// - Applying Transactions.
///
/// Those responsibilities remain inside the Domain layer and Use Cases.
///
/// The general flow is:
///
/// ```text
/// Use Case
///    ↓
/// Domain Entity
///    ↓
/// AuthUserController
///    ↓
/// Reactive State
///    ↓
/// UI
/// ```
class AuthUserController extends GetxController {
  /// Provides a globally accessible instance of [AuthUserController].
  ///
  /// Instead of repeatedly calling:
  ///
  /// ```dart
  /// Get.find<AuthUserController>()
  /// ```
  ///
  /// other presentation components can use:
  ///
  /// ```dart
  /// AuthUserController.to
  /// ```
  static AuthUserController get to => Get.find<AuthUserController>();

  /// Stores the currently authenticated user.
  ///
  /// [Rxn] is used because there may be no authenticated user.
  ///
  /// ```text
  /// Logged out → null
  /// Logged in  → User
  /// ```
  final Rxn<User> _currentUser = Rxn<User>();

  /// Reactive list containing all accounts belonging to the
  /// currently authenticated user.
  ///
  /// The list is observable, so widgets using [Obx] can automatically
  /// rebuild when accounts are added, removed, or replaced.
  final RxList<Account> _userAccounts = <Account>[].obs;

  /// Sets the currently authenticated user.
  ///
  /// Usually called after successful authentication or registration.
  void setUser(User user) {
    _currentUser.value = user;
  }

  /// Replaces the current user's account list with [accounts].
  ///
  /// [assignAll] updates the existing reactive list instead of replacing
  /// the RxList object itself.
  ///
  /// This is useful when accounts are loaded from a repository and need
  /// to become the current user's active account collection.
  void setAccount(List<Account> accounts) {
    _userAccounts.assignAll(accounts);
  }

  /// Adds a newly created [Account] to the current user's account list.
  ///
  /// Because [_userAccounts] is reactive, widgets observing this list
  /// through [Obx] will automatically rebuild after the account is added.
  void addAccount(Account account) {
    _userAccounts.add(account);
  }

  /// Returns the currently authenticated user.
  ///
  /// Returns `null` when no user is authenticated.
  User? get currentUser => _currentUser.value;

  /// Indicates whether a user is currently authenticated.
  ///
  /// ```text
  /// currentUser != null → true
  /// currentUser == null → false
  /// ```
  bool get isAuthenticated => (_currentUser.value != null);

  /// Returns a read-only snapshot of the user's accounts.
  ///
  /// [toList] prevents external code from directly modifying the
  /// internal [_userAccounts] collection.
  List<Account> get userAccounts => _userAccounts.toList();

  /// Returns the user's default account.
  ///
  /// Currently, the first account in the list is considered the
  /// default account.
  ///
  /// Returns `null` when the user does not have any accounts.
  Account? get defaultAccount =>
      _userAccounts.isNotEmpty ? _userAccounts.first : null;

  /// Indicates whether the authenticated user owns at least one account.
  bool get hasAccounts => (_userAccounts.isNotEmpty);

  /// Logs the current user out of the application.
  ///
  /// The logout process:
  ///
  /// 1. Clears the authenticated user.
  /// 2. Removes all loaded accounts.
  /// 3. Removes the previous navigation stack.
  /// 4. Navigates the user to the Welcome screen.
  ///
  /// After logout:
  ///
  /// ```text
  /// currentUser = null
  /// userAccounts = []
  /// ```
  void logout() {
    _currentUser.value = null;
    _userAccounts.clear();

    // Remove all previous routes so the user cannot return to
    // authenticated screens using the Back button.
    Get.offAllNamed('/welcome');
  }
}
