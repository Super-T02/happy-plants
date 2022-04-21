import 'package:flutter/material.dart';

class CustomSelect extends StatefulWidget {
  const CustomSelect({
    Key? key,
    required this.menuItems,
    required this.title,
    required this.onChange,
    this.hint
  }) : super(key: key);

  final List<String> menuItems;
  final String title;
  final Function(String? newValue) onChange;
  final String? hint;

  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {

  //dropdown buttons choices
  String? _buttonPotSizeSelected;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget? hint;

    if(widget.hint != null){
      hint = Text(widget.hint!);
    }

    // Map input menu items to local format
    final List<DropdownMenuItem<String>> _mappedMenuItems = widget.menuItems.map(
        (String value) => DropdownMenuItem(
          value: value,
          child: Text(value, style: textTheme.bodyText1,),
        )
    ).toList();


    return Row(
      children: <Widget>[
        Text(widget.title, style: textTheme.bodyText1),
        DropdownButton(
          value: _buttonPotSizeSelected,
          hint: hint,
          onChanged: (String? newValue) {
            widget.onChange(newValue);
          },
          items: _mappedMenuItems,
        ),
      ],
    );

  }

}