import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';

class SubmitDialog extends StatelessWidget {
  const SubmitDialog({
    Key? key,
    required this.title,
    required this.text,
    required this.onSubmit,
    this.submitText = 'Yes',
    this.onAbort,
  }) : super(key: key);
  final String submitText;
  final String title;
  final String text;
  final Function onSubmit;
  final Function? onAbort;



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center,),
      actions: [
        CustomButton(
          onTap: (){
              Navigator.pop(context);
              onSubmit();
            },
          text: submitText,
          isDanger: true,
        ),
        const SizedBox(height: 16.0,),
        CustomButton(
          onTap: (){
              Navigator.pop(context);
              if(onAbort != null) onAbort!();
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
          Text(text),
        ],
      ),
    );
  }
}
