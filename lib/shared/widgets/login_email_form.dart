import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/core/services/authentication.dart';

class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({Key? key}) : super(key: key);

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  /// Setup the key for the form
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  String _email = '';
  String _password = '';
  bool _isSubmitDisabled = true;


  /// Checks whether the button can be enabled or not
  void _checkValid() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitDisabled = false;
      });
    } else if(!_isSubmitDisabled){
      setState(() {
        _isSubmitDisabled = true;
      });
    }
  }

  /// Handles submit event for emailLogin
  void _submit() async {
    // Check for valid form
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      User user = await _authService.signInEmail(_email, _password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(user.uid)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email
          TextFormField(
            onChanged: (changes) => _checkValid(),
            onSaved: (value){_email=value!;},
              // Validates the email
              validator: (value) =>
              EmailValidator.validate(value!) ?
              null : 'Please enter a valid Email',

              decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.mail_outline)
              ),
              ),
              // Password
              TextFormField(
              obscureText: true,
              onChanged: (changes) => _checkValid(),
              onSaved: (value){_password=value!;},
              decoration: const InputDecoration(
              labelText: 'Password',
              icon: Icon(Icons.lock_outline)
              ),
              validator: (value) =>
              value!.trim().isEmpty ?
                'Password is required' : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _isSubmitDisabled? null : () => _submit(),
              child: const Text('Submit'),
            ),
          ),
        ]
      ),
    );
  }
}
