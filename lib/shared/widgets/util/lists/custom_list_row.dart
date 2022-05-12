import 'package:flutter/material.dart';

class CustomListRow extends StatefulWidget {
  const CustomListRow({Key? key, required this.title, this.data, this.unit})
      : super(key: key);

  final String title;
  final String? data;
  final String? unit;

  @override
  State<CustomListRow> createState() => _CustomListRowState();
}

class _CustomListRowState extends State<CustomListRow> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget data;
    String unit = '';
    if (widget.unit != null) {
      unit = ' ' + widget.unit!;
    }
    if (widget.data != null && widget.data != 'null') {
      data = Expanded(
        child: Text(
          widget.data! + unit,
          style: theme.textTheme.subtitle2,
          textAlign: TextAlign.right,
        ),
      );
    } else {
      data = Expanded(
        child: Text(
          '-',
          style: theme.textTheme.subtitle2,
          textAlign: TextAlign.right,
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: theme.inputDecorationTheme.fillColor!)),
        ),
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: theme.textTheme.bodyText1),
            data,
          ],
        ));
  }
}
