/// This is the config file for the whole project
/// Global variables are initiated here for a global use

library config.globals;

import 'package:happy_plants/shared/notifier/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Notifier for theme mode changes
ThemeNotifier currentTheme = ThemeNotifier();

/// Shared preferences is a package for saving key value pairs local on the phone
SharedPreferences? sharedPreferences;

/// Marks, whether the user data are already loaded or not
bool modeInit = false;