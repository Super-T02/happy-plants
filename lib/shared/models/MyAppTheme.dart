import 'dart:ui';
import 'package:flutter/material.dart';

class MyAppTheme {
  Color accent1 = const Color.fromARGB(255, 7, 232, 89);

  static final LightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color.fromARGB(255, 7, 232, 89),
  );

  static final DarkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color.fromARGB(255, 7, 232, 89),
  );
}
