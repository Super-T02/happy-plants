import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';

class InformationDialog extends StatelessWidget {
  const InformationDialog({
    Key? key,
    required this.title,
    required this.children,
    required this.onSubmit,
    this.submitText = 'Yes',
    this.onAbort,
  }) : super(key: key);
  final String submitText;
  final String title;
  final List<Widget> children;
  final Function onSubmit;
  final Function? onAbort;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme =
        Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    return AlertDialog(
      title:
          Text(title, textAlign: TextAlign.center, style: textTheme.headline3),
      actions: [
        CustomButton(
          onTap: () {
            Navigator.pop(context);
            onSubmit();
          },
          text: submitText,
          isPrimary: true,
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
