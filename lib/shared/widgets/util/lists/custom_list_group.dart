import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';

class CustomListGroup extends StatefulWidget {
  const CustomListGroup({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  State<CustomListGroup> createState() => _CustomListGroupState();
}

class _CustomListGroupState extends State<CustomListGroup> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.from([
          Text(
            widget.title,
            style: theme.textTheme.headline3,
          ),
        ])
          ..addAll(widget.children),
      ),
    );
  }
}
