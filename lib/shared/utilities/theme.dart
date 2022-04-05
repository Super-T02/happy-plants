import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_plants/shared/utilities/app_colors.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';

class MyAppTheme {

  // Light Theme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.accent1,
    errorColor: Colors.redAccent,
    bottomAppBarColor: AppColors.lightWhiteHighlight,
    unselectedWidgetColor: AppColors.darkGreyHighlight,

    // Text Styles
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyText1: CTextStyles.normalTextLight,
    ),




    // Icon Styles
    iconTheme: const IconThemeData(color: AppColors.accent1),



    // Input styles
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: CTextStyles.textFieldHeading,
      hintStyle: CTextStyles.textFieldHintStyleLight,
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(16.0),
      ),
      enabledBorder:  OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.grayShade,
            width: 0.0
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.accent1,
            width: 2.0
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      fillColor: AppColors.grayShade,
      filled: true,
    ),
  );



  // Dark Theme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkGrey,
    primaryColor: AppColors.accent1,
    bottomAppBarColor: AppColors.darkGreyHighlight,
    unselectedWidgetColor: Colors.white,


    // Text theme
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyText1: const TextStyle(
            color: Colors.white
      ),
      caption: const TextStyle(
          color: Colors.white
      ),
    ),


    //Icon theme
    iconTheme: const IconThemeData(
      color: AppColors.accent1,
    ),


    //Input theme
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.white),
      ),

      labelStyle: TextStyle(
          color: Colors.white
      ),
    ),

  );
}
