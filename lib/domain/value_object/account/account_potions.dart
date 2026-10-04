import 'package:finora/domain/enum/account/account_type.dart';

class AccountOption {
  final String? accountId;
  final String accountName;
  final double? amount;
  final AccountType? accountType;

  const AccountOption({
    required this.accountId,
    required this.accountName,
    required this.amount,
    required this.accountType,
  });

  factory AccountOption.all() {
    return AccountOption(
      accountId: null,
      accountName: "All",
      amount: null,
      accountType: null,
    );
  }
}
