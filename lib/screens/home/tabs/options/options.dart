import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/account_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/design_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/pusch_notification_settings.dart';
import 'package:happy_plants/screens/home/tabs/options/list_groups/vacation_settings.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_tile.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AccountSettings(),
        PushNotificationSettings(),
        DesignSettings(),
        VacationSettings(),
      ]
    );
  }
}