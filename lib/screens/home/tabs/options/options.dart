import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/account_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/design_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/pusch_notification_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/vacation_settings.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';
class Options extends StatefulWidget {
  const Options({Key? key, required this.changeColorScheme}) : super(key: key);
  final Function(ThemeMode newMode) changeColorScheme;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final AuthService _auth = AuthService();
  final _key = GlobalKey();
  DbUser? dbUser;
  bool isInitialized = false;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DbUser?>(context);

    if(user != null) {
      return ListView(
          key: _key,
          children: <Widget>[

            // ALWAYS DISPLAYED
            AccountSettings(user: user),
            DesignSettings(user: user, changeColorScheme: widget.changeColorScheme,),

            // OPTIONAL SETTINGS
            PushNotificationSettings(),
            VacationSettings(),
          ]
      );
    } else {
      return Column();
    }


  }
}