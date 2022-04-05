import 'package:flutter/material.dart';
import 'package:happy_plants/screens/authenticate/login_email_form.dart';
import 'package:happy_plants/shared/utilities/app_colors.dart';

/// Widget for handling the login Form if the user isn't logged in
class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: const SingleChildScrollView(
        child: EmailLoginForm(),
      ),
    );
  }
}
