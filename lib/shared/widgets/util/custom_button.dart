import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {
        Key? key,
        required this.onTap,
        required this.text,
        this.isPrimary = false,
        this.isDanger = false,
      })
      : super(key: key);

  final String text;
  final Function() onTap;
  final bool isPrimary;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final buttonColorScheme = Theme
        .of(context)
        .buttonTheme
        .colorScheme!;
    final theme = Theme.of(context);


    Color? color = buttonColorScheme.secondary;
    Color? textColor = buttonColorScheme.onSecondary;

    if(isDanger) {
      color = theme.errorColor;
      textColor = buttonColorScheme.onPrimary;
    }
    if(isPrimary) {
      color = buttonColorScheme.primary;
      textColor = buttonColorScheme.onPrimary;
    }

      return InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.05,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                )
            ),
          ),
        ),
      );
    }
}
