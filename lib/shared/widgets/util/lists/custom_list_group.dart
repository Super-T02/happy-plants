import 'package:flutter/material.dart';

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.from([Text(widget.title)])..addAll(widget.children),
    );
  }
}
