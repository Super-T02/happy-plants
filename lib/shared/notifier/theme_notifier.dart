import 'package:flutter/material.dart';
import 'package:happy_plants/services/settings.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode currentMode = ThemeMode.system;

  ThemeNotifier() {
    currentMode = SettingsService.getCurrentThemeMode();
  }

  changeThemeMode(ThemeMode newMode) {
    currentMode = newMode;
    SettingsService.setCurrentThemeMode(newMode);
    notifyListeners();
  }
}
