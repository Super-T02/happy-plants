import 'package:flutter/material.dart';

class AppColors {
  static const Color whiteShade = Color(0xFFF8F9FA);
  static const Color grayShade = Color(0xFFEBEBEB);
  static const Color darkGrey = Color.fromARGB(255, 55, 55, 55);
  static const Color blackShade = Color(0xFF555555);
  static const Color accent1 = Color.fromARGB(255, 7, 232, 89);



  //light mode colors
  static const Color lightWhiteHighlight = Color.fromARGB(255, 250, 250, 250);
  static const hintTextLight = Color(0xFF7A7A7F);
  static const buttonColorSchemeLight = ColorScheme(
      brightness: Brightness.light,
      primary: accent1,
      onPrimary: Colors.white,
      secondary: grayShade,
      onSecondary: darkGrey,
      error: Colors.redAccent,
      onError: Colors.white,
      background: Color(0xFF68686C),
      onBackground: Colors.white,
      surface: blackShade,
      onSurface: Colors.white
  );

  //dark mode colors
  static const Color darkGreyHighlight = Color.fromARGB(255, 45, 45, 45);
  static const hintTextDark = Color(0xFFEBEBEF);
  static const buttonColorSchemeDark = ColorScheme(
      brightness: Brightness.light,
      primary: accent1,
      onPrimary: Colors.white,
      secondary: blackShade,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      background: Color(0xFF68686C),
      onBackground: Colors.white,
      surface: blackShade,
      onSurface: Colors.white
  );
}