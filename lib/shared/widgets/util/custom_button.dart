import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.onTap, required this.text, this.isPrimary = false})
      : super(key: key);

  final String text;
  final Function() onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final buttonColorScheme = Theme.of(context).buttonTheme.colorScheme!;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: isPrimary?
            buttonColorScheme.primary : buttonColorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary?
                buttonColorScheme.onPrimary : buttonColorScheme.onSecondary,
            )
          ),
        ),
      ),
    );
  }
}