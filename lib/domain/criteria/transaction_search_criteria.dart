import 'package:finora/domain/enum/transaction/transaction_sort_option.dart';
import 'package:finora/domain/value_object/transaction/amount_range.dart';
import 'package:finora/domain/value_object/transaction/date_range.dart';

final class TransactionSearchCriteria {
  List<String>? accountIds;
  String? type;
  String? name;
  DateRange? dateRange;
  AmountRange? amountRange;
  TransactionSortOption? sortOption;

  TransactionSearchCriteria({
    this.accountIds,
    this.type,
    this.name,
    this.dateRange,
    this.amountRange,
    this.sortOption,
  });
}
