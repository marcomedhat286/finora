import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.dataName,
    required this.errorText,
    required this.onDateSelected,
  });
  final String dataName;
  final String? errorText;
  final void Function(DateTime date) onDateSelected;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.dataName.toUpperCase(),
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final date = await pickDate();
              if (date != null) {
                setState(() {
                  selectedDate = date;
                });
                widget.onDateSelected(date);
              }
            },

            child: InputDecorator(
              decoration: InputDecoration(
                hintMaxLines: 3,
                prefixIcon: const Icon(Icons.date_range_rounded),
                prefixIconColor: kPrimaryColor,
                errorText: widget.errorText,
                errorMaxLines: 3,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    CustomeTextField.circleBorderRadius,
                  ),
                  borderSide: const BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    CustomeTextField.circleBorderRadius,
                  ),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
              child: getInputDecorationChildState,
            ),
          ),
        ],
      ),
    );
  }

  Widget get getInputDecorationChildState {
    if (selectedDate == null) {
      return Text("EG. 28-1-2002", style: CustomeTextField.textStyleDataName);
    } else {
      return Text(
        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
        style: const TextStyle(color: kPrimaryColor),
      );
    }
  }

  Future<DateTime?> pickDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryColor,
              surface: kSecondColor,
              onSurface: kPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
