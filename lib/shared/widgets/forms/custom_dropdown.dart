import 'package:flutter/material.dart';
import '../../utilities/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    required this.menuItems,
    required this.title,
    required this.onChange,
    required this.hint,
    this.icon,
    this.validator,
    this.value,
  }) : super(key: key);

  final List<String> menuItems;
  final String title;

  final Function(String? newValue) onChange;
  final String hint;
  final IconData? icon;
  final String? value;
  final String? Function(String? value)? validator;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  //dropdown buttons choices
  Widget? suffixIcon;

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
  Color? _getIconColor() {
    if (_focus.hasFocus) {
      return AppColors.accent1;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    //dropdown buttons choices
    String? _currentValue = widget.value;

    if (widget.icon != null) {
      suffixIcon = Icon(widget.icon, color: _getIconColor());
    }

    // Map input menu items to local format
    final List<DropdownMenuItem<String>> _mappedMenuItems = widget.menuItems
        .map((String value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: textTheme.bodyText1,
              ),
            ))
        .toList();

    return Container(
      //same padding as in custom_form_field, so in every form dropdown and form_field
      //look the same (width and height)
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField(
        items: _mappedMenuItems,
        value: _currentValue,
        onChanged: (String? newValue) {
          widget.onChange(newValue!);
          _currentValue = newValue;
        },
        validator: widget.validator,
        enableFeedback: true,
        focusNode: _focus,
        decoration: InputDecoration(
          focusColor: AppColors.accent1,
          hintText: widget.hint,
          labelText: widget.title,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
