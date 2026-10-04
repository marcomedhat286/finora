import 'package:finora/presentation/screens/home/widgets/custome_bottom_app_bar.dart';
import 'package:finora/presentation/screens/home/widgets/custome_f_a_b.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_app_bar.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/search_content_body.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TransactionSearchBody extends StatelessWidget {
  const TransactionSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return Stack(
      children: [
        CustomeAppBar(
          screenName: "Search Transaction",
          needBack: false,
          color: Colors.black87,
          option: FontAwesomeIcons.sliders,
          onPress: () {
            flitterController.resetTransactionSearchCriteria();
          },
        ),
        const SearchContentBody(),

        const CustomeBotttomAppBar(),
        Positioned(
          left: 143,
          bottom: 85,
          child: CustomeFAB(
            onPressed: () async {
              await flitterController.search();
            },
          ),
        ),
      ],
    );
  }
}
