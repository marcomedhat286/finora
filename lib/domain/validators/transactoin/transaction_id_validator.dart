import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';

abstract final class TransactionIdValidator {
  static final RegExp _transactionIdRegex = RegExp(
    r'^tx_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );

  static String validateOrThrow(String transactionId) {
    final trimmedTransactionId = transactionId.trim();

    if (trimmedTransactionId.isEmpty) {
      throw const EmptyValueException("Transaction ID must not be empty.");
    }

    if (!_transactionIdRegex.hasMatch(trimmedTransactionId)) {
      throw const InvalidFormatException("Invalid transaction ID format");
    }

    return trimmedTransactionId;
  }
}
