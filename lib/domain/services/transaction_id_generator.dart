import 'package:finora/domain/services/random_digits_generator.dart';

abstract final class TransactionIdGenerator {
  static String generateTransactionId() {
    final number = RandomDigitsGenerator.generate();
    return "tx_$number";
  }
}
