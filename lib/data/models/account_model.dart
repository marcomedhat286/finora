import 'package:isar_community/isar.dart';
part 'account_model.g.dart';

@collection
class AccountModel {
  Id isarId = Isar.autoIncrement;
  late String accountId;
  late String userId;
  late double initialBalance;
  late double currentBalance;
  late DateTime createdAt;
  late bool hasTransactions;
  late String accountName;
  late String accountType;
  late bool isDefault;
}
