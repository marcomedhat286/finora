// domain/repositories/transaction_repository.dart
import 'package:finora/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> saveTransaction(Transaction transaction);
}

class FakeTransactionRepository implements TransactionRepository {
  @override
  Future<void> saveTransaction(Transaction transaction) async {
    await Future.delayed(Duration(seconds: 4));
    print("the new transaction has been saved : ${transaction.id}");
  }
}
