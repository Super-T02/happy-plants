import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/custom_button.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
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
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Last time watered: ",
          style: textTheme.bodyText1,
        ),
        const SizedBox(
          width: 20.0,
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
