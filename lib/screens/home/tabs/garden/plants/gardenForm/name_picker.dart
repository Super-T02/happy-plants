import 'package:flutter/material.dart';
import '../../../../../../shared/widgets/util/custom_form_field.dart';

class NamePicker extends StatefulWidget {
  const NamePicker({Key? key, required this.plantNameController}) : super(key: key);

  final TextEditingController plantNameController;

  @override
  State<NamePicker> createState() => _NamePickerState();
}

class _NamePickerState extends State<NamePicker> {

  // Form controllers
  TextEditingController plantNameController = TextEditingController();

  /// Validator for the plant name
  String? nameValidator(String? value) {
    if(value == null || value.isEmpty){
      return 'Please enter a name';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
        headingText: "Plant Name *",
        hintText: "Please enter a plant name",
        obscureText: false,
        suffixIcon: null,
        textInputType: TextInputType.name,
        textInputAction: TextInputAction.done,
        controller: widget.plantNameController,
        maxLines: 1,
        validator: nameValidator
    );
  }
}
