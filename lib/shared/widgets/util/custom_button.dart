import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {
        Key? key,
        required this.onTap,
        required this.text,
        this.iconData,
        this.isListMode = false,
        this.isPrimary = false,
        this.isDanger = false,
      })
      : super(key: key);

  final String text;
  final Function() onTap;
  final IconData? iconData;
  final bool isListMode;
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
    Widget innerChild;

    // Choose the right color
    if(isDanger) {
      color = theme.errorColor;
      textColor = buttonColorScheme.onPrimary;
    }
    if(isPrimary) {
      color = buttonColorScheme.primary;
      textColor = buttonColorScheme.onPrimary;
    }

    // Choose icon or no icon
    if(iconData != null) {

      // Is list mode enabled
      if(isListMode) {
        innerChild = Row(
          children: <Widget>[

            Expanded(
              flex: 4,
              child: Icon(iconData, color: textColor),
            ),

            Expanded(
              flex: 6,
              child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                  )
              ),
            ),
          ],
        );

      } else {

        innerChild = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, color: textColor),
            const SizedBox(width: 16.0),
            Text(
                text,
                style: TextStyle(
                  color: textColor,
                )
            ),
          ],
        );
      }



    } else {
      innerChild = Center(
        child: Text(
            text,
            style: TextStyle(
              color: textColor,
            )
        ),
      );
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
          child: innerChild,
        ),
      );
    }
}
