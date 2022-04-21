import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';

class CustomListGroupSwitch extends StatefulWidget {
  const CustomListGroupSwitch({
    Key? key,
    required this.title,
    required this.children,
    required this.onSwitchChange,
    this.isEnabled = false,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final void Function(bool) onSwitchChange;
  final bool isEnabled;

  @override
  State<CustomListGroupSwitch> createState() => _CustomListGroupSwitchState();
}

class _CustomListGroupSwitchState extends State<CustomListGroupSwitch> {

  bool? isEnabled;

  @override
  void initState() {
    isEnabled = widget.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Widget> children = [];


    // Only display the options, when enabled
    if(isEnabled!) {
      children = widget.children;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.from([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.title, style: theme.textTheme.headline3,),
                Switch(
                    value: isEnabled!,
                    onChanged: (changedValue) {
                      setState(() {
                        isEnabled = changedValue;
                      });
                      widget.onSwitchChange(changedValue);
                    }
                ),
              ]
          ),

        ])..addAll(children),
      ),
    );
  }
}
