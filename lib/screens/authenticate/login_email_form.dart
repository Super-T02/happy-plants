import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/widgets/util/custom_button.dart';
import 'package:happy_plants/shared/widgets/util/custom_form_field.dart';
import 'package:fluttericon/font_awesome_icons.dart';

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

  // Images
  final lightImage = "assets/images/LightWelcome.svg";
  final darkImage = "assets/images/DarkWelcome.svg";

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

  void _withGoogle() async {
    // Check for valid form
    await _authService.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness;

    return Form(
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
          ),

          // Password
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

          // Row for forget password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/forgetPassword'),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),

          // Login Button
          CustomButton(
            onTap: () => _submit(),
            text: 'Sign In',
            iconData: FontAwesome.login,
            isListMode: true,
            isPrimary: true,
          ),

          const SizedBox(height: 16.0,),
          
          // Google Login
          CustomButton(
            onTap: () => _withGoogle(),
            text: 'With Google',
            iconData: FontAwesome.google,
            isListMode: true,
          ),
          
          // Sign Up Button
          const SizedBox(height: 16.0,),
          CustomButton(
            onTap: () => Navigator.pushNamed(context, '/signUp'),
            text: 'Register with Email',
            iconData: Icons.mail_outline,
            isListMode: true,
          ),
          
        ],
      ),
      ),
    );
  }
}
