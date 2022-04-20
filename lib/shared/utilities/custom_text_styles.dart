import 'package:flutter/material.dart';
import 'app_colors.dart';

class CTextStyles {
  static const primaryButton = TextStyle(color: Colors.white,);


  static const authButtonTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.whiteShade);


  // Light
  static const normalTextLight = TextStyle(
      color: AppColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w500);
  static const textFieldHintStyleLight = TextStyle(
      color: AppColors.hintTextLight, fontSize: 14, fontWeight: FontWeight.w500);
  static const headerTextStyleLight = TextStyle(
      color: AppColors.darkGrey, fontSize: 28, fontWeight: FontWeight.w700);
  static const textFieldHeadingLight = TextStyle(
      color: AppColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w500);
  static const headline3light = TextStyle(
      color: AppColors.darkGrey, fontSize: 21, fontWeight: FontWeight.w500);

  // Dark
  static const normalTextDark = TextStyle(
      color: AppColors.whiteShade, fontSize: 16, fontWeight: FontWeight.w500);
  static const textFieldHintStyleDark = TextStyle(
      color: AppColors.hintTextDark, fontSize: 14, fontWeight: FontWeight.w500);
  static const headerTextStyleDark = TextStyle(
      color: AppColors.whiteShade, fontSize: 28, fontWeight: FontWeight.w700);
  static const textFieldHeadingDark = TextStyle(
      color: AppColors.whiteShade, fontSize: 16, fontWeight: FontWeight.w700);
  static const headline3dark = TextStyle(
      color: AppColors.whiteShade, fontSize: 21, fontWeight: FontWeight.w500);

}