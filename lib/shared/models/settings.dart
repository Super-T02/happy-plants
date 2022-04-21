import 'package:flutter/material.dart';

/// Main model for the settings. It is the top level Object for all Settings
/// defined bellow
class Settings{
  DesignSettings designSettings;
  VacationSettings vacationSettings;
  PushNotificationSettings pushNotificationSettings;


  Settings({
    required this.designSettings,
    required this.vacationSettings,
    required this.pushNotificationSettings,
  });

  /// Generates a default Object
  static Settings getDefault() {
    return Settings(
      designSettings: DesignSettings(),
      vacationSettings: VacationSettings(),
      pushNotificationSettings: PushNotificationSettings(),
    );
  }
}



/// Settings related to the design:
/// - Colorscheme: Dark, Light or System mode
class DesignSettings extends SettingsInterface{
  ColorSchemes? colorScheme;

  DesignSettings({
    this.colorScheme = ColorSchemes.system,
  });

  @override
  void setDefault() {
    colorScheme = ColorSchemes.system;
  }
}



/// Settings for the vacations, if the mode is enabled the person gets no push
/// messages and if implemented a mail to the given contact person will be sent:
/// - enabled (default: false)
/// - duration in days (default: 5 days)
class VacationSettings extends SettingsInterface{
  bool? enabled;
  int? duration; // Duration in days

  VacationSettings({
    this.enabled = false,
    this.duration = 5,
  });

  @override
  void setDefault() {
    enabled = false;
    duration = 5;
  }
}



/// Settings related to push notifications. User can set his default notification
/// time and disable or enable notification:
/// - enabled (default: true)
/// - notificationTime (default: 9:00 am) -> Time when the user will be notified
class PushNotificationSettings extends SettingsInterface{
  bool? enabled;
  TimeOfDay? notificationTime;

  PushNotificationSettings({
    this.enabled = true,
    this.notificationTime = const TimeOfDay(hour: 9, minute: 0),
  });

  @override
  void setDefault() {
    enabled = true;
    notificationTime = const TimeOfDay(hour: 9, minute: 0);
  }
}



/// Enum managing the different possibilities for the color schemes
enum ColorSchemes{
  system,
  dark,
  light
}



/// Abstract class defining the main structure for the setting objects
abstract class SettingsInterface{

  /// Generates a default Object
  void setDefault();
}


