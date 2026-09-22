import 'package:isar_community/isar.dart';
part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id isarId = Isar.autoIncrement;
  late String transactionId;
  late String title;
  late String? description;
  late DateTime createdAt;
  late String accountId;
  late double amount;
  late String category;
  late String type;
}
