import 'package:happy_plants/shared/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonStyle {
  static final buttonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateColor.resolveWith((Set<MaterialState> states) {
      return AppColors.accent1;
    }),
  );
}
