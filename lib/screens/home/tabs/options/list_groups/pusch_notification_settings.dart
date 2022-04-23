import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group_switch.dart';
import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class PushNotificationSettings extends StatelessWidget {
  PushNotificationSettings({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return CustomListGroupSwitch(
        title: 'Push Notifications',
        isEnabled: true,
        onSwitchChange: (bool value) {
          // TODO
        },
        children: <Widget>[
          CustomListTile(
            title: 'Change Notification Time',
            subtitle: 'Current: 9:00 am',
            leading: Icons.access_time,
            onTap: () async {
              // TODO
            },
          ),
          CustomListTile(
            title: 'Go to System settings',
            leading: Icons.settings_outlined,
            onTap: () async {
              // TODO
            },
          ),
        ]
    );
  }
}
