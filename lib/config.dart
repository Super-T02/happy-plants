library config.globals;


import 'package:happy_plants/shared/notifier/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeNotifier currentTheme = ThemeNotifier();
SharedPreferences? sharedPreferences;
bool modeInit = false;