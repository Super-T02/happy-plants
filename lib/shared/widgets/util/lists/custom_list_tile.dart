import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.leading,
    this.onTap,

  }) : super(key: key);

  final String title;
  final IconData? leading;
  final void Function()? onTap;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(
          border:  Border(
              bottom: BorderSide(color: theme.inputDecorationTheme.fillColor!)
          ),
        ),
        child: ListTile(
          title: Text(widget.title, style: theme.textTheme.bodyText1),
          leading: Icon(widget.leading),
          onTap: widget.onTap,
        )
    );
  }
}
