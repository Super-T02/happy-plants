import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';
import '../../utilities/app_colors.dart';


class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {Key? key,
        required this.headingText,
        required this.hintText,
        required this.obscureText,
        required this.textInputType,
        required this.textInputAction,
        required this.controller,
        required this.maxLines,
        required this.validator,
        this.suffixIcon,
        this.onChange,
      })
      : super(key: key);

  final String headingText;
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  final FormFieldValidator<String> validator;
  final Function(String? value)? onChange;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final FocusNode _focus = FocusNode();

  /// Actualizes on focus changed the state of this widget
  void _onFocusChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  /// Generates the color of the suffix icon
  Color? _getIconColor(){
    if(_focus.hasFocus){
      return AppColors.accent1;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget? icon;

    if(widget.suffixIcon != null) {
      icon = Icon(widget.suffixIcon, color: _getIconColor());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            focusNode: _focus,
            cursorColor: AppColors.accent1,
            maxLines: widget.maxLines,
            controller: widget.controller,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            obscureText: widget.obscureText,
            style: Theme.of(context).textTheme.bodyText1,
            onChanged: (String? value){
              if(widget.onChange != null) widget.onChange!(value);
            },
            // Decoration
            decoration: InputDecoration(
                focusColor: AppColors.accent1,
                hintText: widget.hintText,
                labelText: widget.headingText,
                suffixIcon: icon
            ),
          ),
        ),
      ],
    );
  }
}

