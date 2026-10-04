import 'package:finora/domain/enum/transaction/amount_range_option.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/amount_range_card_option.dart';
import 'package:flutter/material.dart';

class AmountRangeOptionsUiList extends StatelessWidget {
  const AmountRangeOptionsUiList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: AmountRangeOptions.values.map((option) {
          return AmountRangeCardOption(option: option);
        }).toList(),
      ),
    );
  }
}
