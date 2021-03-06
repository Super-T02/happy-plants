import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_plants/shared/utilities/app_colors.dart';
import 'package:happy_plants/shared/utilities/custom_text_styles.dart';

class MyAppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.accent1,
    errorColor: Colors.redAccent,
    bottomAppBarColor: AppColors.lightWhiteHighlight,
    unselectedWidgetColor: AppColors.darkGreyHighlight,

    // AppBar Style
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.grayShade,
      titleTextStyle: CTextStyles.headerTextStyleLight,
    ),

    // Text Styles
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyText1: CTextStyles.normalTextLight,
      headline3: CTextStyles.headline3light,
      subtitle2: CTextStyles.textFieldHintStyleLight,
    ),

    // Icon Styles
    iconTheme: const IconThemeData(color: AppColors.accent1),

    // Button Theme
    buttonTheme: const ButtonThemeData(
      colorScheme: AppColors.buttonColorSchemeLight,
    ),

    // List Styles
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.darkGrey,
      textColor: AppColors.darkGrey,
      enableFeedback: true,
    ),

    // Radio Button Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected) ||
            states.contains(MaterialState.focused)) {
          return AppColors.accent1;
        } else {
          return AppColors.darkGrey;
        }
      }),
    ),

    // Input styles
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: CTextStyles.textFieldHeadingLight,
      hintStyle: CTextStyles.textFieldHintStyleLight,
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(16.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grayShade, width: 0.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.accent1, width: 2.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      fillColor: AppColors.grayShade,
      filled: true,
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkGrey,
    primaryColor: AppColors.accent1,
    errorColor: Colors.redAccent,
    bottomAppBarColor: AppColors.darkGreyHighlight,
    unselectedWidgetColor: Colors.white,

    // AppBar Style
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blackShade,
      titleTextStyle: CTextStyles.headerTextStyleDark,
    ),

    // Text Styles
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyText1: CTextStyles.normalTextDark,
      headline3: CTextStyles.headline3dark,
      subtitle2: CTextStyles.textFieldHintStyleDark,
    ),

    //Icon theme
    iconTheme: const IconThemeData(color: AppColors.accent1),

    // Button Theme
    buttonTheme: const ButtonThemeData(
      colorScheme: AppColors.buttonColorSchemeDark,
    ),

    // List Styles
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.grayShade,
      textColor: AppColors.grayShade,
      enableFeedback: true,
    ),

    // Radio Button Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected) ||
            states.contains(MaterialState.focused)) {
          return AppColors.accent1;
        } else {
          return AppColors.grayShade;
        }
      }),
    ),

    //Input theme
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: CTextStyles.textFieldHeadingDark,
      hintStyle: CTextStyles.textFieldHintStyleDark,
      iconColor: AppColors.whiteShade,
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(16.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blackShade, width: 0.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.accent1, width: 2.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      fillColor: AppColors.blackShade,
      filled: true,
    ),
  );
}
