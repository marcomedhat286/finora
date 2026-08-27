import 'package:finora/presentation/screens/profile/widgets/one_data_presentation_row_widget.dart';
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
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: OneDataPresentationRowWidget(
        dataName: dataName.toUpperCase(),
        data: data,
      ),
    );
  }
}
