import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/util/custom_form_field.dart';

class IntPicker extends StatefulWidget {
  const IntPicker({Key? key, required this.plantSizeController, required this.heading, required this.hint}) : super(key: key);

  final TextEditingController plantSizeController;
  final String heading;
  final String hint;

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
        validator: (String? value) { return null; },
    );
  }
}

