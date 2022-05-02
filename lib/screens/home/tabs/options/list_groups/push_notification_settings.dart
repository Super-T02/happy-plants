import 'package:flutter/material.dart';
import 'package:happy_plants/config.dart';
import 'package:happy_plants/services/event.dart';
import 'package:happy_plants/services/shared_preferences_controller.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/settings.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group_switch.dart';
import 'package:provider/provider.dart';
import 'package:system_settings/system_settings.dart';
import '../../../../../services/authentication.dart';
import '../../../../../services/notification.dart';
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

  /// Enables or disables the notifications for this app
  Future<void> onSwitchChange(bool isEnabledNew, DbUser user) async {

    // Set the settings in the cloud
    user.settings ??= CustomSettings(
      designSettings: DesignSettingsModel(),
      vacationSettings: VacationSettingsModel(),
      pushNotificationSettings: PushNotificationSettingsModel(),
    );

    user.settings!.pushNotificationSettings.enabled = isEnabledNew;

    await UserService.putNewDbUser(user);

    SharedPreferencesController.setNotificationTimeStatus(isEnabledNew);

    if(!isEnabledNew) {
      notificationService.cancelAllNotifications();
    } else {
      EventService.scheduleAllNotifications(user);
    }



    setState(() {
      isEnabled = SharedPreferencesController.getNotificationTimeStatus();
      time = SharedPreferencesController.getCurrentNotificationTime();
    });
  }

  Future<void> onChangeNotificationTime(context, DbUser user) async {
    TimeOfDay? result = await showTimePicker(context: context, initialTime: time!);

    if(result != null) {
      // Set the settings in the cloud
      user.settings ??= CustomSettings(
        designSettings: DesignSettingsModel(),
        vacationSettings: VacationSettingsModel(),
        pushNotificationSettings: PushNotificationSettingsModel(),
      );

      user.settings!.pushNotificationSettings.notificationTime = result;

      await UserService.putNewDbUser(user);

      SharedPreferencesController.setCurrentNotificationTime(result);

      notificationService.cancelAllNotifications();
      EventService.scheduleAllNotifications(user);

      setState(() {
        isEnabled = SharedPreferencesController.getNotificationTimeStatus();
        time = SharedPreferencesController.getCurrentNotificationTime();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DbUser? user = Provider.of<DbUser?>(context);

    return CustomListGroupSwitch(
        title: 'Push Notifications',
        isEnabled: isEnabled!,
        onSwitchChange: (value) => onSwitchChange(value, user!),
        children: <Widget>[
          CustomListTile(
            title: 'Change Notification Time',
            subtitle: _displayCurrentTime(time!),
            leading: Icons.access_time,
            onTap: () => onChangeNotificationTime(context, user!),
          ),
          CustomListTile(
            title: 'Show pending notifications',
            leading: Icons.numbers_outlined,
            onTap: () async {
              final notification = NotificationService();
              notification.checkPendingNotificationRequests(context);
            },
          ),
          CustomListTile(
            title: 'Go to System settings',
            leading: Icons.settings_outlined,
            onTap: () async {
              SystemSettings.app();
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

