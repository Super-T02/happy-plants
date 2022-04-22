import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.text,
    required this.onChange,
    this.groupValue
  }) : super(key: key);

  final T value;
  final String text;
  final Function(T? newValue) onChange;
  final T? groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: Text(text),
      value: value,
      groupValue: groupValue,
      onChanged: onChange
    );
  }
}


