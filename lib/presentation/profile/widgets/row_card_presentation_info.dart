import 'package:finora/presentation/profile/widgets/one_data_presentation_row_widget.dart';
import 'package:flutter/material.dart';

class RowCardPresentationInfo extends StatelessWidget {
  const RowCardPresentationInfo({
    super.key,

    required this.data,
    required this.dataName,
  });
  final String dataName;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      child: OneDataPresentationRowWidget(dataName: dataName, data: data),
    );
  }
}
