import 'package:flutter/material.dart';

import '../util/custom_form_field.dart';

class IntPicker extends StatefulWidget {
  const IntPicker({
    Key? key,
    required this.plantSizeController,
    required this.heading,
    required this.hint,
    this.validator,
    this.onChange,
  }) : super(key: key);

  final TextEditingController plantSizeController;
  final String heading;
  final String hint;
  final String? Function(String? newValue)? validator;
  final Function(String? value)? onChange;

  @override
  State<IntPicker> createState() => _IntPickerState();
}

class _IntPickerState extends State<IntPicker> {
  // Form controllers
  TextEditingController plantNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      headingText: widget.heading,
      hintText: widget.hint,
      obscureText: false,
      suffixIcon: null,
      textInputType: const TextInputType.numberWithOptions(
        decimal: false,
      ),
      textInputAction: TextInputAction.done,
      controller: widget.plantSizeController,
      maxLines: 1,
      validator: (String? value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        } else {
          return null;
        }
      },
      onChange: (String? value) {
        if (widget.onChange != null) widget.onChange!(value);
      },
    );
  }
}
