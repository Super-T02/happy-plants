import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/custom_button.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key, required this.description, required this.onSubmit}) : super(key: key);

  final String description;
  final Function(DateTime newDate) onSubmit;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.description,
          style: textTheme.bodyText1,
        ),
        ElevatedButton(
          onPressed: () => _selectDate(context), // Refer step 3
          style: CustomButtonStyle.buttonStyle,
          child: Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style:
            textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
