import 'package:flutter/material.dart';

class CustomListRow extends StatefulWidget {
  const CustomListRow({Key? key, required this.title, required this.data}) : super(key: key);

  final String title;
  final String data;

  @override
  State<CustomListRow> createState() => _CustomListRowState();
}

class _CustomListRowState extends State<CustomListRow> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border:  Border(
            bottom: BorderSide(color: theme.inputDecorationTheme.fillColor!)
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0,15, 0, 15),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: theme.textTheme.bodyText1),
          Expanded(child:
            Text(
              widget.data,
              style: theme.textTheme.subtitle2,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      )
    );
  }
}
