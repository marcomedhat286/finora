import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

abstract final class TransactionIdValidator {
  static final RegExp _transactionIdRegex = RegExp(r'^tx_(\d{1,10})$');

  static String validateOrThrow(String transactionId) {
    final trimmedTransactionId = transactionId.trim();

    if (trimmedTransactionId.isEmpty) {
      throw const EmptyValueException("Transaction ID must not be empty.");
    }

    if (!_transactionIdRegex.hasMatch(trimmedTransactionId)) {
      throw const InvalidFormatException(
        "Invalid transaction ID format. Expected: tx_<1-10 digits>.",
      );
    }

    return trimmedTransactionId;
  }
}
