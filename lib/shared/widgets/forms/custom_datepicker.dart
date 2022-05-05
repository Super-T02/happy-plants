import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/app_colors.dart';
import 'package:happy_plants/shared/utilities/custom_button.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key, required this.description, required this.onSubmit, this.value}) : super(key: key);

  final String description;
  final Function(DateTime newDate) onSubmit;
  final DateTime? value;

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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.accent1, // header background color
              onPrimary: AppColors.lightWhiteHighlight, // header text color
              onSurface: Theme.of(context).textTheme.bodyText1!.color!, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.accent1, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    //TODO: provide case to select nothing
    else if (picked == null){
      setState(() {
        selectedDate = DateTime.now();
      });
    }
    widget.onSubmit(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    if(widget.value != null){
      selectedDate = widget.value!;
    }

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
            style: textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
