import 'package:flutter/material.dart';
import '../../../../../../shared/widgets/util/custom_form_field.dart';

class StringPicker extends StatefulWidget {
  const StringPicker(
      {Key? key,
      required this.plantNameController,
      required this.heading,
      required this.hint})
      : super(key: key);

  final TextEditingController plantNameController;
  final String heading;
  final String hint;

  @override
  State<StringPicker> createState() => _StringPickerState();
}

class _StringPickerState extends State<StringPicker> {
  /// Validator for the plant name
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
        headingText: widget.heading,
        hintText: widget.hint,
        obscureText: false,
        suffixIcon: null,
        textInputType: TextInputType.name,
        textInputAction: TextInputAction.done,
        controller: widget.plantNameController,
        maxLines: 1,
        validator: nameValidator);
  }
}
