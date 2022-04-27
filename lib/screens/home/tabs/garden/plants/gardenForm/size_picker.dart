import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {

  //dropdown buttons choices
  String? _buttonPotSizeSelected;

  //dropdown menu entry's
  static const sizeMenuItems = <String>[
    'xs',
    's',
    'm',
    'l',
    'xl',
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final List<DropdownMenuItem<String>> _dropDownSizeMenuItems = sizeMenuItems.map(
            (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: textTheme.bodyText1),

        )
    ).toList();

    return ListTile(
      title: Text(widget.title, style: textTheme.bodyText1),
      trailing: DropdownButton(
        value: _buttonPotSizeSelected,
        hint: const Text('Size'),
        onChanged: (String? newValue) {
          if (newValue != null){
            setState(() => _buttonPotSizeSelected = newValue);
          }
        },
        items: _dropDownSizeMenuItems,
      ),
    );
  }
}
