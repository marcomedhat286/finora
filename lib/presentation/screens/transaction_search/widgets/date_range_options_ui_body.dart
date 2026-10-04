import 'package:finora/presentation/screens/transaction_search/widgets/custom_date_range_feilds.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/date_range_options_view_cards_list.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/head_selected_option.dart';
import 'package:flutter/material.dart';

class DateRangeOptionsUiBody extends StatelessWidget {
  const DateRangeOptionsUiBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const HeadSelectedOption(SelectedOptionName: "Select Date Range"),
          const DateRangeOptionsViewCardsList(),
          const CustomDateRangeFeilds(),
        ],
      ),
    );
  }
}
