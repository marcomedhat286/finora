import 'dart:convert';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/exception/cannot_update_initial_balance_exception.dart';
import 'package:finora/domain/exception/invalid_make_transaction.dart';

import 'package:finora/domain/validators/validate_date.dart';
import 'package:finora/domain/value_object/account_id.dart';
import 'package:finora/domain/value_object/money.dart';

class Account {
  final AccountId id;

  final Money _initialBalance;

  final Money _currentBalance;

  final DateTime _createdAt;

  final List<Transaction> transactions = [];

  Account._({
    required this.id,
    required this._initialBalance,
    required this._currentBalance,
    required this._createdAt,
  });

  factory Account.create({
    required AccountId id,
    required double initialBalance,
    required DateTime createdAt,
    double? currentBalance,
  }) {
    final initialBalanceMoney = Money.create(
      value: initialBalance,
      inclusiveZero: true,
    );
    final initialcurrentMoney = Money.create(
      value: currentBalance ?? initialBalance,
      inclusiveZero: true,
    );
    CreatedAtValidator.validateOrThrow(createdAt);

    return Account._(
      id: id,
      initialBalance: initialBalanceMoney,
      currentBalance: initialcurrentMoney,
      createdAt: createdAt,
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

  Money get initialBalance => _initialBalance;

  Money get currentBalance => _currentBalance;

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

  Map<String, dynamic> toMap() => {
    "id": id,
    "initialBalance": _initialBalance.value,
    "currentBalance": _currentBalance.value,
    "createdAt": _createdAt.toIso8601String(),
  };

  String toJson() => jsonEncode(toMap());

  @override
  int get hashCode => Object.hash(id, _initialBalance, _currentBalance);

  @override
  String toString() {
    return "Account(id: $id,balance: $_initialBalance,current: $_currentBalance ,created at: $_createdAt)";
  }
}
