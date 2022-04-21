import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/util/custom_form_field.dart';

class TypePicker extends StatefulWidget {
  const TypePicker({Key? key, required this.plantTypeController}) : super(key: key);

  final TextEditingController plantTypeController;

  @override
  State<TypePicker> createState() => _TypePickerState();
}

class _TypePickerState extends State<TypePicker> {

  // Form controllers
  TextEditingController plantNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
        headingText: "Plant Type *",
        hintText: "Please enter a plant type",
        obscureText: false,
        suffixIcon: null,
        textInputType: TextInputType.name,
        textInputAction: TextInputAction.done,
        controller: widget.plantTypeController,
        maxLines: 1,
        validator: (String? value) { return null; },
    );
  }
}
