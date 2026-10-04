import 'package:finora/presentation/screens/transaction_search/widgets/flitter_search_option_list.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/list_of_result_transaction.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/search_text_feild.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/sort_and_transaction_number.dart';
import 'package:flutter/material.dart';

class SearchContentBody extends StatelessWidget {
  const SearchContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.only(top: 90),
      child: Column(
        children: [
          SearchTextFeild(),
          FlitterSearchOptionList(),
          SortAndTransactionNumber(),
          SizedBox(height: 5),
          ListOfResultTransaction(),
        ],
      ),
    );
  }
}
