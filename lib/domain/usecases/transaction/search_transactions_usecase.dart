import 'package:finora/domain/criteria/transaction_search_criteria.dart';
import 'package:finora/domain/entities/transaction.dart';

import 'package:finora/domain/repositories/transaction_repository.dart';

class SearchTransactionsUsecase {
  final TransactionRepository _transactionRepository;
  const SearchTransactionsUsecase({required this._transactionRepository});
  Future<List<Transaction>> call(TransactionSearchCriteria criteria) async {
    if (criteria.type == "all") {
      criteria.type = null;
    }
    final result = await _transactionRepository.searchTransactions(criteria);
    return result;
  }
}
