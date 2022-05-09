import 'package:flutter/material.dart';

/// Main model for the settings. It is the top level Object for all Settings
/// defined bellow
class CustomSettings{
  DesignSettingsModel designSettings;
  PushNotificationSettingsModel pushNotificationSettings;


  CustomSettings({
    required this.designSettings,
    required this.pushNotificationSettings,
  });

  Map toJSON(){
    return {
      "designSettings": designSettings.toJSON(),
      "pushNotificationSettings": pushNotificationSettings.toJSON(),
    };
  }

  /// Generates a default Object
  static CustomSettings getDefault() {
    return CustomSettings(
      designSettings: DesignSettingsModel(),
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


