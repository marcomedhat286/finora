import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/services/account_id_generator.dart';
import 'package:finora/domain/value_object/account_name.dart';
import 'package:finora/domain/value_object/money.dart';
import 'package:finora/domain/value_object/user_id.dart';

/// Handles the business workflow for creating a new financial account.
///
/// [CreateAccountUseCase] coordinates the creation of an [Account]
/// by converting raw input values into validated Domain objects.
///
/// The Use Case is responsible for:
///
/// - Creating a validated [UserId].
/// - Generating a unique [AccountId].
/// - Creating a validated [AccountName].
/// - Parsing the initial balance from String to double.
/// - Creating a validated [Money] value.
/// - Converting the account type code into [AccountType].
/// - Creating the [Account] Domain Entity.
/// - Persisting the newly created account through [AccountRepository].
///
/// The Use Case does not directly handle database or storage logic.
/// Instead, persistence is delegated to [AccountRepository], keeping
/// infrastructure concerns outside the Domain business workflow.
///
/// This creates a clear separation between:
///
/// ```text
/// Raw Input
///     ↓
/// Use Case
///     ↓
/// Value Objects / Domain Types
///     ↓
/// Account Entity
///     ↓
/// Repository
/// ```
///
/// All important Domain validations are delegated to the appropriate
/// Value Objects, validators, parsers, and Domain factories.
class CreateAccountUseCase {
  /// Repository responsible for persisting and retrieving accounts.
  ///
  /// The concrete implementation is injected from outside, allowing
  /// the Use Case to remain independent from the database or storage
  /// technology being used.
  final AccountRepository _accountRepository;

  /// Creates a [CreateAccountUseCase] with the required
  /// [AccountRepository].
  ///
  /// Dependency injection keeps the Use Case independent from any
  /// specific repository implementation.
  CreateAccountUseCase({required this._accountRepository});

  /// Creates a new financial [Account].
  ///
  /// The method receives raw values, typically originating from the
  /// Presentation Layer, and progressively converts them into
  /// validated Domain objects.
  ///
  /// The creation process follows these steps:
  ///
  /// 1. Convert the raw user ID into a [UserId].
  /// 2. Generate a unique [AccountId].
  /// 3. Convert the raw account name into an [AccountName].
  /// 4. Parse the initial balance String into a [double].
  /// 5. Convert the parsed value into a [Money] Value Object.
  /// 6. Convert the account type code into an [AccountType].
  /// 7. Create the [Account] Entity.
  /// 8. Persist the account through [AccountRepository].
  /// 9. Return the newly created account.
  ///
  /// Any validation failure thrown during the process is allowed to
  /// propagate to the upper layer so it can decide how the error
  /// should be presented to the user.
  Future<Account> execute({
    required String rawUserId,
    required String rawAccountName,
    required String accountTypeCode,
    required String rawInitialBalance,
  }) async {
    // Convert the raw user ID into a validated Domain Value Object.
    //
    // This prevents an unvalidated String from entering the Account
    // Entity as the owner's identity.
    final userId = UserId.create(rawUserId);

    // Generate a unique identifier for the new account.
    //
    // Account ID generation is delegated to a dedicated Domain Service
    // instead of being handled directly by the Use Case.
    final accountId = AccountIdGenerator.generateAccountId();

    // Validate and convert the raw account name into its Domain
    // Value Object representation.
    final accountName = AccountName.create(rawAccountName);

    // Convert the raw balance received as a String into a numeric value.
    //
    // Parsing is kept separate from Money validation because parsing
    // answers "Can this String be converted to a number?", while
    // Money answers "Is this number a valid monetary value?"
    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawInitialBalance,
      fieldName: 'initialBalance',
    );

    // Create the Money Value Object.
    //
    // inclusiveZero: true allows the account to start with a zero
    // balance, which is valid for accounts such as cash wallets.
    final initialBalance = Money.create(
      value: doubleValue,
      inclusiveZero: true,
    );

    // Convert the external account type code into the strongly typed
    // AccountType enum.
    //
    // Example:
    //
    // "cash" → AccountType.cash
    final accountType = AccountType.fromCode(accountTypeCode);

    // Create the Account Domain Entity using only validated
    // Domain objects and values.
    final account = Account.create(
      id: accountId,
      userId: userId,
      accountName: accountName,
      accountType: accountType,
      initialBalance: initialBalance,
      createdAt: DateTime.now(),
    );

    // Persist the newly created Account through the repository.
    //
    // The Use Case does not know how or where the account is stored.
    await _accountRepository.saveAccount(account);

    // Return the successfully created Domain Entity to the caller.
    return account;
  }

  /// Creates the default cash account for a user.
  ///
  /// This is a specialized shortcut around [execute] that creates
  /// a predefined cash account with:
  ///
  /// - Account name: `cash wallet`
  /// - Account type: [AccountType.cash]
  /// - Initial balance: `0.0`
  ///
  /// The user only needs to provide the [rawUserId].
  ///
  /// This method is useful when a new user should automatically
  /// receive a default cash account without requiring the user
  /// to manually enter its initial configuration.
  Future<Account> createDefaultCashAccount({required String rawUserId}) async {
    // Reuse the main account creation workflow instead of duplicating
    // the validation and persistence logic.
    return execute(
      rawUserId: rawUserId,
      rawAccountName: 'cash wallet',
      accountTypeCode: AccountType.cash.code,
      rawInitialBalance: '0.0',
    );
  }
}
