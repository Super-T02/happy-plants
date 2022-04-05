import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';
import 'package:happy_plants/shared/widgets/util/custom_form_field.dart';

import '../../shared/utilities/app_colors.dart';
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
            CustomFormField(
              controller: emailController,
              obscureText: false,
              validator: emailValidator,
              headingText: "Email",
              hintText: "Enter your email",
              maxLines: 1,
              suffixIcon: Icons.mail_outline,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
            ),                // Password
            CustomFormField(
              controller: passwordController,
              obscureText: true,
              validator: passwordValidator,
              headingText: "Password",
              hintText: "Enter a password",
              maxLines: 1,
              suffixIcon: Icons.lock_outline,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              children: <Widget>[
                // Submit Button
                LoginButton(
                  onTap: () => _submit(),
                  text: "Login",
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}
