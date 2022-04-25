import 'package:flutter/material.dart';

/// Main model for the settings. It is the top level Object for all Settings
/// defined bellow
class CustomSettings{
  DesignSettingsModel designSettings;
  VacationSettingsModel vacationSettings;
  PushNotificationSettingsModel pushNotificationSettings;


  CustomSettings({
    required this.designSettings,
    required this.vacationSettings,
    required this.pushNotificationSettings,
  });

  Map toJSON(){
    return {
      "designSettings": designSettings.toJSON(),
      "vacationSettings": vacationSettings.toJSON(),
      "pushNotificationSettings": pushNotificationSettings.toJSON(),
    };
  }

  /// Generates a default Object
  static CustomSettings getDefault() {
    return CustomSettings(
      designSettings: DesignSettingsModel(),
      vacationSettings: VacationSettingsModel(),
      pushNotificationSettings: PushNotificationSettingsModel(),
    );
  }
}



/// Settings related to the design:
/// - Colorscheme: Dark, Light or System mode
class DesignSettingsModel extends SettingsInterface{
  ThemeMode? colorScheme;

  DesignSettingsModel({
    this.colorScheme = ThemeMode.system,
  });

  Map toJSON() {
    return {
      "colorScheme":  colorScheme.toString()
    };
  }

  @override
  void setDefault() {
    colorScheme = ThemeMode.system;
  }
}



/// Settings for the vacations, if the mode is enabled the person gets no push
/// messages and if implemented a mail to the given contact person will be sent:
/// - enabled (default: false)
/// - until (default: 5 days)
class VacationSettingsModel extends SettingsInterface{
  bool? enabled;
  DateTime? duration; // Duration in days

  VacationSettingsModel({
    this.enabled = false,
    duration = 5
  }){
    this.duration = DateTime.now().add(Duration(days: duration!));
  }

  Map toJSON(){
    return {
      "enabled": enabled,
      "duration": duration?.toUtc(),
    };
  }

  @override
  void setDefault() {
    enabled = false;
    duration = DateTime.now().add(const Duration(days: 5));
  }
}



/// Settings related to push notifications. User can set his default notification
/// time and disable or enable notification:
/// - enabled (default: true)
/// - notificationTime (default: 9:00 am) -> Time when the user will be notified
class PushNotificationSettingsModel extends SettingsInterface{
  bool? enabled;
  TimeOfDay? notificationTime;

  PushNotificationSettingsModel({
    this.enabled = true,
    this.notificationTime = const TimeOfDay(hour: 9, minute: 0),
  });

  Map toJSON(){
    return {
      "enabled": enabled,
      "notificationTime": {
        "hour": notificationTime?.hour,
        "minute": notificationTime?.minute,
      },
    };
  }

  @override
  void setDefault() {
    enabled = true;
    notificationTime = const TimeOfDay(hour: 9, minute: 0);
  }
}


/// Abstract class defining the main structure for the setting objects
abstract class SettingsInterface{

  /// Generates a default Object
  void setDefault();
}


