import 'package:flutter/material.dart';
import 'package:happy_plants/services/shared_preferences_controller.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group_switch.dart';
import '../../../../../services/authentication.dart';
import '../../../../../shared/widgets/util/lists/custom_list_tile.dart';

class PushNotificationSettings extends StatefulWidget {
  const PushNotificationSettings({Key? key}) : super(key: key);

  @override
  State<PushNotificationSettings> createState() => _PushNotificationSettingsState();
}

class _PushNotificationSettingsState extends State<PushNotificationSettings> {
  final AuthService _auth = AuthService();
  bool? isEnabled;
  TimeOfDay? time;

  @override
  void initState() {
    isEnabled = SharedPreferencesController.getNotificationTimeStatus();
    time = SharedPreferencesController.getCurrentNotificationTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomListGroupSwitch(
        title: 'Push Notifications',
        isEnabled: isEnabled!,
        onSwitchChange: (bool value) {
          SharedPreferencesController.setNotificationTimeStatus(value);
          setState(() {
            isEnabled = SharedPreferencesController.getNotificationTimeStatus();
            time = SharedPreferencesController.getCurrentNotificationTime();
          });
        },
        children: <Widget>[
          CustomListTile(
            title: 'Change Notification Time',
            subtitle: _displayCurrentTime(time!),
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

  /// Displays the current time in the wished format
  String _displayCurrentTime(TimeOfDay time){
    String hour, minute, timeType;

    if(time.hour <= 12){
      timeType = 'am';
    } else {
      timeType = 'pm';
    }

    hour = time.hour.toString();

    switch(time.hour) {
      case 13:
        hour = '1';
        break;
      case 14:
        hour = '2';
        break;
      case 15:
        hour = '3';
        break;
      case 16:
        hour = '4';
        break;
      case 17:
        hour = '5';
        break;
      case 18:
        hour = '6';
        break;
      case 19:
        hour = '7';
        break;
      case 20:
        hour = '8';
        break;
      case 21:
        hour = '9';
        break;
      case 22:
        hour = '10';
        break;
      case 23:
        hour = '11';
        break;
      case 24:
        hour = '12';
        break;
    }

    if(time.minute < 10){
      minute = '0' + time.minute.toString();
    } else {
      minute = time.minute.toString();
    }

    return 'Current: $hour:$minute $timeType';
  }
}

