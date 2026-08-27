import 'package:finora/core/utils/parse/money_input_parser.dart';

import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account/account_type.dart';

import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/account/invalid_account_name_length_exception.dart';
import 'package:finora/domain/exception/account/invalid_account_type_exception.dart';
import 'package:finora/domain/exception/account/invalid_amount_exception.dart';
import 'package:finora/domain/exception/user/invalid_birthdate_exception.dart';
import 'package:finora/domain/exception/user/taken_user_name_exception.dart';

import 'package:finora/domain/usecases/account/create_account_usecase.dart';
import 'package:finora/domain/usecases/user/create_user_usecase.dart';

import 'package:finora/domain/validators/account/account_name_validator.dart';
import 'package:finora/domain/validators/account/account_type_validator.dart';
import 'package:finora/domain/validators/account/money_validator.dart';
import 'package:finora/domain/validators/user/birthdate_validator.dart';
import 'package:finora/domain/validators/user/name_validator.dart';

import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/exception/account/invalid_double_format_exception.dart';

import 'package:finora/presentation/controller/auth_user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controls the state and business flow of the Sign Up screen.
///
/// This ViewModel acts as the bridge between the presentation layer
/// and the Domain layer.
///
/// Its responsibilities include:
/// - Holding form input values through TextEditingControllers.
/// - Holding reactive UI state using GetX observables.
/// - Validating each Sign Up step before allowing the user to continue.
/// - Executing the user and account creation use cases.
/// - Translating domain exceptions into UI-friendly error messages.
/// - Managing the loading state during asynchronous operations.
/// - Updating the authenticated user state after successful registration.
///
/// The ViewModel does NOT contain the actual business rules.
///
/// Validation rules and entity creation remain inside the Domain layer.
/// This class only coordinates those operations and exposes their results
/// to the UI.
class SignUpViewModel extends GetxController {
  /// Creates the ViewModel with the required Domain use cases.
  ///
  /// Dependency Injection is used here so that this class does not create
  /// its own dependencies and remains independent from their implementations.
  final CreateUserUseCase createNewUser;
  final CreateAccountUseCase createAccountUseCase;

  SignUpViewModel({
    required this.createNewUser,
    required this.createAccountUseCase,
  });

  // ---------------------------------------------------------------------------
  // FORM STATE
  // ---------------------------------------------------------------------------

  /// Stores the user's first name entered from the UI.
  final firstNameController = TextEditingController();

  /// Stores the optional middle name entered from the UI.
  final middleNameController = TextEditingController();

  /// Stores the optional last name entered from the UI.
  final lastNameController = TextEditingController();

  /// Stores the user's selected birth date.
  ///
  /// Rxn means the value can be reactive AND nullable.
  /// Before the user selects a date, its value is null.
  final birthDate = Rxn<DateTime>();

  /// Stores the account name entered by the user.
  final accountNameController = TextEditingController();

  /// Stores the initial account balance entered by the user.
  final initialBalanceController = TextEditingController();

  /// Stores the selected account type.
  ///
  /// Cash is used as the initial/default selection.
  final accountType = Rxn<AccountType>(AccountType.cash);

  /// Stores an optional username entered by the user.
  ///
  /// If the user leaves this field empty, the Domain layer will generate
  /// a username automatically.
  final userNameController = TextEditingController();

  // ---------------------------------------------------------------------------
  // VALIDATION ERRORS
  // ---------------------------------------------------------------------------

  /// Error message related to the first name field.
  var firstNameError = RxnString();

  /// Error message related to the middle name field.
  var middleNameError = RxnString();

  /// Error message related to the last name field.
  var lastNameError = RxnString();

  /// Error message related to the birth date field.
  var birthDateError = RxnString();

  /// Error message related to the account name field.
  var accountNameError = RxnString();

  /// Error message related to the account type field.
  var accountTypeError = RxnString();

  /// Error message related to the initial balance field.
  var initialBalanceError = RxnString();

  /// Error message related to the username field.
  var userNameError = RxnString();

  // ---------------------------------------------------------------------------
  // SIGN UP FLOW STATE
  // ---------------------------------------------------------------------------

  /// Represents the current step in the multi-step Sign Up form.
  ///
  /// Example:
  /// 0 -> Personal information
  /// 1 -> Account information
  /// 2 -> Username / final step
  ///
  /// The UI observes this value and displays the corresponding step.
  final currentStep = 0.obs;

  /// Indicates whether an asynchronous Sign Up operation is running.
  ///
  /// The UI can observe this value to:
  /// - Show a loading indicator.
  /// - Disable buttons.
  /// - Prevent duplicate submissions.
  var isLoading = false.obs;

  /// Determines whether the user chose to skip creating a custom account.
  ///
  /// When true, a default Cash account will be created automatically.
  var _setDefaultAccount = false;

  // ---------------------------------------------------------------------------
  // STEP NAVIGATION
  // ---------------------------------------------------------------------------

  /// Moves the user one step backward.
  ///
  /// The step cannot become negative.
  void perviousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  /// Validates the current step before moving to the next step.
  ///
  /// If validation succeeds:
  ///     currentStep is incremented.
  ///
  /// If validation fails:
  ///     The thrown Domain exception is converted into an appropriate
  ///     reactive UI error message.
  void nextStep() {
    _resetErrors();

    try {
      _validateCurrentStep();

      // Validation succeeded, therefore the user is allowed
      // to continue to the next step.
      currentStep.value++;
    } on Exception catch (e) {
      _handleErrors(e);
    }
  }

  /// Skips the custom account creation step.
  ///
  /// Instead of using the account information entered by the user,
  /// the final submission process will create a default Cash account.
  void skipAccountStep() {
    currentStep.value++;

    _setDefaultAccount = true;
  }

  // ---------------------------------------------------------------------------
  // STEP VALIDATION
  // ---------------------------------------------------------------------------

  /// Validates the fields belonging to the currently active step.
  ///
  /// The actual validation rules are NOT implemented here.
  /// This method delegates validation to Domain validators.
  ///
  /// Any validation failure throws a domain exception, which is later
  /// handled by [_handleErrors].
  void _validateCurrentStep() {
    switch (currentStep.value) {
      // -----------------------------------------------------------------------
      // STEP 0: PERSONAL INFORMATION
      // -----------------------------------------------------------------------

      case 0:
        // First name is required.
        NameValidator.validateOrThrow(
          nameType: "first name",
          name: firstNameController.text,
        );

        // Middle name is optional.
        // Validation is performed only if the user entered a value.
        if (middleNameController.text.isNotEmpty) {
          NameValidator.validateOrThrow(
            nameType: "middle name",
            name: middleNameController.text,
          );
        }

        // Last name is optional.
        if (lastNameController.text.isNotEmpty) {
          NameValidator.validateOrThrow(
            nameType: "last name",
            name: lastNameController.text,
          );
        }

        // Birth date is required and must satisfy the Domain's
        // age/date rules.
        BirthdateValidator.validateOrThrow(birthDate.value);

        break;

      // -----------------------------------------------------------------------
      // STEP 1: ACCOUNT INFORMATION
      // -----------------------------------------------------------------------

      case 1:
        // Validate the account name according to Domain rules.
        AccountNameValidator.validateOrThrow(accountNameController.text);

        // Validate that the selected account type is valid.
        AccountTypeValidator.validateAndParse(accountType.value?.code);

        // Convert the raw text entered by the user into a numeric value.
        //
        // Parsing and validation are two different responsibilities:
        // parsing converts String -> double,
        // while MoneyValidator verifies whether the resulting amount
        // is a valid monetary value.
        final doubleValue = MoneyInputParser.parseToDouble(
          fieldName: "initial Balance",
          value: initialBalanceController.text,
        );

        // Initial balance is allowed to be zero,
        // therefore inclusiveZero is true.
        MoneyValidator.validateOrThrow(
          amount: doubleValue,
          inclusiveZero: true,
        );

        break;
    }
  }

  // ---------------------------------------------------------------------------
  // FINAL SIGN UP SUBMISSION
  // ---------------------------------------------------------------------------

  /// Executes the complete Sign Up process.
  ///
  /// The operation consists of several coordinated Domain operations:
  ///
  /// 1. Create the User.
  /// 2. Create either:
  ///    - the custom account entered by the user, or
  ///    - a default Cash account.
  /// 3. Store the authenticated user in AuthUserController.
  /// 4. Store the created account in AuthUserController.
  /// 5. Navigate to the Home screen.
  ///
  /// Any Domain exception is converted into a UI error through
  /// [_handleErrors].
  Future<void> submitSignUp() async {
    _resetErrors();

    // Tell the UI that the Sign Up operation has started.
    isLoading.value = true;

    try {
      // ---------------------------------------------------------------------
      // CREATE USER
      // ---------------------------------------------------------------------

      final newUser = await createNewUser.execute(
        // Empty username means:
        // "I want the Domain layer to generate one for me."
        userName: userNameController.text.isNotEmpty
            ? userNameController.text
            : null,

        firstName: firstNameController.text,

        middleName: middleNameController.text.isNotEmpty
            ? middleNameController.text
            : null,

        lastName: lastNameController.text.isNotEmpty
            ? lastNameController.text
            : null,

        birthDate: birthDate.value,
      );

      // ---------------------------------------------------------------------
      // CREATE ACCOUNT
      // ---------------------------------------------------------------------

      final Account newAccount;

      if (!_setDefaultAccount) {
        // User chose to create a custom account.
        newAccount = await createAccountUseCase.execute(
          rawUserId: newUser.id.value,
          rawAccountName: accountNameController.text,
          accountTypeCode: accountType.value!.code,
          rawInitialBalance: initialBalanceController.text,
        );
      } else {
        // User skipped account configuration.
        // Create a default Cash account instead.
        newAccount = await createAccountUseCase.createDefaultCashAccount(
          rawUserId: newUser.id.value,
        );
      }

      // ---------------------------------------------------------------------
      // UPDATE AUTHENTICATED USER STATE
      // ---------------------------------------------------------------------

      // Store the newly created User in the global authentication state.
      AuthUserController.to.setUser(newUser);

      // Store the newly created Account in the global account state.
      AuthUserController.to.addAccount(newAccount);

      // ---------------------------------------------------------------------
      // NAVIGATION
      // ---------------------------------------------------------------------

      // Registration is complete.
      // Remove the Sign Up flow from the navigation stack so that the user
      // cannot return to the registration process using the Back button.
      Get.offAllNamed('/home');
    } on Exception catch (e) {
      // Convert the Domain exception into a field-specific UI error.
      _handleErrors(e);
    } finally {
      // Always stop the loading state, whether the operation succeeds
      // or fails.
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // INPUT STATE MANAGEMENT
  // ---------------------------------------------------------------------------

  /// Updates the selected birth date.
  ///
  /// The UI calls this method after the user chooses a date from
  /// a DatePicker or another date-selection widget.
  void setBirthDate(DateTime date) {
    birthDate.value = date;
  }

  // ---------------------------------------------------------------------------
  // ERROR HANDLING
  // ---------------------------------------------------------------------------

  /// Converts Domain exceptions into presentation-layer error states.
  ///
  /// Domain validators throw meaningful exceptions.
  /// This method decides WHERE those errors should be displayed in the UI.
  ///
  /// This keeps the Domain layer independent from Flutter widgets
  /// and UI-specific state.
  void _handleErrors(Exception e) {
    switch (e) {
      case EmptyValueException _:
        _setErrors(e);
        break;

      case InvalidFormatException _:
        _setErrors(e);
        break;

      case InvalidBirthdateException _:
        birthDateError.value = e.message;
        break;

      case InvalidAccountNameLengthException _:
        accountNameError.value = e.message;
        break;

      case InvalidAccountTypeException _:
        accountTypeError.value = e.message;
        break;

      case InvalidDoubleFormatException _:
        initialBalanceError.value = e.message;
        break;

      case InvalidAmountException _:
        initialBalanceError.value = e.message;
        break;

      case TakenUserNameException _:
        userNameError.value = e.message;
        break;
    }
  }

  /// Maps generic Domain validation exceptions to the correct UI field.
  ///
  /// Some generic exceptions such as EmptyValueException and
  /// InvalidFormatException contain information about the field inside
  /// their message.
  ///
  /// Example:
  /// "The first name must not be empty."
  ///
  /// The message is inspected to determine which UI error observable
  /// should receive it.
  ///
  /// NOTE:
  /// This approach works, but a more scalable architecture would use
  /// field-specific exceptions instead of depending on message text.
  void _setErrors(Exception e) {
    final message = e.toString();

    if (message.contains("first")) {
      firstNameError.value = message;
    } else if (message.contains("middle")) {
      middleNameError.value = message;
    } else if (message.contains("last")) {
      lastNameError.value = message;
    } else if (message.contains("birthday")) {
      birthDateError.value = message;
    } else if (message.contains("account name")) {
      accountNameError.value = message;
    } else if (message.contains("account type")) {
      accountTypeError.value = message;
    } else if (message.contains("initial Balance")) {
      initialBalanceError.value = message;
    } else if (message.contains("username")) {
      userNameError.value = message;
    }
  }

  // ---------------------------------------------------------------------------
  // ERROR RESET
  // ---------------------------------------------------------------------------

  /// Clears all previous validation errors.
  ///
  /// This is called before starting a new validation attempt so that
  /// an old error does not remain visible after the user fixes the field.
  void _resetErrors() {
    firstNameError.value = null;
    middleNameError.value = null;
    lastNameError.value = null;
    birthDateError.value = null;
    accountNameError.value = null;
    accountTypeError.value = null;
    initialBalanceError.value = null;
    userNameError.value = null;
  }

  // ---------------------------------------------------------------------------
  // LIFECYCLE
  // ---------------------------------------------------------------------------

  /// Releases resources owned by this ViewModel.
  ///
  /// TextEditingController holds resources and listeners internally.
  /// Therefore every controller created by this ViewModel must be disposed
  /// when the ViewModel is removed.
  @override
  void onClose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    accountNameController.dispose();
    initialBalanceController.dispose();
    userNameController.dispose();

    super.onClose();
  }
}
