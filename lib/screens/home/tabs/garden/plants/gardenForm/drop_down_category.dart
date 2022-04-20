import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';

class DropDownCategory extends StatefulWidget {
  const DropDownCategory({Key? key, required this.heading, required this.description, required this.childrenWidgets}) : super(key: key);

  final String heading;
  final String description;
  final List<Widget> childrenWidgets;

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        ExpansionTile(
          title: Text(widget.heading, style: theme.textTheme.headline3),
          subtitle: Text(widget.description, style: theme.textTheme.bodyText1),
          tilePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          children: widget.childrenWidgets

        ),
      ],
    );

  }
}

