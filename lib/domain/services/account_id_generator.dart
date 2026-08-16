import 'package:finora/domain/value_object/account_id.dart';
import 'package:uuid/uuid.dart';

abstract final class AccountIdGenerator {
  static AccountId generateAccountId() {
    final number = const Uuid().v4();
    return AccountId.fromUniqueString("acc_$number");
  }
}
