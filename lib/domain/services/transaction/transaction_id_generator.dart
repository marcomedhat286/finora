import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:uuid/uuid.dart';

abstract final class TransactionIdGenerator {
  static final number = const Uuid().v4();
  static TransactionId generateTransactionId() {
    return TransactionId.create("tx_$number");
  }
}
