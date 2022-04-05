import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/models/user.dart';

import '../../shared/utilities/theme.dart';

/// Widget for the email login
class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({Key? key}) : super(key: key);

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  // Setup the key for the form
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Form controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Validator for the email
  String? emailValidator(String? value) {
    if(value == null || value.trim().isEmpty || !EmailValidator.validate(value.trim())){
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  /// Validator for the password
  String? passwordValidator(String? value) {
    if(value == null || value.trim().isEmpty){
      return 'Please enter a password';
    } else {
      return null;
    }
  }

  /// Handles submit event for emailLogin
  void _submit() async {
    // Check for valid form
    if (_formKey.currentState!.validate()) {
      await _authService.signInEmail(
          emailController.text.trim(),
          passwordController.text
      );
    }
  }

  // TODO: Please add a style to this component

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // Email
            TextFormField(
              controller: emailController,
              validator: emailValidator,
              style: textTheme.bodyText1,
              cursorColor: MyAppTheme.accent1,
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(
                  Icons.mail_outline,
                  color: textTheme.bodyText1!.color,
                )
              ),
            ),

            const SizedBox(height: 20.0),

                // Password
            TextFormField(
              controller: passwordController,
              obscureText: true,
              style: textTheme.bodyText1,
              cursorColor: MyAppTheme.accent1,
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(
                  Icons.lock_outline,
                  color: textTheme.bodyText1!.color,
                )
             ),
            validator: passwordValidator,
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: theme.primaryColor
                  ),
                  onPressed: () => _submit(),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}
