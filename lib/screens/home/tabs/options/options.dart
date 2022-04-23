import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/account_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/design_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/pusch_notification_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/vacation_settings.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_tile.dart';
import 'package:provider/provider.dart';

class Options extends StatefulWidget {
  Options({Key? key, required this.userId}) : super(key: key);

  String userId;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final AuthService _auth = AuthService();
  final _key = GlobalKey();
  DbUser? dbUser;
  bool isInitialized = false;

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      dbUser = await UserService.getCurrentDbUser(widget.userId);
      setState(() {
        isInitialized = true;
      });
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    if(isInitialized) {
      return ListView(
          key: _key,
          children: <Widget>[

            // ALWAYS DISPLAYED
            AccountSettings(user: dbUser!, triggerReload: () => setState(() {}),),
            DesignSettings(),

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