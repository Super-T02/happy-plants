import 'package:flutter/material.dart';
import 'package:happy_plants/screens/authenticate/sign_in.dart';
import 'package:happy_plants/screens/home/home.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'notifications/notification.dart';

/// Wrapper holding the SignIn and home widget.
/// It decides which will be chosen on the auth state of the user.
class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  /// Select Notification
  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, NotificationScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    // Open home or sign_in
    if (user == null) {
      return const SignIn(title: 'Happy Plants');
    } else {
      return StreamProvider<DbUser?>.value(
        value: UserService().userStream(user.uid),
        initialData: null,
        child: const Home(
          title: 'Happy Plants',
        ),
      );
    }
  }
}
