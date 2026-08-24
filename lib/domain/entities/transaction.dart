import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

abstract class Transaction<T> {
  final TransactionId id;
  final TransactionTitle title;
  final String? description;
  final DateTime createdAt;
  final AccountId accountId;
  final Money amount;
  final T category;
  const Transaction({
    required this.id,
    required this.title,
    required this.accountId,
    required this.amount,
    required this.createdAt,
    required this.category,
    this.description,
  });

  Money get financialEffect;
  Money get reversalFinancialEffect;
  String get displayData;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.displayData &&
          createdAt == other.createdAt &&
          accountId == other.accountId &&
          amount == other.amount &&
          category == other.category;

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    createdAt,
    accountId,
    amount,
    category,
  );
}
