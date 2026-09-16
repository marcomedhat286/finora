import 'package:finora/presentation/screens/add_transaction/widgets/add_transaction_bar.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/custome_transaction_data_container.dart';
import 'package:finora/presentation/screens/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';

class AddTransactionBody extends StatelessWidget {
  const AddTransactionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ManyCirclesContainer(body: AddTransactionBar()),
        CustomeTransactionDataContainer(),
      ],
    );
  }
}
