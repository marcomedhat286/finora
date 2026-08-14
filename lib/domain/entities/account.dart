import 'dart:convert';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/exception/cannot_update_initial_balance_exception.dart';
import 'package:finora/domain/exception/invalid_make_transaction.dart';
import 'package:finora/domain/validators/account_id_validator.dart';
import 'package:finora/domain/validators/validate_date.dart';
import 'package:finora/domain/value_object/money.dart';

///               15/7
/// Domain entity representing a financial account.
///
/// An [Account] models one of the application's core business concepts.
///
/// Unlike a Value Object, an Account is identified by a unique identifier.
/// Two account instances are considered the same entity when they share
/// the same account ID, regardless of the values of their other properties.
///
/// ## Responsibilities
///
/// - Represent a financial account within the domain.
/// - Preserve the validity of its business data.
/// - Ensure every account has a valid identifier.
/// - Ensure the account balance is represented by a validated [Money]
///   value object.
/// - Support serialization for persistence and data transfer.
///
/// ## Validation
///
/// Before an account can be created:
///
/// - The account identifier is validated using [AccountIdValidator].
/// - The initial balance is validated by constructing a [Money]
///   value object.
/// - The created date also has been stored in this entity
///
/// If either validation fails, object creation is aborted and
/// a domain exception is thrown.
///
/// ## Identity
///
/// The account identifier uniquely defines the entity.
///
/// Therefore, two [Account] objects are considered equal when they
/// share the same account ID, regardless of whether they are different
/// instances or contain different balances.
///
/// ## Domain Invariants
///
/// An [Account] always satisfies the following business rules:
///
/// - It always has a valid account identifier.
/// - It always contains a valid monetary balance.
/// - Invalid state cannot exist inside the Domain layer.
///
/// This class represents an **Entity** in Domain-Driven Design (DDD)
/// and belongs to the Domain layer of the application's
/// Clean Architecture.
class Account {
  /// Unique identifier of the account.
  ///
  /// The identifier defines the entity's identity and
  /// is immutable after creation.
  final String id;

  /// Initial account balance.
  ///
  /// The balance is represented as a validated [Money]
  /// value object to guarantee financial correctness.
  final Money _initialBalance;

  final Money _currentBalance;

  final DateTime _createdAt;

  final List<Transaction> transactions = [];

  /// Creates a validated [Account].
  ///
  /// This constructor is intentionally private to guarantee that every
  /// instance is created through the factory constructors,
  /// where validation is enforced.
  Account._({
    required this.id,
    required this._initialBalance,
    required this._currentBalance,
    required this._createdAt,
  });

  /// Creates a new validated [Account].
  ///
  /// Creation workflow:
  ///
  /// 1. Validate and normalize the supplied account identifier.
  /// 2. Validate the supplied balance by creating a [Money] value object.
  /// 3. Construct the entity.
  ///
  /// Throws:
  ///
  /// - Any exception raised by [AccountIdValidator].
  /// - Any exception raised by [Money.create].
  factory Account.create({
    required String id,
    required double initialBalance,
    required DateTime createdAt,
    double? currentBalance,
  }) {
    /// Validate and normalize the account identifier.
    final cleanedID = AccountIdValidator.validateOrThrow(id);

    /// Create a validated monetary value object.
    final initialBalanceMoney = Money.create(
      value: initialBalance,
      exclusiveZero: false,
    );
    final initialcurrentMoney = Money.create(
      value: currentBalance ?? initialBalance,
      exclusiveZero: false,
    );
    CreatedAtValidator.validateOrThrow(createdAt);

    return Account._(
      id: cleanedID,
      initialBalance: initialBalanceMoney,
      currentBalance: initialcurrentMoney,
      createdAt: createdAt,
    );
  }

  /// Creates an [Account] from its JSON representation.
  ///
  /// The extracted values are passed through [Account.create],
  /// ensuring that deserialized objects satisfy the same
  /// validation rules as newly created ones.
  factory Account.fromJson(Map<String, dynamic> json) {
    /// Extract the account identifier.
    final id = json['id'] as String;

    /// Extract the initial account balance.
    final initialBalance = (json['initialBalance'] as num).toDouble();

    final currentBalance = (json['currentBalance'] as num).toDouble();
    final createdAt = DateTime.parse(json['createdAt'] as String);

    return Account.create(
      id: id,
      initialBalance: initialBalance,
      createdAt: createdAt,
      currentBalance: currentBalance,
    );
  }

  Account applyNewTransaction(Transaction tx) {
    final double updatedValue = currentBalance.value + tx.financialEffect;

    if (updatedValue < 0) {
      throw InvalidMakeTransaction(
        "Transaction rejected: Insufficient funds in account $id.",
      );
    }
    return copyWith(newCurrentBalance: updatedValue);
  }

  Account rollbackDeletedTransaction(Transaction tx) {
    final double updatedValue =
        currentBalance.value + tx.reversalFinancialEffect;
    return copyWith(newCurrentBalance: updatedValue);
  }

  Account recalculateFromLedger(List<Transaction> allTransactions) {
    double totalEffect = 0.0;

    for (final tx in allTransactions) {
      totalEffect += tx.financialEffect;
    }

    final double finalValue = initialBalance.value + totalEffect;
    return copyWith(newCurrentBalance: finalValue);
  }

  /// Returns the validated account balance.
  Money get initialBalance => _initialBalance;

  /// Returns the validated account balance.
  Money get currentBalance => _currentBalance;

  /// Compares two account entities by their identity.
  ///
  /// Two accounts are considered equal when they have
  /// the same account identifier.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account &&
            other.id == id &&
            other._currentBalance == _currentBalance &&
            other._initialBalance == _initialBalance);
  }

  bool get canEditInitialBalance => transactions.isEmpty;

  Account updateInitialBalance(double newInitialBalance) {
    if (!canEditInitialBalance) {
      throw CannotUpdateInitialBalanceException(
        message:
            "Can not update the initial balance, your account have transactions.",
      );
    }

    return Account.create(
      id: id,
      initialBalance: newInitialBalance,
      currentBalance: newInitialBalance,
      createdAt: _createdAt,
    );
  }

  Account copyWith({double? newCurrentBalance}) {
    return Account.create(
      id: id,
      initialBalance: _initialBalance.value,
      currentBalance: newCurrentBalance ?? _currentBalance.value,
      createdAt: _createdAt,
    );
  }

  /// Converts this entity into a serializable map.
  ///
  /// Useful when persisting the entity or sending it
  /// through external systems.
  Map<String, dynamic> toMap() => {
    "id": id,
    "initialBalance": _initialBalance.value,
    "currentBalance": _currentBalance.value,
    "createdAt": _createdAt.toIso8601String(),
  };

  /// Converts this entity into its JSON representation.
  String toJson() => jsonEncode(toMap());

  /// Hash code derived from the entity identity.
  ///
  /// This guarantees consistency with the overridden
  /// equality operator.
  @override
  int get hashCode => Object.hash(id, _initialBalance, _currentBalance);

  /// Returns a human-readable representation of the account.
  @override
  String toString() {
    return "Account(id: $id,balance: $_initialBalance,current: $_currentBalance ,created at: $_createdAt)";
  }
}
