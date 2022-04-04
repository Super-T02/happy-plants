import 'package:flutter/material.dart';
import 'package:happy_plants/services/authentication.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton.icon(
            onPressed: () async {
              // TODO: Loading screen + error handling
              await _auth.signOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            icon: const Icon(Icons.logout_outlined),
            label: const Text('Logout')
        ),
      ],
    );
  }
}