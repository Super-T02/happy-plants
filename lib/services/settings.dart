import 'package:flutter/material.dart';

import '../config.dart';

class SettingsService with ChangeNotifier {

  static const String themeModeKey = 'settings_design_theme_mode';

  /// Safe the theme mode locally at the device
  static void setCurrentThemeMode(ThemeMode newMode) {
    // set value
    sharedPreferences!.setString(themeModeKey, newMode.toString());
  }


  /// Get the theme mode locally at the device
  static ThemeMode getCurrentThemeMode() {
    ThemeMode? mode = getThemeModeFromString(sharedPreferences!.getString(themeModeKey));

    mode ??= ThemeMode.system;

    return mode;
  }

  /// Maps the string for a theme mode to the fitting theme mode
  /// Requires:
  /// - String?: Theme mode as String
  ///
  /// Returns:
  /// - ThemeMode object or null (if it doesn't exist)
  static ThemeMode? getThemeModeFromString(String? stringThemeMode){
    switch(stringThemeMode){
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
}