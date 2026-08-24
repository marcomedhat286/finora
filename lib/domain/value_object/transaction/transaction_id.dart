import 'package:finora/domain/validators/transactoin/transaction_id_validator.dart';

class TransactionId {
  final String value;

  const TransactionId._(this.value);

  factory TransactionId.create(String rawId) {
    final cleanedId = TransactionIdValidator.validateOrThrow(rawId);
    return TransactionId._(cleanedId);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionId &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
