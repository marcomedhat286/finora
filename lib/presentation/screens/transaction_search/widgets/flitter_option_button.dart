import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/flitter_search_option_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FlitterOptionButton extends StatelessWidget {
  final FaIconData _icon;
  final String _optionName;
  final GestureTapCallback _onTap;
  final FlitterOptions _flitterOption;

  const FlitterOptionButton({
    super.key,
    required this._icon,
    required this._optionName,
    required this._onTap,
    required this._flitterOption,
  });

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    final textStyle = TextStyle(
      color: Colors.grey.shade500,
      fontSize: smallSizeFont,
      fontWeight: .w500,
    );
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: BoxBorder.all(color: Colors.black12),
              color: kSecondColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                FaIcon(_icon, size: smallSizeFont * 1.7, color: Colors.black54),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  children: [
                    Text(_optionName, style: textStyle),
                    const SizedBox(height: 1),
                    Obx(
                      () => Text(
                        "${flitterController.getAllOptionsState(_flitterOption)}"
                            .toUpperCase(),
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
