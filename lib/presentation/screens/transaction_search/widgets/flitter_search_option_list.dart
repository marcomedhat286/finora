import 'package:finora/presentation/extensions/catrgory_option_flitter_search.dart';
import 'package:flutter/material.dart';

enum FlitterOptions { accountType, transactionType, dateRange, amountRange }

class FlitterSearchOptionList extends StatelessWidget {
  const FlitterSearchOptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: FlitterOptions.values.length,
        itemBuilder: (context, index) {
          return FlitterOptions.values[index].uiButton(context);
        },
      ),
    );
  }
}
