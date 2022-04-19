import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.leading,
    this.onTap,

  }) : super(key: key);

  final Widget title;
  final Widget? leading;
  final void Function()? onTap;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border:  Border(
              bottom: BorderSide(color: AppColors.grayShade)
          ),
        ),
        child: ListTile(
          title: widget.title,
          leading: const Icon(Icons.logout),
          onTap: widget.onTap,
        )
    );
  }
}
