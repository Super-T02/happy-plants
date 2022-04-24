import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../services/authentication.dart';
import '../../shared/utilities/util.dart';
import '../../shared/widgets/util/custom_button.dart';
import '../../shared/widgets/util/custom_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);


  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Images
  final lightImage = "assets/images/LightWelcome.svg";
  final darkImage = "assets/images/DarkWelcome.svg";



  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness;

    // Form controllers
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordRepController = TextEditingController();

    /// Validator for the username
    String? nameValidator(String? value) {
      if(value == null || value.trim().isEmpty){
        return 'Please enter a username';
      } else {
        return null;
      }
    }

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
      if(value == null || value.trim().isEmpty || value.trim().length < 6){
        return 'Please enter a password with at least 6 digits';
      } else if(!value.contains(RegExp(r'[A-Z]'))) {
        return 'The password must contain at least one capital letter';
      } else if(!value.contains(RegExp(r'[a-z]'))) {
        return 'The password must contain at least one normal letter';
      } else if(!value.contains(RegExp(r'[0-9]'))) {
        return 'The password must contain at least one number';
      } else {
        return null;
      }
    }

    /// Validator for the repeated password
    String? passwordRepValidator(String? value) {
      if(value == null || value.trim().isEmpty){
        return 'Please repeat the password';
      } else if(value.trim() != passwordController.text.trim()){
        return 'The passwords are not the same';
      } else {
        return null;
      }
    }

    /// Handles submit event for emailSignup
    void _submit() async {
      // Check for valid form
      if (_formKey.currentState!.validate()) {

        await _authService.signUpEmail(
            nameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim()
        );

        // TODO: give user feedback

        Navigator.of(context).pop();
      }

      // Todo: else
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,


                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09),
                    child: SvgPicture.asset(darkMode == Brightness.dark? darkImage : lightImage),
                  ),

                  // Name
                  CustomFormField(
                    controller: nameController,
                    obscureText: false,
                    validator: nameValidator,
                    headingText: "Username *",
                    hintText: "Enter your Username",
                    maxLines: 1,
                    suffixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                  ),

                  // Email
                  CustomFormField(
                    controller: emailController,
                    obscureText: false,
                    validator: emailValidator,
                    headingText: "Email *",
                    hintText: "Enter your email",
                    maxLines: 1,
                    suffixIcon: Icons.mail_outline,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                  ),

                  // Password
                  CustomFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: passwordValidator,
                    headingText: "Password *",
                    hintText: "Enter a password",
                    maxLines: 1,
                    suffixIcon: Icons.lock_outline,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                  ),

                  // Password
                  CustomFormField(
                    controller: passwordRepController,
                    obscureText: true,
                    validator: passwordRepValidator,
                    headingText: "Repeat your Password *",
                    hintText: "Enter the password again",
                    maxLines: 1,
                    suffixIcon: Icons.lock_outline,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                  ),

                  const SizedBox(height: 18.0,),

                  // Login Button
                  CustomButton(
                    onTap: () => _submit(),
                    text: 'Sign Up',
                    isPrimary: true,
                    iconData: Icons.check_outlined,
                    isListMode: true,
                  ),
                  // Login Button

                  const SizedBox(height: 18.0,),

                  CustomButton(
                    onTap: () => Navigator.of(context).pop(),
                    text: 'Abort',
                    iconData: Icons.close_outlined,
                    isListMode: true,
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

