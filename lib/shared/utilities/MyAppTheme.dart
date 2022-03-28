import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  //comon colors
  static const Color accent1 = Color.fromARGB(255, 7, 232, 89);
  //light mode colors
  static const Color lightWhiteHighlight = Color.fromARGB(255, 250, 250, 250);
  //dark mode colors
  static const Color darkGrey = Color.fromARGB(255, 55, 55, 55);
  static const Color darkGreyHighlight = Color.fromARGB(255, 45, 45, 45);

  //light theme defined here
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: accent1,
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyText1: const TextStyle(
        color: darkGrey,
      )
    ),
    iconTheme: const IconThemeData(
      color: accent1,
    ),
    bottomAppBarColor: lightWhiteHighlight,
    unselectedWidgetColor: darkGreyHighlight,
  );

  //dark theme defined here
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkGrey,
    primaryColor: accent1,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
          bodyText1: const TextStyle(
              color: Colors.white
          )
      ),
    iconTheme: const IconThemeData(
      color: accent1,
    ),
    bottomAppBarColor: darkGreyHighlight,
    //unselected icons in app bar
    unselectedWidgetColor: Colors.white,
  );
}
