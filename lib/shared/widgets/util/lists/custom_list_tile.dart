import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,

  }) : super(key: key);

  final String title;
  final String? subtitle;
  final IconData? leading;
  final void Function()? onTap;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget? subtitle;

    if(widget.subtitle != null) {
      subtitle = Text(widget.subtitle!, style: theme.textTheme.subtitle2, );
    }

      return Container(
          decoration: BoxDecoration(
            border:  Border(
                bottom: BorderSide(color: theme.inputDecorationTheme.fillColor!)
            ),
          ),
          child: ListTile(
            title: Text(widget.title, style: theme.textTheme.bodyText1),
            subtitle: subtitle,
            leading: Icon(widget.leading),
            onTap: widget.onTap,
          )
      );
  }
}

