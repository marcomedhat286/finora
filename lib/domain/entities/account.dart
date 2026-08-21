import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/domain/exception/cannot_update_initial_balance_exception.dart';
import 'package:finora/domain/exception/invalid_amount_exception.dart';
import 'package:finora/domain/exception/invalid_make_transaction.dart';
import 'package:finora/domain/validators/validate_date.dart';
import 'package:finora/domain/value_object/account_id.dart';
import 'package:finora/domain/value_object/account_name.dart';
import 'package:finora/domain/value_object/money.dart';
import 'package:finora/domain/value_object/user_id.dart';

/// Represents a financial account within the Domain.
///
/// [Account] is a Domain Entity responsible for maintaining the state
/// and enforcing the business rules of a financial account.
///
/// An account contains:
///
/// - A unique [AccountId].
/// - The [UserId] of its owner.
/// - The initial balance of the account.
/// - The current balance after applying transactions.
/// - The account creation date.
/// - The account name.
/// - The account type.
/// - Whether the account has any transactions.
///
/// The Entity is designed to protect its internal state by keeping
/// its fields private and exposing controlled operations for modifying
/// account data.
///
/// Instead of allowing the current balance to be modified directly,
/// balance changes must occur through Domain operations such as:
///
/// - [applyNewTransaction]
/// - [rollbackDeletedTransaction]
/// - [recalculateFromLedger]
/// - [updateInitialBalance]
///
/// This ensures that important financial rules are enforced inside
/// the Domain rather than being duplicated across the application.
///
/// [Account] also follows Entity principles by using its [AccountId]
/// as its primary identity.
class Account {
  /// Unique identifier of this account.
  ///
  /// The ID is represented by the [AccountId] Value Object rather than
  /// a raw String, ensuring that the identifier has already passed
  /// Domain validation.
  final AccountId _id;

  /// Identifier of the user who owns this account.
  ///
  /// [UserId] is used instead of a raw String to keep user identity
  /// strongly typed within the Domain.
  final UserId _userId;

  /// The original balance assigned to the account when it was created.
  ///
  /// This value represents the starting point from which the account's
  /// current balance is calculated.
  final Money _initialBalance;

  /// The current available balance of the account.
  ///
  /// This value changes as transactions are applied or rolled back.
  ///
  /// It is intentionally private so that balance modifications can
  /// only happen through controlled Domain operations.
  final Money _currentBalance;

  /// The date and time when the account was created.
  ///
  /// The value is validated during account creation to ensure that
  /// the account does not contain an invalid creation date.
  final DateTime _createdAt;

  /// Indicates whether the account currently has any transactions.
  ///
  /// This flag is used by Domain rules such as
  /// [canEditInitialBalance] to determine whether certain account
  /// properties are still allowed to be modified.
  final bool hasTransactions;

  /// The human-readable name assigned to the account.
  final AccountName _accountName;

  /// Defines the category/type of the account.
  final AccountType _accountType;

  /// Private constructor used internally to create an [Account].
  ///
  /// The constructor is private to prevent external code from creating
  /// an Account without going through the Domain creation rules.
  Account._({
    required this._id,
    required this._userId,
    required this._initialBalance,
    required this._currentBalance,
    required this._createdAt,
    required this._accountName,
    required this._accountType,
    this.hasTransactions = false,
  });

  /// Creates a new [Account] after validating its required Domain data.
  ///
  /// The [createdAt] value is validated using [CreatedAtValidator].
  ///
  /// If [currentBalance] is not provided, the account starts with the
  /// same value as [initialBalance].
  ///
  /// This guarantees that a newly created account has a consistent
  /// initial state:
  ///
  /// ```text
  /// initialBalance == currentBalance
  /// ```
  ///
  /// Example:
  ///
  /// ```dart
  /// final account = Account.create(
  ///   id: accountId,
  ///   userId: userId,
  ///   initialBalance: Money.create(value: 1000),
  ///   accountName: AccountName.create('Savings'),
  ///   accountType: AccountType.savings,
  ///   createdAt: DateTime.now(),
  /// );
  /// ```
  factory Account.create({
    required AccountId id,
    required UserId userId,
    required Money initialBalance,
    required AccountName accountName,
    required AccountType accountType,
    required DateTime createdAt,
    Money? currentBalance,
  }) {
    // Validate the creation date before allowing the Account
    // to enter the Domain.
    CreatedAtValidator.validateOrThrow(createdAt);

    // Create the Account with the provided current balance,
    // or use the initial balance when no current balance exists.
    return Account._(
      id: id,
      userId: userId,
      initialBalance: initialBalance,
      currentBalance: currentBalance ?? initialBalance,
      accountName: accountName,
      accountType: accountType,
      createdAt: createdAt,
    );
  }

  /// Updates the account's initial balance.
  ///
  /// The initial balance can only be changed when the account has
  /// no transactions.
  ///
  /// This restriction protects the financial history of the account.
  /// Once transactions exist, changing the initial balance could
  /// invalidate previously recorded financial calculations.
  ///
  /// If the account already contains transactions,
  /// [CannotUpdateInitialBalanceException] is thrown.
  ///
  /// When the operation is allowed, a new [Account] instance is
  /// returned with the new initial and current balances.
  Account updateInitialBalance(Money newInitialBalance) {
    // The initial balance cannot be modified after transactions
    // have been recorded because doing so would affect the
    // financial history of the account.
    if (!canEditInitialBalance) {
      throw CannotUpdateInitialBalanceException(
        message:
            'Can not update the initial balance, your account have transactions.',
      );
    }

    // Return a new Account instead of mutating the existing Entity.
    //
    // Since there are no transactions, the current balance is also
    // reset to the new initial balance.
    return Account.create(
      id: _id,
      userId: _userId,
      initialBalance: newInitialBalance,
      currentBalance: newInitialBalance,
      accountName: _accountName,
      accountType: _accountType,
      createdAt: _createdAt,
    );
  }

  /// Applies a new [Transaction] to the account.
  ///
  /// The transaction's [Transaction.financialEffect] is added to the
  /// current balance.
  ///
  /// A successful transaction also marks the account as having
  /// transactions.
  ///
  /// If applying the transaction would result in an invalid monetary
  /// state, [InvalidAmountException] is caught and converted into
  /// the more meaningful Domain exception [InvalidMakeTransaction].
  Account applyNewTransaction(Transaction tx) {
    try {
      // Calculate the new balance by applying the transaction's
      // financial effect to the current balance.
      final updatedValue = currentBalance + tx.financialEffect;

      // Return a new Account with the updated balance and mark
      // the account as containing transactions.
      return copyWith(
        newCurrentBalance: updatedValue,
        newHasTransactions: true,
      );
    } on InvalidAmountException {
      // Convert the low-level Money validation failure into a
      // Domain-specific transaction failure.
      throw InvalidMakeTransaction(
        'Transaction rejected: Insufficient funds in account $_id.',
      );
    }
  }

  /// Rolls back the financial effect of a deleted [Transaction].
  ///
  /// When a transaction is removed, its
  /// [Transaction.reversalFinancialEffect] is applied to the current
  /// balance to restore the account to its previous financial state.
  ///
  /// [remainingHasTransactions] determines whether the account still
  /// contains transactions after the deletion.
  ///
  /// If the resulting balance becomes invalid,
  /// [InvalidMakeTransaction] is thrown.
  Account rollbackDeletedTransaction(
    Transaction tx, {
    required bool remainingHasTransactions,
  }) {
    try {
      // Apply the transaction's reversal effect to undo
      // its financial impact on the account.
      final updatedValue = currentBalance + tx.reversalFinancialEffect;

      // Return a new Account with the recalculated balance and
      // updated transaction state.
      return copyWith(
        newCurrentBalance: updatedValue,
        newHasTransactions: remainingHasTransactions,
      );
    } on InvalidAmountException {
      // Convert the Money-level validation failure into a
      // transaction-level Domain exception.
      throw InvalidMakeTransaction(
        'Transaction rejected: Insufficient funds in account $_id.',
      );
    }
  }

  /// Recalculates the current balance from the complete transaction ledger.
  ///
  /// This method rebuilds the account's current balance by summing
  /// the financial effects of all provided [allTransactions] and
  /// adding the result to the initial balance.
  ///
  /// The calculation follows:
  ///
  /// ```text
  /// Current Balance =
  /// Initial Balance + Sum(All Transaction Effects)
  /// ```
  ///
  /// This operation is useful when the current balance needs to be
  /// reconstructed from the source transaction history rather than
  /// relying on the previously stored balance.
  ///
  /// If the calculated result violates the rules of [Money],
  /// [InvalidMakeTransaction] is thrown.
  Account recalculateFromLedger(List<Transaction> allTransactions) {
    // Start the accumulated transaction effect at zero.
    Money totalEffect = Money.create(value: 0.0);

    try {
      // Accumulate the financial effect of every transaction
      // in the ledger.
      for (final tx in allTransactions) {
        totalEffect += tx.financialEffect;
      }

      // Reconstruct the current balance from the original
      // balance and the total effect of all transactions.
      final finalValue = initialBalance + totalEffect;

      // Return a new Account with the recalculated balance.
      return copyWith(
        newCurrentBalance: finalValue,
        newHasTransactions: allTransactions.isNotEmpty,
      );
    } on InvalidAmountException {
      // Convert the Money validation failure into a meaningful
      // transaction-level Domain exception.
      throw InvalidMakeTransaction(
        'Transaction rejected: Insufficient funds in account $_id.',
      );
    }
  }

  /// Determines whether another object represents the same Account Entity.
  ///
  /// Account identity is determined by [AccountId].
  ///
  /// Two Account objects with the same ID represent the same
  /// Domain Entity, regardless of differences in their other properties.
  ///
  /// This method is useful when Entity identity needs to be checked
  /// explicitly without relying on full state equality.
  bool isEqual(Object other) =>
      identical(this, other) || (other is Account && other._id == _id);

  /// Indicates whether the initial balance can still be edited.
  ///
  /// The initial balance can only be changed before the account
  /// receives its first transaction.
  ///
  /// Once [hasTransactions] becomes true, this property returns false.
  bool get canEditInitialBalance => !hasTransactions;

  /// Returns the original balance of the account.
  Money get initialBalance => _initialBalance;

  /// Returns the current balance of the account.
  Money get currentBalance => _currentBalance;

  /// Returns the unique identifier of the account.
  AccountId get id => _id;

  /// Returns the identifier of the account owner.
  UserId get userId => _userId;

  /// Returns the account creation date.
  DateTime get createdAt => _createdAt;

  /// Returns the account's name.
  AccountName get name => _accountName;

  /// Returns the type/category of the account.
  AccountType get type => _accountType;

  /// Creates a new [Account] based on the current state while
  /// optionally replacing selected properties.
  ///
  /// This method provides controlled state transitions without
  /// mutating the existing Account instance.
  ///
  /// Only the following properties can be replaced:
  ///
  /// - [newCurrentBalance]
  /// - [newAccountName]
  /// - [newAccountType]
  /// - [newHasTransactions]
  ///
  /// All other properties remain unchanged.
  ///
  /// This approach keeps Account state transitions predictable
  /// and prevents accidental modification of unrelated properties.
  Account copyWith({
    Money? newCurrentBalance,
    AccountName? newAccountName,
    AccountType? newAccountType,
    bool? newHasTransactions,
  }) {
    // Create a new Account using the existing values unless
    // replacement values were explicitly provided.
    return Account._(
      id: _id,
      userId: _userId,
      initialBalance: initialBalance,
      currentBalance: newCurrentBalance ?? currentBalance,
      accountName: newAccountName ?? _accountName,
      accountType: newAccountType ?? _accountType,
      createdAt: _createdAt,
      hasTransactions: newHasTransactions ?? hasTransactions,
    );
  }

  /// Determines whether two Account objects have the same complete state.
  ///
  /// Unlike [isEqual], which checks only Entity identity, this operator
  /// compares the relevant state of both Account instances.
  ///
  /// Two Accounts are considered equal here only when their IDs,
  /// owner IDs, balances, account name, account type, and transaction
  /// state are all equal.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account &&
            other._id == _id &&
            other._currentBalance == _currentBalance &&
            other._initialBalance == _initialBalance &&
            other._accountName == _accountName &&
            other._accountType == _accountType &&
            other.hasTransactions == hasTransactions &&
            other.userId == _userId);
  }

  /// Generates a hash code based on the Account's relevant state.
  ///
  /// The same properties used by [operator ==] are included here
  /// to maintain Dart's equality/hashCode contract.
  @override
  int get hashCode => Object.hash(
    _id,
    _userId,
    _initialBalance,
    _currentBalance,
    hasTransactions,
    _accountName,
    _accountType,
  );

  /// Returns a readable String representation of the Account.
  ///
  /// Primarily useful for debugging, logging, and inspecting the
  /// Account state during development.
  @override
  String toString() {
    return 'Account('
        'id: $_id, '
        'balance: $_initialBalance, '
        'current: $_currentBalance, '
        'created at: $_createdAt'
        ')';
  }
}
