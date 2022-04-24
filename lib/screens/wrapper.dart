import 'package:flutter/material.dart';
import 'package:happy_plants/screens/authenticate/sign_in.dart';
import 'package:happy_plants/screens/home/home.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';

/// Wrapper holding the SignIn and home widget.
/// It decides which will be chosen on the auth state of the user.
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    // Open home or sign_in
    if(user == null){
      return const SignIn(title: 'Happy Plants');
    } else {
      return StreamProvider<DbUser?>.value(
        value: UserService.userStream(user.uid),
        initialData: null,
        child: const Home(title: 'Happy Plants'),
      );
    }
  }
}
