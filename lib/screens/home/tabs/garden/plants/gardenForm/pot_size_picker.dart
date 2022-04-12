import 'package:flutter/material.dart';

class PotSizePicker extends StatefulWidget {
  const PotSizePicker({Key? key}) : super(key: key);

  @override
  State<PotSizePicker> createState() => _PotSizePickerState();
}

class _PotSizePickerState extends State<PotSizePicker> {

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
      title: Text('Pot Size:', style: textTheme.bodyText1),
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
