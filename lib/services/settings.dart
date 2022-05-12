import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/shared_preferences_controller.dart';
import 'package:happy_plants/services/user.dart';
import 'package:happy_plants/shared/models/user.dart';

import '../config.dart';
import '../shared/models/settings.dart';

class SettingsService with ChangeNotifier {
  static const String themeModeKey = 'settings_design_theme_mode';

  /// Safe the theme mode locally at the device
  static void setCurrentThemeMode(ThemeMode newMode) {
    // set value
    sharedPreferences!.setString(themeModeKey, newMode.toString());
  }

  /// Get the theme mode locally at the device
  static ThemeMode getCurrentThemeMode() {
    ThemeMode? mode =
        getThemeModeFromString(sharedPreferences!.getString(themeModeKey));

    mode ??= ThemeMode.system;

    return mode;
  }

  /// Maps the string for a theme mode to the fitting theme mode
  /// Requires:
  /// - String?: Theme mode as String
  ///
  /// Returns:
  /// - ThemeMode object or null (if it doesn't exist)
  static ThemeMode? getThemeModeFromString(String? stringThemeMode) {
    switch (stringThemeMode) {
      case 'ThemeMode.system':
        return ThemeMode.system;
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return null;
    }
  }

  /// Loads all settings to the shared prefs
  /// Requires:
  ///  - String userId: id of an existing user
  ///
  /// --> Manipulates the shared preferences
  static Future<void> loadSettingsFromCloud(String userId) async {
    UserService userService = UserService();

    DbUser? user = await userService.userStream(userId).first;

    if (user != null) {
      // Load settings
      user.settings ??= CustomSettings(
        designSettings: DesignSettingsModel(),
        pushNotificationSettings: PushNotificationSettingsModel(),
      );

      SharedPreferencesController.setNotificationTimeStatus(
          user.settings!.pushNotificationSettings.enabled);
      SharedPreferencesController.setCurrentNotificationTime(
          user.settings!.pushNotificationSettings.notificationTime);
    }
  }
}
