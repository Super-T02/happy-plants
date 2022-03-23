import 'package:flutter/material.dart';
import 'package:happy_plants/screens/authenticate/sign_in.dart';
import 'package:happy_plants/screens/home/home.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    // Open home or sign_in
    if(user == null){
      return const SignIn(title: 'Happy Plants');
    } else {
      return const Home(title: 'Happy Plants');
    }

  }
}
