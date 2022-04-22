import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatefulWidget {
  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.onChange,
    this.initialValue
  }) : super(key: key);

  final T value;
  final Function(T? newValue) onChange;
  final T? initialValue;

  @override
  State<CustomRadioButton<T>> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  T? _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: const Text('Lafayette'),
      value: widget.value,
      groupValue: _value,
      onChanged: (T? newValue) {
        setState(() {
          _value = newValue;
        });
        widget.onChange(newValue);
      },
    );
  }
}

