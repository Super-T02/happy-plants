import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class for the cupertino context menu
class CustomCupertinoContextMenu extends StatefulWidget {
  const CustomCupertinoContextMenu({Key? key, required this.actionItems, required this.child}) : super(key: key);
  final List<CustomCupertinoContextMenuAction> actionItems;
  final Widget child;


  @override
  State<CustomCupertinoContextMenu> createState() => _CustomCupertinoContextMenuState();
}

class _CustomCupertinoContextMenuState extends State<CustomCupertinoContextMenu> {
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      child: widget.child,
      actions: widget.actionItems
    );
  }
}

/// Class for the context menu actions
class CustomCupertinoContextMenuAction extends StatefulWidget {
  const CustomCupertinoContextMenuAction({Key? key, required this.text, this.icon, this.onPressed, this.color = Colors.black}) : super(key: key);
  final void Function()? onPressed;
  final IconData? icon;
  final String text;
  final Color color;

  @override
  State<CustomCupertinoContextMenuAction> createState() => _CustomCupertinoContextMenuActionState();
}

class _CustomCupertinoContextMenuActionState extends State<CustomCupertinoContextMenuAction> {
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenuAction(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.text,
            style: TextStyle(
              color: widget.color,
            ),
          ),
          Icon(
            widget.icon,
            color: widget.color,
          ),
        ],
      ),
      onPressed: widget.onPressed,
    );
  }
}

