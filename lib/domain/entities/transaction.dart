import 'package:finora/domain/value_object/money.dart';

abstract class Transaction {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final String accountId;
  final Money amount;

  const Transaction({
    required this.id,
    required this.title,
    required this.accountId,
    required this.amount,
    required this.createdAt,
    this.description,
  });

  double get financialEffect;

  double get reversalFinancialEffect;

  String get displayData;
}
