import 'package:flutter/material.dart';
import '../config.dart';

class SharedPreferencesController{
  static const String notificationTimeHourKey = 'settings_notification_time_hour';
  static const String notificationTimeMinuteKey = 'settings_notification_time_minute';

  /// Set the current notification time to the given time in the phone settings
  static void setCurrentNotificationTime(TimeOfDay time){
    sharedPreferences!.setInt(notificationTimeHourKey, time.hour);
    sharedPreferences!.setInt(notificationTimeMinuteKey, time.minute);
  }

  /// Get the default notification time from the phone settings
  static TimeOfDay getCurrentThemeMode() {

    int? hour = sharedPreferences!.getInt(notificationTimeHourKey);
    int? minute = sharedPreferences!.getInt(notificationTimeMinuteKey);

    hour ??= 9;
    minute ??= 0;

    TimeOfDay time = TimeOfDay(hour: hour, minute: minute);

    return time;
  }

}