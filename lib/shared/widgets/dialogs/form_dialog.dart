import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({
    Key? key,
    required this.title,
    required this.onSubmit,
    required this.children,
    this.description,
    this.onAbort,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final Function onSubmit;
  final String? description;
  final Function? onAbort;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Widget? text;
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme =
        Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    if (description != null) {
      text = Text(description!);
    } else {
      text = const SizedBox();
    }

    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: textTheme.headline3,
      ),
      actions: [
        CustomButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context);
              onSubmit();
            }
          },
          text: 'Submit',
          isPrimary: true,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomButton(
          onTap: () {
            Navigator.pop(context);
            if (onAbort != null) onAbort!();
          },
          text: 'Abort',
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          text,
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}
