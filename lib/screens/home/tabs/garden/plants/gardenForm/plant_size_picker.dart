import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/util/custom_form_field.dart';

class PlantSizePicker extends StatefulWidget {
  const PlantSizePicker({Key? key, required this.plantSizeController, required this.heading, required this.hint}) : super(key: key);

  final TextEditingController plantSizeController;
  final String heading;
  final String hint;

  @override
  State<PlantSizePicker> createState() => _PlantSizePickerState();
}

class _PlantSizePickerState extends State<PlantSizePicker> {

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

