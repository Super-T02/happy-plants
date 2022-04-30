import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/app_colors.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';

class CustomAccordion extends StatefulWidget {
  const CustomAccordion({Key? key, required this.heading, required this.description, required this.childrenWidgets}) : super(key: key);

  final String heading;
  final String description;
  final List<Widget> childrenWidgets;

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        ExpansionTile(
          title: Text(widget.heading, style: theme.textTheme.headline3),
          subtitle: Text(widget.description, style: theme.textTheme.subtitle2),
          tilePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          children: widget.childrenWidgets,
          iconColor: theme.unselectedWidgetColor,
        ),
        const SizedBox(height: 10)
      ],
    );

  }
}

