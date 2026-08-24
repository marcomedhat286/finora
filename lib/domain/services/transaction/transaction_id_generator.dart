import 'package:uuid/uuid.dart';

abstract final class TransactionIdGenerator {
  static const _uuid = Uuid();
  static String generateTransactionId() {
    return "tx_$_uuid";
  }
}
