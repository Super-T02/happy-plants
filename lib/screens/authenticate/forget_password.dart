import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../services/authentication.dart';
import '../../shared/widgets/util/custom_button.dart';
import '../../shared/widgets/util/custom_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // Setup the key for the form
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Images
  final lightImage = "assets/images/LightForget.svg";
  final darkImage = "assets/images/DarkForget.svg";

  // Form controllers
  TextEditingController emailController = TextEditingController();

  /// Validator for the email
  String? emailValidator(String? value) {
    if(value == null || value.trim().isEmpty || !EmailValidator.validate(value.trim())){
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  /// Handles submit event for emailLogin
  void _submit() async {
    // Check for valid form
    if (_formKey.currentState!.validate()) {
      await _authService.resetPassword(
          emailController.text.trim(),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        foregroundColor: Theme.of(context).unselectedWidgetColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(4.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0,),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.09),
                  child: SvgPicture.asset(darkMode == Brightness.dark? darkImage : lightImage),
                ),

                const SizedBox(height: 16.0,),

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

                const SizedBox(height: 16.0,),

                // Login Button
                CustomButton(
                  onTap: () => _submit(),
                  text: 'Reset Password',
                  isPrimary: true,
                ),

                const SizedBox(height: 16.0,),

                CustomButton(
                  onTap: () => Navigator.of(context).pop(),
                  text: 'Abort',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

